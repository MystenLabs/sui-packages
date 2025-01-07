module 0x132d1390cfcb3c1f4effaf1e826a6343d83e1aa4e9c4f08928338789e8a6c49c::motosui {
    struct MOTOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOTOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOTOSUI>(arg0, 6, b"MotoSUI", b"Moto Moto", b"Moto Moto isn't just a hippo he is a lifestyle. With his deep voice, slow swagger, and an ego the size of a watering hole, Moto Moto is an internet sensation for embodying the ultimate smooth operator. Moto Moto is the meme-worthy funky king we didn't know we needed on the SUI blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Moto_Moto_Avatar_1b4a605456.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOTOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOTOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

