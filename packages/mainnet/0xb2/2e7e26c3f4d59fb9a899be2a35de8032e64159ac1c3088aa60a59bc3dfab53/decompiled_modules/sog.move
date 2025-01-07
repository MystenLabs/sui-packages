module 0xb22e7e26c3f4d59fb9a899be2a35de8032e64159ac1c3088aa60a59bc3dfab53::sog {
    struct SOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOG>(arg0, 6, b"SOG", b"SQUIRREL IN A CLOTH", x"24534f470a0a4a757374204120537175697272656c20696e206120436c6f74680a0a4e6f20736f6369616c7321210a0a4c6574732070726f7665207520646f6e74206e65656420736f6369616c20746f206265207375636365737366756c20616c6c20796f75206e65656420746f20646f20697320627579202620686f6c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_a421eafe_e4d4_4da7_bc33_c35fbe1b23bd_fafd8cc012.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

