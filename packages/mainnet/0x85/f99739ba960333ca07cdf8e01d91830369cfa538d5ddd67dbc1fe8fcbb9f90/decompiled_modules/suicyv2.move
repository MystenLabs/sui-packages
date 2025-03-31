module 0x85f99739ba960333ca07cdf8e01d91830369cfa538d5ddd67dbc1fe8fcbb9f90::suicyv2 {
    struct SUICYV2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICYV2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICYV2>(arg0, 6, b"SUICYV2", b"Suicy V2", b"COMMUNITY CLAIMED, COMMUNITY DRIVEN, WE ARE SUICY.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6729_e8371393bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICYV2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICYV2>>(v1);
    }

    // decompiled from Move bytecode v6
}

