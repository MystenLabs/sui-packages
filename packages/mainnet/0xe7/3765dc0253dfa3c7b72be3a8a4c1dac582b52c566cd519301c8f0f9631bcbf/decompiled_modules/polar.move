module 0xe73765dc0253dfa3c7b72be3a8a4c1dac582b52c566cd519301c8f0f9631bcbf::polar {
    struct POLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAR>(arg0, 6, b"Polar", x"506f6c61722053756920f09f92a7", b"Experience the future of crypto with $POLAR Sui, the premium memecoin for the discerning investor. Coming soon on turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731234829998.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

