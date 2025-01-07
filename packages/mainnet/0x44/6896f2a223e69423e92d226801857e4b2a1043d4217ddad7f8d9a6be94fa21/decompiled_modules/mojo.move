module 0x446896f2a223e69423e92d226801857e4b2a1043d4217ddad7f8d9a6be94fa21::mojo {
    struct MOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOJO>(arg0, 9, b"MOJO", b"Planet Mojo", b"Planet MOJO world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1812381403171962880/cfkAXGeb.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOJO>(&mut v2, 50000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOJO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

