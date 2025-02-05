module 0xb5bf1d70f583f489ea675329dd2e9683089dcf092f8de608c954d98546611f4::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 9, b"QUI", b"QUI", b"TESTTTTTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://baobariavungtau.com.vn/dataimages/202212/original/images1775623_7m3.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOON>>(v2);
    }

    // decompiled from Move bytecode v6
}

