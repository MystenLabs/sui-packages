module 0x2f9166da7867b84ecff645310d6df76984bb4d4b08b60371aa33b0a716afc5ba::pumpkin {
    struct PUMPKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUMPKIN>(arg0, 6, b"Pumpkin", b"Pumpkin Sui", b"Embrace the magic of Pumpkin Sui, a token that delivers a patch of thrills and festive fun, filled with pumpkin-spiced surprises around every corner! Happy HODL or Boo!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_5_fa3fb8ef27.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPKIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPKIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

