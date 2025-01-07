module 0x31c6a5109d98d938c7b777b25f7b39e4d0bd143cefe4964cafa52280df4a9bc9::bieber {
    struct BIEBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIEBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIEBER>(arg0, 6, b"BIEBER", b"Bieber", b"The Bieber Memecoin is poised to become a leading crypto project globally through strategic partnerships, celebrity endorsements and community-driven initiatives. Join us as we build a vibrant, engaged and empowered community that will drive the future of memecoins.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1724684683427_5696675abaf97a158eb9251d20efa1fe_9bdbea4c2c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIEBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIEBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

