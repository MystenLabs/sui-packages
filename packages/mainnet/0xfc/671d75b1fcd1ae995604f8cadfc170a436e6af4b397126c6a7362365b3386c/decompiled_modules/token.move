module 0xfc671d75b1fcd1ae995604f8cadfc170a436e6af4b397126c6a7362365b3386c::token {
    struct TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKEN>(arg0, 3, b"CSUI", b"CSUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b""))), arg1);
        let v2 = v0;
        let v3 = @0xf2581c7da4e2930316c7dd38547c807e1607b6916e45af360f3f69eeaa693747;
        0x2::coin::mint_and_transfer<TOKEN>(&mut v2, 100000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKEN>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

