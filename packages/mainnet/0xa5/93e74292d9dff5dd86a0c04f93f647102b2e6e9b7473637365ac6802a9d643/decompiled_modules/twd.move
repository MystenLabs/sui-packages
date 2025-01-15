module 0xa593e74292d9dff5dd86a0c04f93f647102b2e6e9b7473637365ac6802a9d643::twd {
    struct TWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWD>(arg0, 9, b"TWD", b"TWD", b"SUI TWD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/FYgPptas1RVnQUxRfv84Qukvi4O5VVz6cfcO90hSDCU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TWD>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWD>>(v2, @0xc491205c46412bb7474579c8203e420384fa22a7c8ea214481edd21d502f5975);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWD>>(v1);
    }

    // decompiled from Move bytecode v6
}

