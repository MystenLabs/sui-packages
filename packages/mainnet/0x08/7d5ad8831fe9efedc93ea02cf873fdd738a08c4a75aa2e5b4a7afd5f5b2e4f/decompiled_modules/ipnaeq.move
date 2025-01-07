module 0x87d5ad8831fe9efedc93ea02cf873fdd738a08c4a75aa2e5b4a7afd5f5b2e4f::ipnaeq {
    struct IPNAEQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPNAEQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPNAEQ>(arg0, 6, b"ipnaeq", b"ipnaeq", b"daaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IPNAEQ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPNAEQ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPNAEQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

