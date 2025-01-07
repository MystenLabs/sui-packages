module 0xab5e39d9f3a96299889068a2b24433c843176e64ff963e91abdeda1bcc150d14::guzuta {
    struct GUZUTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUZUTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUZUTA>(arg0, 6, b"GUZUTA", b"Sui Guzuta", b"GUZUTA token, the latest sensation in the crypto world, is poised to redefine the meme coin space with its dynamic community and innovative approach. Inspired by the unique orange ghost from the iconic PAC-MAN game, the GUZUTA token is not just a meme coin  it is a movement. With the aim of building a strong and engaged community, GUZUTA is determined to create a space where its holders can thrive, while keeping trading simple and efficient with a no-tax policy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020011_3ed97a2f16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUZUTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUZUTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

