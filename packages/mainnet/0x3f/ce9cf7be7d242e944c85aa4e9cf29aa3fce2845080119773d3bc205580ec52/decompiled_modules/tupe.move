module 0x3fce9cf7be7d242e944c85aa4e9cf29aa3fce2845080119773d3bc205580ec52::tupe {
    struct TUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUPE>(arg0, 6, b"TUPE", b"Turtle Pepe", b"The very first Turtle Pepe on SUI gonna win the race in a world of meme coins on SUI at crazy speed! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/t4_Z_So_U_Yp_400x400_0fec982d0f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

