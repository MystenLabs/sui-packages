module 0xae91008aee2e7396f8aa5e56b192c2ad11f79a6580660e6403d9dab99bb9c91::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 6, b"SUISHI", b"SUI SUSHI", b"CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI CHOP SUISHI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_14_131352_5af5b8b433.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

