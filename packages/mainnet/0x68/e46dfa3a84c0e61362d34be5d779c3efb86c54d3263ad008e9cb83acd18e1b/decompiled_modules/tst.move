module 0x68e46dfa3a84c0e61362d34be5d779c3efb86c54d3263ad008e9cb83acd18e1b::tst {
    struct TST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TST>(arg0, 6, b"TST", b"test ", b"dont buy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1755162566164.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TST>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

