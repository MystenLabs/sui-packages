module 0x6cbf071cadfa1d0cc611d488f70fd89248d922de2b1e4dac39ce79d516f00c9f::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"BLUE", b"BlueFood Token", b"The world's first sustainable Marine Aquaculture Token (Token). To promote sustainable blue food development and maintain marine Aquaculture resources.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://gateway.irys.xyz/KuTIVGn1Xb1wveRHRbfJzGPclApzZTO7Mtb5bh1-R7U"))), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUE>>(v1, v2);
    }

    // decompiled from Move bytecode v6
}

