module 0x5e44626e6f91393136409dab5e28e1d7a28153d170fd5e8c2c854ea93f3dcde1::fomo {
    struct FOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMO>(arg0, 9, b"FOMO", b"FOMO", b"Ride the wave or miss out as usual.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgflip.com/28fj3w.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOMO>(&mut v2, 4206942069000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

