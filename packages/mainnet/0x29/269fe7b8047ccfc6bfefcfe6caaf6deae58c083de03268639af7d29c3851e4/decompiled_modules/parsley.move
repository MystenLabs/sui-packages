module 0x29269fe7b8047ccfc6bfefcfe6caaf6deae58c083de03268639af7d29c3851e4::parsley {
    struct PARSLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARSLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARSLEY>(arg0, 6, b"PARSLEY", b"Parsley & Fish", b"Let's grow like a parsley branch and cook and flavour all the fish in the place.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731343622634.36")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PARSLEY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARSLEY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

