module 0xd72556ec6bc77b19c05ccf0f75fd995308688af95419113fae82195d4e8dbcf3::tasotoken {
    struct TASOTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TASOTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TASOTOKEN>(arg0, 6, b"TASOTOKEN", b"TASOTOKEN", b"Launched on Odyssey", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TASOTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TASOTOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

