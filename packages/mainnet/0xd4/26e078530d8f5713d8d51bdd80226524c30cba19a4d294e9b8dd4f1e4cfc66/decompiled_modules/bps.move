module 0xd426e078530d8f5713d8d51bdd80226524c30cba19a4d294e9b8dd4f1e4cfc66::bps {
    struct BPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPS>(arg0, 6, b"BPS", b"Birds Pump Sui", b"Hi Folks! I'm a classic Birds! I have a long, magic story before landscaping on Sui. I like to pump so high, so far, love worms, and make friends. On my way to Binance, I met my mate, Turbos. Yes, Bird pumps Sui, Bird loves Turbos. Chirp!!! Chirp!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003104679.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BPS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

