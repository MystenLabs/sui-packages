module 0xcdca9421746dc35862061d9c7377103138c085a7c8a6d960d8feb79db5420ef::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"TST", b"First meme on the SuAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"undefined")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TST>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

