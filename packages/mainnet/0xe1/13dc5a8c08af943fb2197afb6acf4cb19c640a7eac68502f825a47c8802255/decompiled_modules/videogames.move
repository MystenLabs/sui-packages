module 0xe113dc5a8c08af943fb2197afb6acf4cb19c640a7eac68502f825a47c8802255::videogames {
    struct VIDEOGAMES has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIDEOGAMES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIDEOGAMES>(arg0, 9, b"VIDEOGAMES", x"f09f91be566964656f67616d6573", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VIDEOGAMES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIDEOGAMES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIDEOGAMES>>(v1);
    }

    // decompiled from Move bytecode v6
}

