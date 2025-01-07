module 0xe2ff8ca65af1df184e955d67239950daee15acc3cb0a14c74c3bde4a321acf99::ham {
    struct HAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAM>(arg0, 6, b"HAM", b"AstroChimp", b"HAM, The First Chimp In Space ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_RKLG_Vs_L_400x400_b36c147bc5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

