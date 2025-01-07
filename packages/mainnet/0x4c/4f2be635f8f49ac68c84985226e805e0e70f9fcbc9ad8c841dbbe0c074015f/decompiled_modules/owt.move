module 0x4c4f2be635f8f49ac68c84985226e805e0e70f9fcbc9ad8c841dbbe0c074015f::owt {
    struct OWT has drop {
        dummy_field: bool,
    }

    entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<OWT>, arg1: 0x2::coin::Coin<OWT>) {
        0x2::coin::burn<OWT>(arg0, arg1);
    }

    entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OWT>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<OWT>>(0x2::coin::mint<OWT>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: OWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OWT>(arg0, 9, b"OWT", b"Owlit Token", b"Owlit Token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<OWT>>(0x2::coin::mint<OWT>(&mut v2, 1000000000 * 0x2::math::pow(10, 9), arg1), @0x87448429b1cf7511a80c553cc26419c8798fdf617635c434896ee7113db21472);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OWT>>(v2, @0x87448429b1cf7511a80c553cc26419c8798fdf617635c434896ee7113db21472);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OWT>>(v1);
    }

    entry fun waiver(arg0: 0x2::coin::TreasuryCap<OWT>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OWT>>(arg0);
    }

    // decompiled from Move bytecode v6
}

