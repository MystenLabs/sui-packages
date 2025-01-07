module 0x55cc7811c55e8d3597f8fb49e0e5df1e7b7a2a49bb111c3bbdf256b6716b14b2::dsq {
    struct DSQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DSQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DSQ>(arg0, 6, b"dsq", b"dsq", b"erdefcd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DSQ>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DSQ>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DSQ>>(v1);
    }

    // decompiled from Move bytecode v6
}

