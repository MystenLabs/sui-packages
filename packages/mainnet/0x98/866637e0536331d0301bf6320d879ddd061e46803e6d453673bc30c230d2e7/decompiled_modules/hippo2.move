module 0x98866637e0536331d0301bf6320d879ddd061e46803e6d453673bc30c230d2e7::hippo2 {
    struct HIPPO2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO2>(arg0, 9, b"HIPPO2", b"HIPPO2 Token", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/commons/f/f2/Portrait_Hippopotamus_in_the_water.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HIPPO2>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPPO2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO2>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

