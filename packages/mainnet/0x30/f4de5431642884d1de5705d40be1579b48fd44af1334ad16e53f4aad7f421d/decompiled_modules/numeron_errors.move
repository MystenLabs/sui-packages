module 0x30f4de5431642884d1de5705d40be1579b48fd44af1334ad16e53f4aad7f421d::numeron_errors {
    public fun already_in_battle_error(arg0: bool) {
        assert!(arg0, 9223372543662555162);
    }

    public fun already_in_encounter_error(arg0: bool) {
        assert!(arg0, 9223372234423795721);
    }

    public fun already_registered_error(arg0: bool) {
        assert!(arg0, 9223372131344187395);
    }

    public fun balance_too_low_error(arg0: bool) {
        assert!(arg0, 9223372371863273489);
    }

    public fun cannot_move_error(arg0: bool) {
        assert!(arg0, 9223372096984317953);
    }

    public fun invalid_choice_error(arg0: bool) {
        assert!(arg0, 9223372337503404047);
    }

    public fun invalid_direction_error(arg0: bool) {
        assert!(arg0, 9223372303143534605);
    }

    public fun item_not_found_error(arg0: bool) {
        assert!(arg0, 9223372509302751255);
    }

    public fun monster_not_found_error(arg0: bool) {
        assert!(arg0, 9223372474942881815);
    }

    public fun not_in_current_map_error(arg0: bool) {
        assert!(arg0, 9223372406223142931);
    }

    public fun not_in_encounter_error(arg0: bool) {
        assert!(arg0, 9223372268783665163);
    }

    public fun not_registered_error(arg0: bool) {
        assert!(arg0, 9223372165704056837);
    }

    public fun not_teleport_point_error(arg0: bool) {
        assert!(arg0, 9223372578022424604);
    }

    public fun not_your_monster_error(arg0: bool) {
        assert!(arg0, 9223372440583012373);
    }

    public fun space_obstructed_error(arg0: bool) {
        assert!(arg0, 9223372200063926279);
    }

    // decompiled from Move bytecode v6
}

