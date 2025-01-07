module 0x1c80cad2c917b1da3361518662f7973b7080a4704c08093d371d17c979afc8a2::superhippo {
    struct SUPERHIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERHIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERHIPPO>(arg0, 6, b"SUPERHIPPO", b"SuperHippo", b"The world needs heroes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/325_c4a459d3f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERHIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERHIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

