module 0x986d5134f9677ed5dd55cffb1abad3011a7a42c5b905e11496d51aabe4dad55::a1 {
    struct A1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1>(arg0, 6, b"A1", b"Agent1", b"Agent one , A1", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736562571762.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

