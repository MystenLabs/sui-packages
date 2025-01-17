module 0x78db10db197bc9d114a364fe1c7d83b1ed6720a333b749b860153ac7661aeb0c::flovv {
    struct FLOVV has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLOVV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLOVV>(arg0, 6, b"FLOVV", b"Flovv AI", b"Flovv is a no-code AI platform designed to help you create and manage intelligent agents effortlessly. Whether you're automating tasks, analyzing data, or building workflows, Flovv simplifies AI integration for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250117_234854_948_72a0cbde9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLOVV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLOVV>>(v1);
    }

    // decompiled from Move bytecode v6
}

