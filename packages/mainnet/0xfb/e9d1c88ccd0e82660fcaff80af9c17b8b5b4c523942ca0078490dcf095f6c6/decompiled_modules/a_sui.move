module 0xfbe9d1c88ccd0e82660fcaff80af9c17b8b5b4c523942ca0078490dcf095f6c6::a_sui {
    struct A_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: A_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_SUI>(arg0, 9, b"a SUI", b"a SUI", b"MP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<A_SUI>(&mut v2, 111000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_SUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<A_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

