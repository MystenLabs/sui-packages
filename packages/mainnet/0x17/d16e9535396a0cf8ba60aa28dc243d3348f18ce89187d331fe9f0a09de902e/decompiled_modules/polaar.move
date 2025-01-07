module 0x17d16e9535396a0cf8ba60aa28dc243d3348f18ce89187d331fe9f0a09de902e::polaar {
    struct POLAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLAAR>(arg0, 6, b"Polaar", b"Polar Sui ", b"Experience the future of crypto with $POLAR Sui, the premium memecoin for the discerning investor. Coming soon on turbos.finance", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731241056604.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POLAAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLAAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

