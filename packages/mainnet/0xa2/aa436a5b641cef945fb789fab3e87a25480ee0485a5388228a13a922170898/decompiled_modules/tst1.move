module 0xa2aa436a5b641cef945fb789fab3e87a25480ee0485a5388228a13a922170898::tst1 {
    struct TST1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST1>(arg0, 6, b"TST1", b"TEST-1", b"1234567890", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_43bebfd7bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TST1>>(v1);
    }

    // decompiled from Move bytecode v6
}

