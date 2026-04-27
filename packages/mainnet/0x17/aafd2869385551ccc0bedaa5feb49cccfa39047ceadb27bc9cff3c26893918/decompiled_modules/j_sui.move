module 0x17aafd2869385551ccc0bedaa5feb49cccfa39047ceadb27bc9cff3c26893918::j_sui {
    struct J_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: J_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<J_SUI>(arg0, 9, b"jSUI", b"jjj Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRggBAABXRUJQVlA4WAoAAAAQAAAAFwAAFwAAQUxQSLwAAAABgFtt27LmxSqnc5+DBfjpveWwg7OBuzt0jEBchvCUnsqTN/JZZICIUNi2baPspPMNEBKdHcTEe/GgFTRcy0RwneC29g/NF1dTOzbVTAu+4J5OJI+94s2XknngXmJZ0nWCh+Q0j3nGNA3gOMLvKQEjhy9xrjpqIKGN8ZfAvURhesEk+WZqBYWqmgACxgrp3g+05DHPXAH0Xzh0lsZFi1zBYYh3OBBCd43XOiFmeIkzgO87Of1CV9MrwL8RAFZQOCAmAAAA0AIAnQEqGAAYAD5tNJZHpCMiISgIAIANiWkAAD2joAD++5zAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<J_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<J_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

