module 0xe25b9379876dbf6f7f5fb82c428cc1d5705e4f0221225e5198b4f3dd98c7b57c::faptos {
    struct FAPTOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAPTOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAPTOS>(arg0, 6, b"Faptos", b"Testing this shit again", b"Aptos Faptos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_23_f0b4588014.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAPTOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAPTOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

