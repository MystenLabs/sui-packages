module 0x983209012926126e614a1543798445c0392003fc5beeb08d55d2a65b5833cedd::Pepetroll {
    struct PEPETROLL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPETROLL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPETROLL>(arg0, 9, b"TROLPE", b"Pepetroll", b"listen to me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/GzaKh9SWsAAZDDi?format=jpg&name=large")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPETROLL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPETROLL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

