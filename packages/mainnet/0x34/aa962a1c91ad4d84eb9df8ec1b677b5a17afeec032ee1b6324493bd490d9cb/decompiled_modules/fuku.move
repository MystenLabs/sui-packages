module 0x34aa962a1c91ad4d84eb9df8ec1b677b5a17afeec032ee1b6324493bd490d9cb::fuku {
    struct FUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUKU>(arg0, 6, b"FUKU", b"BabyFuku onSui", b"Baby Fuku is inspired by kabosumama's new baby puppy, Fuku!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_22_25_34_eed22d7616.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

