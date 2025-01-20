module 0xb2398e0f16c2b4b0e9cd08045fbf1cf940f20ebc1b3511641d4c48f43812f627::norxt {
    struct NORXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORXT>(arg0, 6, b"NORXT", b"NoRug NoX NoTelegram", x"4e4f20527567202d204e4f2058202d204e4f2054656c656772616d0a4a75737420747275737420616e64206665656c696e67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000098390_8fd1e52184.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORXT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORXT>>(v1);
    }

    // decompiled from Move bytecode v6
}

