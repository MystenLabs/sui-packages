module 0x9cdeb9f3884a566ff5f8805a6ab972f36c38451c055e73d29014ca1977a31398::sfa {
    struct SFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFA>(arg0, 6, b"sfa", b"sfa", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SFA>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

