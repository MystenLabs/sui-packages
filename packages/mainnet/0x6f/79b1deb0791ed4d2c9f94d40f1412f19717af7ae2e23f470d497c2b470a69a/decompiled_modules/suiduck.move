module 0x6f79b1deb0791ed4d2c9f94d40f1412f19717af7ae2e23f470d497c2b470a69a::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 9, b"SUIDUCK", b"Sui Duck", b"Official token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.pinimg.com/564x/44/61/b9/4461b9886de1894fd17608431ea03cb1.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDUCK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

