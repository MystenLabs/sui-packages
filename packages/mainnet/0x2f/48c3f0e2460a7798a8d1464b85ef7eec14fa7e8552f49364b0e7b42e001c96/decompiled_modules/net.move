module 0x2f48c3f0e2460a7798a8d1464b85ef7eec14fa7e8552f49364b0e7b42e001c96::net {
    struct NET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NET>(arg0, 9, b"NET", b"Network", b"Network Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NET>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NET>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NET>>(v1);
    }

    // decompiled from Move bytecode v6
}

