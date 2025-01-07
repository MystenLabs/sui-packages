module 0x99565f32a297041e4b36d5dd16bb32883327e6a6ead0912dea27866bec811026::dope {
    struct DOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOPE>(arg0, 6, b"DOPE", b"Doge Pepe", b"Woof there, Frens! I'm DogePepe, the fusion of two iconic memes, here to bring double the delight to your virtual adventures. With Doge's wow-factor and Pepe's rare charm, I'm the ultimate crossover sensation. Get ready for a paw-some, frog-tastic time  DogePepe style!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001876_b7dcb1df2c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

