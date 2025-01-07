module 0xb37826c87cc3b6cc26cb68ec30f9b9172a2152dacfe1ba5769a0935be92337b1::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 6, b"Degen", b"Degem SUI", x"4669727374206f662069742773206b696e642d20412066756e2077617920746f20446567656e207769746820796f7572205355492e2020576562203320726f756c657474652067616d65206d61646520666f72207468652053554920636f6d6d756e69747920746f2067616d626c6520746f6765746865723a0a0a68747470733a2f2f646567656e7375692e6c6f6c2f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STRICKER_00000_fd1a8b4b9e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

