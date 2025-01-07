module 0xe4a9c4ce5a5f8db99cf3b8a6eaa37805c381d4b0866ef1f7a5c205fc62c6b835::chompe {
    struct CHOMPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOMPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOMPE>(arg0, 6, b"Chompe", b"Chompe Sui", x"43686f6d7065206973204c61756e6368696e6720746f20746865204d6f766570756d70210a546865206375746573742063726f6320696e2063727970746f2069732061626f757420746f206d6f6f6e212047657420696e206561726c79206f6e207468652043686f6d7065204d6f766570756d70206c61756e636821", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1bb25f204274555_66a64f92983f2_f55fba13e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOMPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOMPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

