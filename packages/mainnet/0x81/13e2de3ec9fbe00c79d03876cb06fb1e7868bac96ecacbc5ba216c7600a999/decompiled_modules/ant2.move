module 0x8113e2de3ec9fbe00c79d03876cb06fb1e7868bac96ecacbc5ba216c7600a999::ant2 {
    struct ANT2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANT2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANT2>(arg0, 6, b"Ant2", b"ant", b"antantantantantant", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730894484639.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANT2>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANT2>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

