module 0x2cff9333053241c844eeecb604791ade224e5d82d4c7cde890d1ded959793e9f::ndd {
    struct NDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<NDD>(arg0, 6, b"NDD", b"nd", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRggBAABXRUJQVlA4WAoAAAAQAAAAFwAAFwAAQUxQSLwAAAABgFtt27LmxSqnc5+DBfjpveWwg7OBuzt0jEBchvCUnsqTN/JZZICIUNi2baPspPMNEBKdHcTEe/GgFTRcy0RwneC29g/NF1dTOzbVTAu+4J5OJI+94s2XknngXmJZ0nWCh+Q0j3nGNA3gOMLvKQEjhy9xrjpqIKGN8ZfAvURhesEk+WZqBYWqmgACxgrp3g+05DHPXAH0Xzh0lsZFi1zBYYh3OBBCd43XOiFmeIkzgO87Of1CV9MrwL8RAFZQOCAmAAAA0AIAnQEqGAAYAD5tNJZHpCMiISgIAIANiWkAAD2joAD++5zAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDD>>(v1);
    }

    // decompiled from Move bytecode v6
}

