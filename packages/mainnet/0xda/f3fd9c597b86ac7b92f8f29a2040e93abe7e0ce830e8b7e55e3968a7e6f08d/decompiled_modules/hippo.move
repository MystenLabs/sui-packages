module 0xdaf3fd9c597b86ac7b92f8f29a2040e93abe7e0ce830e8b7e55e3968a7e6f08d::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 9, b"HIPPO", b"HIPPO Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/f/f2/Portrait_Hippopotamus_in_the_water.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPO>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

