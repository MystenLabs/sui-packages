module 0x6324b61d5f4de172ddb214aa5a83f4dcd8515c2d398ef7699007afd9aefe9a0e::sdr {
    struct SDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDR>(arg0, 6, b"SDR", b"SUIDER", b"The Suipreme Meme Lord of the Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_a08d6167b6.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

