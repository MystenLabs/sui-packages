module 0x265d907b5c64cce4d487cdaed7d7b0026f517a3344896b4c9c3d13da646cd604::suimo {
    struct SUIMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMO>(arg0, 6, b"SUIMO", b"SUIMO WRESTLER", b"The fattest, strongest dude, taking over the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_16_09_06_52_1eab36ef7a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

