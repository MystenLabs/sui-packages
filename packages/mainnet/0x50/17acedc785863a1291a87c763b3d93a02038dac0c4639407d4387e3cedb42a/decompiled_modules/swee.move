module 0x5017acedc785863a1291a87c763b3d93a02038dac0c4639407d4387e3cedb42a::swee {
    struct SWEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWEE>(arg0, 6, b"SWEE", b"Its pronounced Swee", x"5375692069732070726f6e6f756e6365642061730a7320772065650a0a7309736f756e6473206c696b6520746865090927732709696e2027736f270a7709736f756e6473206c696b6520746865090927772709696e202777696e270a656509736f756e6473206c696b652074686509092765652709696e2027736565270a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6549_5d49e8f002.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

