module 0x459ccdfca11182128b2d068fce79d31312fb648a1a81a992465bc699ca7e0690::sfrope {
    struct SFROPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFROPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFROPE>(arg0, 6, b"SFROPE", b"SUI FROPE", b"Pepe the Frog is a popular internet meme used in a variety of contexts. In recent years it has also been appropriated by white supremacist.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3876_d1b2d6b072.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFROPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFROPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

