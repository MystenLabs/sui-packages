module 0x16b4efa1647c753becc83fffdac16b9df0e81566a0bab3bc4b62a8299282311c::first_edition {
    struct FirstEdition has drop {
        dummy_field: bool,
    }

    public fun first_edition(arg0: &0x16b4efa1647c753becc83fffdac16b9df0e81566a0bab3bc4b62a8299282311c::fishing_star::AdminCap) : FirstEdition {
        FirstEdition{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

