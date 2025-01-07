module 0xdef36e42d0d07559de31f18042da61a3c18475626a4fdd4ec0818d8b38e5e2b3::uspepe {
    struct USPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: USPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<USPEPE>(arg0, 6, b"USPEPE", b"AMERICAN PEPE ON SUI", b"The National Meme of the United States, your second chance!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/uspepeb_169872f407.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

