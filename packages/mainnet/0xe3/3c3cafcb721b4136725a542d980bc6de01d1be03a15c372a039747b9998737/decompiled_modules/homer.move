module 0xe33c3cafcb721b4136725a542d980bc6de01d1be03a15c372a039747b9998737::homer {
    struct HOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMER>(arg0, 6, b"HOMER", b"Homer The Simpsons", x"436865636b206f757420486f6d657227732070726f7068656379207468617420707265646963746564205472756d70277320707265736964656e7469616c2077696e2024486f6d65720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/457b7fb6dea43f0d4854b2f5c510d8e7_c23dbfc741.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

