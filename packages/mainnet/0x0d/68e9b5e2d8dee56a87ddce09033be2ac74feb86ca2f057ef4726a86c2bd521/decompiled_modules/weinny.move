module 0xd68e9b5e2d8dee56a87ddce09033be2ac74feb86ca2f057ef4726a86c2bd521::weinny {
    struct WEINNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEINNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEINNY>(arg0, 6, b"WEINNY", b"Weinny on sui", x"245745494e4e592069732061206d656d6520696e73706972656420627920746865207765696e657220646f6773203a206c61756e6368696e67206f6e200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Omj_O_Vh_D7_400x400_b2e27a7779.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEINNY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEINNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

