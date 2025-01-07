module 0xd4566411124fbc569f788857e4af7b481fc1170f868c5ce31550d1b03bf6cef8::test_token {
    struct TEST_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEST_TOKEN>(arg0, 6, b"test", b"test", b"its just a test token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.ibb.co.com/hgzBkYX/istockphoto-1218296719-612x612.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TEST_TOKEN>(&mut v2, 7777777777777000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEST_TOKEN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEST_TOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

