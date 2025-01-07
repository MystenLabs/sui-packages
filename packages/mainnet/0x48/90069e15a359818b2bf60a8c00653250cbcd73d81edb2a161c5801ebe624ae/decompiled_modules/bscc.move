module 0x4890069e15a359818b2bf60a8c00653250cbcd73d81edb2a161c5801ebe624ae::bscc {
    struct BSCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSCC>(arg0, 6, b"SYMBOL", b"BSCC", b"DESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"url")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

