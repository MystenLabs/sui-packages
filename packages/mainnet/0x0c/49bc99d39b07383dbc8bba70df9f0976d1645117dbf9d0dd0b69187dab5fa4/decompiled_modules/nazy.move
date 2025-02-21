module 0xc49bc99d39b07383dbc8bba70df9f0976d1645117dbf9d0dd0b69187dab5fa4::nazy {
    struct NAZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAZY>(arg0, 6, b"NAZY", b"NazYe", b"The meme token for the biggest Nazi of our generation", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_2_fc60a3038c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

