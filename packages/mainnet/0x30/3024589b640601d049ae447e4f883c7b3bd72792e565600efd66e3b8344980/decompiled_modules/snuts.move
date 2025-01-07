module 0x303024589b640601d049ae447e4f883c7b3bd72792e565600efd66e3b8344980::snuts {
    struct SNUTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUTS>(arg0, 6, b"SNUTS", b"SNUT - Arc on Sui", x"5377696d6d696e6720746f75726e616d656e7420737461727473206f6e204d6f766570756d702e0a0a4e6f74206120636f70792c206a757374207468696e6b696e6720696e2073696d706c79206e65742c20697420697320776861742061206361746368696e6720766962652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Oj_Zdgpc_400x400_83db3418d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

