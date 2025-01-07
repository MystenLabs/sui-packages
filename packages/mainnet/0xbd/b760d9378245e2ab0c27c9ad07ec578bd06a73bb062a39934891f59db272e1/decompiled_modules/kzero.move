module 0xbdb760d9378245e2ab0c27c9ad07ec578bd06a73bb062a39934891f59db272e1::kzero {
    struct KZERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KZERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KZERO>(arg0, 6, b"KZERO", b"KILL ZERO", b"Just HOLD,The billionaire journey will begin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1463_0763601723.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KZERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KZERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

