module 0xebcd5be02f2d35ef1256cc8e67271c0553b94ffb6e842e13e938dea8d54e9f63::abu {
    struct ABU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABU>(arg0, 9, b"ABU", b"ABU", b"ABUU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ABU>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABU>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ABU>>(v1);
    }

    // decompiled from Move bytecode v6
}

