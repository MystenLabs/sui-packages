module 0xbdc864a78549e81f5e74c8c585ebef4f5b0405ca6d9861484568196de0856a82::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 9, b"AAI", b"Agent AI ", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwKqWKPwtSFzq42wcMUpgdDCSqGwdKJIZ7sg&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<AAI>(&mut v2, 100000000000000000, @0x4ff800c3dc2521daf8061423388c078903c717cf462b4812f799cfdeda703d33, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

