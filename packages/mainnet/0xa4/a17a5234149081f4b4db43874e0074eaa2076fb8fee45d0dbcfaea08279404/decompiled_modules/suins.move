module 0xa4a17a5234149081f4b4db43874e0074eaa2076fb8fee45d0dbcfaea08279404::suins {
    struct SUINS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINS>(arg0, 6, b"SuiNS", b"SuiNSdapp", b"our web3 identity for all things Sui! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y_Sa_I9u_J1_400x400_99d2827e68.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINS>>(v1);
    }

    // decompiled from Move bytecode v6
}

