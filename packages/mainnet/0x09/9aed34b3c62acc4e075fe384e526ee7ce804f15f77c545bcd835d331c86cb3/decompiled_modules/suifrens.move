module 0x99aed34b3c62acc4e075fe384e526ee7ce804f15f77c545bcd835d331c86cb3::suifrens {
    struct SUIFRENS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFRENS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFRENS>(arg0, 6, b"SuiFrens", b"Sui Frens", x"5375694672656e73206172652062656c6f76656420696d6167696e61746976652c20696e76656e74697665206372656174757265732074726176657273696e672074686520696e7465726e65742c207365656b696e672066656c6c6f772070696f6e6565727320746f206275696c64206e657720636f6e6e656374696f6e7320616e6420667269656e6473686970732e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Vps_Uz_Wc_A_Aul_5_4d4b0e085e.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFRENS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFRENS>>(v1);
    }

    // decompiled from Move bytecode v6
}

