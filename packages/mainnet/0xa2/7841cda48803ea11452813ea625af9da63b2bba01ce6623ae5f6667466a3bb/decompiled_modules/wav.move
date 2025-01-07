module 0xa27841cda48803ea11452813ea625af9da63b2bba01ce6623ae5f6667466a3bb::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 6, b"WAV", b"Wave Point", x"706c617920746f2041697264726f700a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dsadsa_01df8539da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

