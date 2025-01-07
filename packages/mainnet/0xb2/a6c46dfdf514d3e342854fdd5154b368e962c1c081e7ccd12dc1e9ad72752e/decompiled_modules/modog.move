module 0xb2a6c46dfdf514d3e342854fdd5154b368e962c1c081e7ccd12dc1e9ad72752e::modog {
    struct MODOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MODOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MODOG>(arg0, 6, b"MODOG", b"Mother Dog", b"Popular meme MotherDog vibes Mom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/motherdog_logo_251a144b4e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MODOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MODOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

