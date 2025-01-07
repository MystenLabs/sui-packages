module 0xaaffbc27f2c5449362f83a4b23592ef5f074c650fec32f7f86c05389bf689bdd::hasbulla {
    struct HASBULLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASBULLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HASBULLA>(arg0, 6, b"HASBULLA", b"Hasbulla", b"The youngest, cutest baby in web3.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uca9_E6jl_400x400_adac6aa00e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HASBULLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HASBULLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

