module 0xc5bd8b221d8abefea1051f9b8c987d3d1741813660e43079f0a67d2b1d615f36::twrae {
    struct TWRAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWRAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWRAE>(arg0, 6, b"TWRAE", b"Trump Was Right About Everything", x"5472756d70205761732052696768742041626f75742045766572797468696e670a53554920535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250122_185806_193_8f39f2076b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWRAE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWRAE>>(v1);
    }

    // decompiled from Move bytecode v6
}

