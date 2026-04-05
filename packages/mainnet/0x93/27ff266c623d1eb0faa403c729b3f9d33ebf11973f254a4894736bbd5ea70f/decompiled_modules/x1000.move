module 0x9327ff266c623d1eb0faa403c729b3f9d33ebf11973f254a4894736bbd5ea70f::x1000 {
    struct X1000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X1000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<X1000>(arg0, 6, b"X1000", b"x 1000", b" ", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<X1000>(&mut v2, 10000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<X1000>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<X1000>>(v2);
    }

    // decompiled from Move bytecode v6
}

