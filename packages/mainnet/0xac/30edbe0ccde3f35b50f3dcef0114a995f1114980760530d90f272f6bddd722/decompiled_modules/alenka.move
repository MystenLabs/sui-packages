module 0xac30edbe0ccde3f35b50f3dcef0114a995f1114980760530d90f272f6bddd722::alenka {
    struct ALENKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALENKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALENKA>(arg0, 6, b"ALENKA", b"Alenka", b"ALENKA the most sexiest token in the cryptoverse! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIRL_427e70c313.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALENKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALENKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

