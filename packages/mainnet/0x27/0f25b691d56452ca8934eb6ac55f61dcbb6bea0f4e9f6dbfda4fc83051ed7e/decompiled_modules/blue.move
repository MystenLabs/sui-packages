module 0x270f25b691d56452ca8934eb6ac55f61dcbb6bea0f4e9f6dbfda4fc83051ed7e::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"Blue", b"BLUE", b"Blue is more than just a memecoin; we are a movement committed to building a safe and inclusive community. Our team consists of experienced blockchain experts focused on providing a transparent and profitable investment experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241017_144201_1d3954a406.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

