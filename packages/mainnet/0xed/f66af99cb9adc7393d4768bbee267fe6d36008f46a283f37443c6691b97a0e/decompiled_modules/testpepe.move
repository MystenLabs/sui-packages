module 0xedf66af99cb9adc7393d4768bbee267fe6d36008f46a283f37443c6691b97a0e::testpepe {
    struct TESTPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTPEPE>(arg0, 9, b"TestPepe", b"TestPepe", b"Dont buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.lanworks.com/wp-content/uploads/2017/02/test-button-1024x1024.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTPEPE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTPEPE>>(v2, @0xc8c4ef6b64b45ed49b0c258f784ba4a6545bed711e4d900518cfb694ee90547e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

