module 0x6c1389aa8b0501f6da1ba1273146db2ed3c9060d1b85a15cd6d63c8a29a0a187::qlong {
    struct QLONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: QLONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QLONG>(arg0, 9, b"QLONG", b"Qinglong Description The Tesla killer grows stronge", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/HTkGIhjXQAAFz_k.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<QLONG>>(0x2::coin::mint<QLONG>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QLONG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QLONG>>(v2, 0x2::address::from_u256(0));
    }

    // decompiled from Move bytecode v7
}

