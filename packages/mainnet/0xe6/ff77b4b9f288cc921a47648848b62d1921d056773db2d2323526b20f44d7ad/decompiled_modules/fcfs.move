module 0xe6ff77b4b9f288cc921a47648848b62d1921d056773db2d2323526b20f44d7ad::fcfs {
    struct FCFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FCFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FCFS>(arg0, 5, b"FCFS", b"FCFS coin", b"First come first serve", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://iili.io/JAqaVHb.png")), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<FCFS>(&mut v2, 100000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FCFS>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FCFS>>(v1);
    }

    // decompiled from Move bytecode v6
}

