module 0x310336543b5fd5f400c0a68066eed5289f48216d5f445f47677d23ee99874623::SOONOGOCOIN {
    struct SOONOGOCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOONOGOCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOONOGOCOIN>(arg0, 8, b"Soonogo", b"Soonogo's coin", b"Soonogo's coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOONOGOCOIN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOONOGOCOIN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<SOONOGOCOIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SOONOGOCOIN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

