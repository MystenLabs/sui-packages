module 0x709988647f17dae4dda65c4d4ec4c3dfb411ab9b19de8a93680d12911e749a7f::brmtv {
    struct BRMTV has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRMTV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRMTV>(arg0, 9, b"BRMTV", b"Vladimir Bormotov", b"bormotov personal coins project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bormotov.dev/bormotov-coin-250.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BRMTV>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRMTV>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRMTV>>(v1);
    }

    // decompiled from Move bytecode v6
}

