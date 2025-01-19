module 0x7aea756eb223fdfa1475e1f4e171561c53b5b17d861ef86eccbbe09b9be029bb::fred {
    struct FRED has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRED>(arg0, 6, b"FRED", b"Sui Fred", b"Say hello to Fred, the ultimate memecoin on Sui! Built for the community, by the community.  Together, were creating an ecosystem where ideas thrive, innovation leads, and everyone grows. Lets take Fred to the top of the Sui blockchain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000045145_f116574ee1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRED>>(v1);
    }

    // decompiled from Move bytecode v6
}

