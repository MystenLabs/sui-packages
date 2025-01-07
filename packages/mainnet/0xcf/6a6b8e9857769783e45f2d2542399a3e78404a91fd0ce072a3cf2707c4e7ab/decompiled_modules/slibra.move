module 0xcf6a6b8e9857769783e45f2d2542399a3e78404a91fd0ce072a3cf2707c4e7ab::slibra {
    struct SLIBRA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLIBRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLIBRA>(arg0, 6, b"SLibra", b"SuiLibra", x"0a0a5375694c6962726120656d706f77657273207365616d6c657373207472616e73616374696f6e73206f6e205375692e0a5375694c6962726120697320646563656e7472616c697a6564207061796d656e74732c207265696d6167696e65642e0a5375694c69627261206973205375692773207072656d696572207574696c69747920746f6b656e2e0a5375694c69627261206f6666657273206566666f72746c657373207472616e73616374696f6e732077697468206c696d69746c65737320706f74656e7469616c2e0a5375694c6962726120756e6c6f636b73207468652066756c6c20706f74656e7469616c206f662053756927732065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9a2fddb4_3e22_498e_a551_f4af7aa89fa8_bd4a4e01d4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLIBRA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLIBRA>>(v1);
    }

    // decompiled from Move bytecode v6
}

