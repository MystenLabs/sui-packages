module 0xb5ec5b5010d2ea121af7f8df9817ef8d0e51a67b59f5da7b6d2c68af1951dbf::psumo {
    struct PSUMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PSUMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PSUMO>(arg0, 6, b"PSUMO", b"Pepe Sumo On Sui", b"THE HEAVYWEIGHT CHAMPION OF MEMES! Join us: https://pepesumocoin.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_1_36_c4232b70dc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PSUMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PSUMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

