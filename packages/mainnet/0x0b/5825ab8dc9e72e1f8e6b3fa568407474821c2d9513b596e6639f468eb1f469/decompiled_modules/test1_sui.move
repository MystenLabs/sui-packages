module 0xb5825ab8dc9e72e1f8e6b3fa568407474821c2d9513b596e6639f468eb1f469::test1_sui {
    struct TEST1_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST1_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST1_SUI>(arg0, 9, b"test1SUI", b"Test1 Staked SUI", b"Test SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn-icons-png.flaticon.com/512/4838/4838856.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST1_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TEST1_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

