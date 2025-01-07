module 0x49df10da8805ea8b7646a596e09435d53574be05003a7a158e8d50938b5cf01d::suifly {
    struct SUIFLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLY>(arg0, 6, b"SuiFly", b"FlySui", x"41204865726f205269736573206f6e205375692e2e2e200a41726520796f7520726561647920666f7220746865206461776e206f662061206e6577206572613f200a5374617920616c6572742c20666f722074686520537569204865726f20697320636f6d696e6720616e64206e6f7468696e672077696c6c2065766572206265207468652073616d6520616761696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SSI_y_X5_400x400_2e48890858.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

