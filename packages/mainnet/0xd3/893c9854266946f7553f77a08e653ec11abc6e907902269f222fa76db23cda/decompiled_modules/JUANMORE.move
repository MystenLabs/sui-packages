module 0xd3893c9854266946f7553f77a08e653ec11abc6e907902269f222fa76db23cda::JUANMORE {
    struct JUANMORE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUANMORE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUANMORE>(arg0, 9, b"JUANMORE", x"5365c3b16f72204a75616e204d6f7265", b"Ladies with gentle hands this is my alter ego. $JUANMORE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1746252811896029184/ZUMi1ukO_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUANMORE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUANMORE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JUANMORE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<JUANMORE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

