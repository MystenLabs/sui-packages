module 0x8cbcbb732437d44bffc8fc434b33aa575be548a3dd62b5d7f8fd4c39eaa39a01::sei_sui {
    struct SEI_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEI_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEI_SUI>(arg0, 9, b"seiSUI", b"Sei Staked SUI", b"Sei Staked Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/cc6e4e0b-9c32-4489-b08a-03be1b624b3f/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEI_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEI_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

