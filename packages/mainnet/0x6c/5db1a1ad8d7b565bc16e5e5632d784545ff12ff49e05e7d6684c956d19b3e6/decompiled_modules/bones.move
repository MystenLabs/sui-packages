module 0x6c5db1a1ad8d7b565bc16e5e5632d784545ff12ff49e05e7d6684c956d19b3e6::bones {
    struct BONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONES>(arg0, 6, b"BONES", b"BONES SUI", b"Mine Earn & Collect $BONES on Sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/5c2mok_Tk_400x400_489fa425a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONES>>(v1);
    }

    // decompiled from Move bytecode v6
}

