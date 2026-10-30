module 0x5453c3a65c510512aad2e593284430a83f6908b1bf06c6c2c802f5527bfbb124::my_example_token {
    struct MY_EXAMPLE_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY_EXAMPLE_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MY_EXAMPLE_TOKEN>(arg0, 6, b"MY_EXAMPLE", b"MyExample Token Name", b"MyExample Token Description", 0x1::option::none<0x2::url::Url>(), true, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY_EXAMPLE_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MY_EXAMPLE_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_EXAMPLE_TOKEN>>(v2);
    }

    // decompiled from Move bytecode v6
}

