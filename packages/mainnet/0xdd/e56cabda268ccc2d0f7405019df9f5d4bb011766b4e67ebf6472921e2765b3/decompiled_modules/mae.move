module 0xdde56cabda268ccc2d0f7405019df9f5d4bb011766b4e67ebf6472921e2765b3::mae {
    struct MAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAE>(arg0, 6, b"MAE", b"My Autistic Elon", b"Where is my son?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Elon2_a8c3f23a54.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

