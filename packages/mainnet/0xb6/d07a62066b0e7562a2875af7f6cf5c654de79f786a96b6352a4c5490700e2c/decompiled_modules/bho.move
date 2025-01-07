module 0xb6d07a62066b0e7562a2875af7f6cf5c654de79f786a96b6352a4c5490700e2c::bho {
    struct BHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHO>(arg0, 6, b"Bho", b"Baby Hippo", b"coming for the mama!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hippo_cc4bfea0ac.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

