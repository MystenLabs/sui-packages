module 0x354138adb4cfd559c798294b926ae56950c88c47cfddcca87474127ce6855706::wukong {
    struct WUKONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUKONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUKONG>(arg0, 6, b"WUKONG", b"Sui Wukong", b"In the vast universe of blockchain, a shining star is rising, which perfectly combines ancient wisdom with modern technology. This is the SUNWUKONG token. SunWukong, which means the energy and wisdom of the sun and the flexibility and determination of Sun Wukong, combines traditional culture with the innovative spirit of blockchain to create a sacred guardian on the SUI chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000114501_7a8a110ab3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUKONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUKONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

