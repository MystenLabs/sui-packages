module 0xa3b32b0a851144eb3068aeaa14fb9bc8a134231753b12ed69ab7b649290c9dc8::puff_dadad {
    struct PUFF_DADAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFF_DADAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFF_DADAD>(arg0, 9, b"PUFF DADAD", b"PUFF DADAD", b"plop on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PUFF_DADAD>(&mut v2, 3000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFF_DADAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFF_DADAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

