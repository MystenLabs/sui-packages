module 0x34d8a776ef1107c927a4d13fd4712442b62cb4930a6ecf8730bd8a1add5c51bc::sniffy {
    struct SNIFFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIFFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIFFY>(arg0, 6, b"SNIFFY", b"SNIFFY DOG", x"486527732061206375746520646f67207769662063757465206661636520616e6420686520736e6966660a0a54656c656772616d3a2068747470733a2f2f742e6d652f736e6966667963746f0a583a2068747470733a2f2f782e636f6d2f63746f736e69666679", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250103_061055_580_d4ea19a476.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIFFY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIFFY>>(v1);
    }

    // decompiled from Move bytecode v6
}

