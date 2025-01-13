module 0x4231ad34a4d8e8f1ee6a66ba06ff96fa290ff3b773ba08954c441b3608b03c0f::truths {
    struct TRUTHS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUTHS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TRUTHS>(arg0, 6, b"TRUTHS", b"infinite truths by SuiAI", b"the silent truths come roaring", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2123_22634303d6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRUTHS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUTHS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

