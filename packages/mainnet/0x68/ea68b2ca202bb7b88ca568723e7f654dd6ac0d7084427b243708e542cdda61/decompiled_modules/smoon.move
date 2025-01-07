module 0x68ea68b2ca202bb7b88ca568723e7f654dd6ac0d7084427b243708e542cdda61::smoon {
    struct SMOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMOON>(arg0, 6, b"SMOON", b"Suilor Moon", x"47657420726561647920746f20676f20746f20746865206d6f6f6e210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_71d8217654.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

