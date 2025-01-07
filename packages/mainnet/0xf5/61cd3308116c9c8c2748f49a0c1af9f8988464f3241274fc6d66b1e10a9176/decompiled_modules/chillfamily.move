module 0xf561cd3308116c9c8c2748f49a0c1af9f8988464f3241274fc6d66b1e10a9176::chillfamily {
    struct CHILLFAMILY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHILLFAMILY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHILLFAMILY>(arg0, 6, b"CHILLFAMILY", b"just a CHILLFAMILY", b"just a CHILLFAMILY taking over the sui chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/chill_family_dd16744ee7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHILLFAMILY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHILLFAMILY>>(v1);
    }

    // decompiled from Move bytecode v6
}

