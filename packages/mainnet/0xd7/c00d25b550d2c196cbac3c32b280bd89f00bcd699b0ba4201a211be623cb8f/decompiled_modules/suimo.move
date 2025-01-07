module 0xd7c00d25b550d2c196cbac3c32b280bd89f00bcd699b0ba4201a211be623cb8f::suimo {
    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMO>(arg0, 6, b"SUIMO", b"Finding Suimo", b"Nemo's finally been found - on the $SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_16_55_17_3aeabae39f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

