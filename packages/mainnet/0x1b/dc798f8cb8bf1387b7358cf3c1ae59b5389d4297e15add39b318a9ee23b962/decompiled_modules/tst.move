module 0x1bdc798f8cb8bf1387b7358cf3c1ae59b5389d4297e15add39b318a9ee23b962::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 9, b"tst", b"tst", b"asdfa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://storage.googleapis.com/raidenx-prod/logo/sui/0x06864a6f921804860930db6ddbe2e16acdf8504495ea7481637a1c8b9a8fe54b::cetus::CETUS.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TST>(&mut v2, 1100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TST>>(v2);
    }

    // decompiled from Move bytecode v6
}

