module 0xec165e601878fe2e09e34829696290dc96d0eb77a82de9a9476dff2d7d8a1b98::suiwif {
    struct SUIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIWIF>(arg0, 6, b"SuiWIF", b"Suiwifhat", x"5375695749462061696d7320746f2061747472616374207573657273207365656b696e672061206d6f72652066756e20616e6420656e676167696e6720657870657269656e636520636f6d706172656420746f20747261646974696f6e616c20696e766573746d656e742d666f637573656420636f696e732e0a0a456e6a6f7920746865206372617a792072616964207769746820636f6d6d756e6974792c2066756c6c792064726976656e2062792069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/03cec9bc_8df5_41da_8d3c_df868405095a_6824191531.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

