module 0x81649bfcb2b2a69a0521ce0712799ea235693b3d46508020d50ad60532daec38::slfg {
    struct SLFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLFG>(arg0, 6, b"SLFG", b"SILLY FLAMINGO", b"Goofy, pink, and aiming for the stars. Silly Flamingo is all about fun and fortune.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_045329035_3e7279336b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLFG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLFG>>(v1);
    }

    // decompiled from Move bytecode v6
}

