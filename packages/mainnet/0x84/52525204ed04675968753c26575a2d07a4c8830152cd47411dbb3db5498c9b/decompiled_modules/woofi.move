module 0x8452525204ed04675968753c26575a2d07a4c8830152cd47411dbb3db5498c9b::woofi {
    struct WOOFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOFI>(arg0, 9, b"WOOFI", b"Woofi the genius dog", b"Woof with us! Save the dogs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/cms/images/qqbIklXst5_hxgcO")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WOOFI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOOFI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOFI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

