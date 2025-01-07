module 0x383cf5ac6eb9fe1fe8b19ad2b8b10238bc3a40f8be191735748c519da0269aae::suibert {
    struct SUIBERT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBERT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBERT>(arg0, 6, b"Suibert", b"Bert on Sui", x"53657420796f757220495120746f204f20616e64206275792024537569626572740a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_edited_ff8c86e322.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBERT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBERT>>(v1);
    }

    // decompiled from Move bytecode v6
}

