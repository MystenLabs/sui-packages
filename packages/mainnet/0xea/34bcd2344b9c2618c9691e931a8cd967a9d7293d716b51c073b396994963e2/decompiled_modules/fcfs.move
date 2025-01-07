module 0xea34bcd2344b9c2618c9691e931a8cd967a9d7293d716b51c073b396994963e2::fcfs {
    struct FCFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCFS>(arg0, 9, b"FCFS", b"FCFScoin", b"First come first serve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JAFtG3B.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FCFS>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCFS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

