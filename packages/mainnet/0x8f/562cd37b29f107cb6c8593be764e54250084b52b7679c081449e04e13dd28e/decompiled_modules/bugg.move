module 0x8f562cd37b29f107cb6c8593be764e54250084b52b7679c081449e04e13dd28e::bugg {
    struct BUGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGG>(arg0, 6, b"BUGG", b"BUGGED BUNNY", b"Revolutionizing the crypto world with innovation and transparency! Join the #BuggedBunny community and hop into the future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732446229276.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

