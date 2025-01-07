module 0x781b7416c1b3c0c04d56e19e85e836fc460374c8a2119da174151a44c4fb7a2d::suisl {
    struct SUISL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISL>(arg0, 6, b"Suisl", b"sea lion", x"54686520736561206c696f6e20647265616d73206f662077616e646572696e67207468726f7567682073706163652c206c6f6e67696e6720746f206c656170206f76657220746865206f6365616e20616e6420666c7920746f7761726473207468652064697374616e74206d6f6f6e2c206578706c6f72696e6720746865206d7973746572696573206f662074686520756e6b6e6f776e20636f736d6f732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_a_ae_a_2024_08_31_175335_185d20349f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISL>>(v1);
    }

    // decompiled from Move bytecode v6
}

