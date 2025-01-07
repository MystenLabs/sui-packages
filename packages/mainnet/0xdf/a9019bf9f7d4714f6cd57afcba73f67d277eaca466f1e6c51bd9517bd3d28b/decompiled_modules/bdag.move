module 0xdfa9019bf9f7d4714f6cd57afcba73f67d277eaca466f1e6c51bd9517bd3d28b::bdag {
    struct BDAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDAG>(arg0, 6, b"BDAG", b"BlackDAG SUI", b"BlackDag on SUI -- Created history in presale history raised over $93M", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bdag_8e9ac53a47.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

