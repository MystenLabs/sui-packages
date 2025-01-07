module 0x2ee924150cd35bda6323c20801ef415e3abd8470605de6f00966eb2367cedb72::SUILION {
    struct SUILION has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILION>(arg0, 2, b"SUILION", b"Suilion", b"Making SUI the best for millions", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/PJ2YX0Nw/HWAAu-XA2-400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILION>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 100000000000, @0x5de881dba32cb336026aeb3d6c5e487b6297c3cb58578262f870e6b7114e7595, arg1);
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 100000000000, @0x5de881dba32cb336026aeb3d6c5e487b6297c3cb58578262f870e6b7114e7595, arg1);
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 100000000000, @0x5de881dba32cb336026aeb3d6c5e487b6297c3cb58578262f870e6b7114e7595, arg1);
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 100000000000, @0x5de881dba32cb336026aeb3d6c5e487b6297c3cb58578262f870e6b7114e7595, arg1);
        0x2::coin::mint_and_transfer<SUILION>(&mut v2, 100000000000, @0x5de881dba32cb336026aeb3d6c5e487b6297c3cb58578262f870e6b7114e7595, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILION>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

