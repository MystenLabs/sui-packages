module 0x5445b4d3211839e6246965bce1956f8d6644d17c87a3695a070594b11520072::czout {
    struct CZOUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CZOUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CZOUT>(arg0, 6, b"CZOUT", b"CZ's Journey From Prison to Freedom", b"Celebrating CZ's journey from prison to the real world, CZOUT symbolizes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CZ_s_Journey_From_Prison_to_Freedom_e672556284.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CZOUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CZOUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

