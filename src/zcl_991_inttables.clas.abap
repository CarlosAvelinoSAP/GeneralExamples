CLASS zcl_991_inttables DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_991_inttables IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "------------------ Standard table key ------------------

    "Standard table without explicit primary table key specification. Note that STANDARD
    "is not explicitly specified.
    "Implicitly, the standard key is used; all non-numeric table fields
    "make up the primary table key.
    DATA it1 TYPE TABLE OF zdemo_abap_fli.

    "Explicitly specifying STANDARD for a standard table.
    "Explicitly specifying the standard table key. It is the same as it1.
    DATA it2 TYPE STANDARD TABLE OF zdemo_abap_fli WITH DEFAULT KEY.

    "Hashed table with unique standard table key
    DATA it3 TYPE HASHED TABLE OF zdemo_abap_fli WITH UNIQUE DEFAULT KEY.

    "Sorted table with non-unique standard table key
    DATA it4 TYPE SORTED TABLE OF zdemo_abap_fli WITH NON-UNIQUE DEFAULT KEY.

    "Elementary line type; the whole table line is the standard table key
    DATA it5 TYPE TABLE OF i.

    "------------------ Primary table key ------------------

    "Specifying the primary table key
    "Standard tables: only a non-unique key possible
    "The following two examples are the same. NON-UNIQUE can be ommitted but is implicitly added.
    DATA it6 TYPE TABLE OF zdemo_abap_fli WITH NON-UNIQUE KEY carrid.
    DATA it7 TYPE TABLE OF zdemo_abap_fli WITH KEY carrid.

    "Sorted tables: both UNIQUE and NON-UNIQUE possible
    DATA it8 TYPE SORTED TABLE OF zdemo_abap_fli WITH UNIQUE KEY carrid connid.
    DATA it9 TYPE SORTED TABLE OF zdemo_abap_fli WITH NON-UNIQUE KEY carrid connid.

    "Hashed tables: UNIQUE KEY must be specified
    DATA it10 TYPE HASHED TABLE OF zdemo_abap_fli WITH UNIQUE KEY carrid.

    "Explicitly specifying the predefined name primary_key and listing the components.
    "The example is the same as it6 and it7.
    DATA it11 TYPE TABLE OF zdemo_abap_fli WITH KEY primary_key COMPONENTS carrid.

    "The following example is the same as it9.
    DATA it12 TYPE SORTED TABLE OF zdemo_abap_fli
      WITH NON-UNIQUE KEY primary_key COMPONENTS carrid connid.

    "Specifying an alias name for a primary table key.
    "Only possible for sorted/hashed tables.
    DATA it13 TYPE SORTED TABLE OF zdemo_abap_fli
      WITH NON-UNIQUE KEY primary_key
      ALIAS p1 COMPONENTS carrid connid.

    "Specifying a key that is composed of the entire line using the predefined table_line.
    "In the example, an alias name is defined for a primary table key.
    DATA it14 TYPE HASHED TABLE OF zdemo_abap_fli
      WITH UNIQUE KEY primary_key
      ALIAS p2 COMPONENTS table_line.

    "------------------ Empty key ------------------

    "Empty keys only possible for standard tables
    DATA it15 TYPE TABLE OF zdemo_abap_fli WITH EMPTY KEY.

    "Excursion: The inline declaration in a SELECT statement produces a standard table with empty key.
    SELECT * FROM zdemo_abap_fli INTO TABLE @DATA(it16).

    "------------------ Secondary table key ------------------

    "The following examples demonstrate secondary table keys that are possible for all table categories.
    DATA it17 TYPE TABLE OF zdemo_abap_fli                      "standard table
      WITH NON-UNIQUE KEY carrid connid                         "primary table key
      WITH UNIQUE SORTED KEY cities COMPONENTS carrid. "secondary table key

    DATA it18 TYPE HASHED TABLE OF zdemo_abap_fli               "hashed table
      WITH UNIQUE KEY carrid connid
      WITH NON-UNIQUE SORTED KEY airports COMPONENTS carrid.

    DATA it19 TYPE SORTED TABLE OF zdemo_abap_fli              "sorted table
      WITH UNIQUE KEY carrid connid
      WITH UNIQUE HASHED KEY countries COMPONENTS carrid.

    "Multiple secondary keys are possible
    DATA it20 TYPE TABLE OF zdemo_abap_fli
      WITH NON-UNIQUE KEY primary_key COMPONENTS carrid connid
      WITH NON-UNIQUE SORTED KEY cities COMPONENTS carrid
      WITH UNIQUE HASHED KEY airports COMPONENTS connid.

    "Alias names for secondary table keys (and also for the primary table key in the example)
    DATA it21 TYPE SORTED TABLE OF zdemo_abap_fli
      WITH NON-UNIQUE KEY primary_key ALIAS k1 COMPONENTS carrid connid
      WITH NON-UNIQUE SORTED KEY cities ALIAS s1 COMPONENTS carrid
      WITH UNIQUE HASHED KEY airports ALIAS s2 COMPONENTS carrid.

    "Example for using table keys and alias names using a LOOP AT statement.
    "All of the statements below are possible.
    "Note that if the secondary table key is not specified (and if the USING KEY addition is not
    "used in the example), the primary table key is respected by default.
    "Further ABAP statements, such as READ or MODIFY, are available in which the key can be
    "explicitly specified to process internal tables.
    LOOP AT it21 INTO DATA(wa) USING KEY primary_key.
      "LOOP AT it21 INTO DATA(wa) USING KEY k1.
      "LOOP AT it21 INTO DATA(wa) USING KEY cities.
      "LOOP AT it21 INTO DATA(wa) USING KEY s1.
      "LOOP AT it21 INTO DATA(wa) USING KEY airports.
      "LOOP AT it21 INTO DATA(wa) USING KEY s2.
      ...
    ENDLOOP.

  ENDMETHOD.
ENDCLASS.
