module 0xc8e04ac00b5b45857c982be227678ae897b0eac4d8fe284a6cc644675d3989f3::stf {
    struct STF has drop {
        dummy_field: bool,
    }

    fun init(arg0: STF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STF>(arg0, 6, b"STF", b"STARFISH", b"A starfish wandering in the sea, afraid of being eaten by big fish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_25_11_154827dfbf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STF>>(v1);
    }

    // decompiled from Move bytecode v6
}

