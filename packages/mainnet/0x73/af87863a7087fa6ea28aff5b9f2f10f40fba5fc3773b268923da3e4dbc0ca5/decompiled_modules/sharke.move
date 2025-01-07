module 0x73af87863a7087fa6ea28aff5b9f2f10f40fba5fc3773b268923da3e4dbc0ca5::sharke {
    struct SHARKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKE>(arg0, 6, b"SHARKE", b"SharkeSUI", b"let do it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/v_Hdx8_5t_400x400_e0d1418e74.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

