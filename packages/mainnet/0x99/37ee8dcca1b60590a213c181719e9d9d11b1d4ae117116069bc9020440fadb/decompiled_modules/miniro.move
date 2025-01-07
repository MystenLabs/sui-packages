module 0x9937ee8dcca1b60590a213c181719e9d9d11b1d4ae117116069bc9020440fadb::miniro {
    struct MINIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MINIRO>(arg0, 6, b"MINIRO", b"MiniNeiro sui", x"234d696e694e6569726f2069732074686520796f756e6765722062726f74686572206f66206f757220676f6f6420667269656e64204e6569726f202d204d696e69204e6569726f206173706972657320746f206265206a757374206c696b6520686973206f6c6465722062726f7468657220207c205447203a2068747470733a2f2f742e6d652f6d696e694e6569726f5f6273630a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_4_3d46c5d46c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

