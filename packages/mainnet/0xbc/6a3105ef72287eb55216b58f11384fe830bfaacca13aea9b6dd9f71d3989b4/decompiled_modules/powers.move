module 0xbc6a3105ef72287eb55216b58f11384fe830bfaacca13aea9b6dd9f71d3989b4::powers {
    struct POWERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POWERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POWERS>(arg0, 6, b"Powers", b"Kenny Sui Powers", b"Sol..youre out. Kenny Powers is fucking in.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5030_c87c560ecd.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POWERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POWERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

