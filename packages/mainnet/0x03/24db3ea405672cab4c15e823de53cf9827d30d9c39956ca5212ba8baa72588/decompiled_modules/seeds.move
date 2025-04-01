module 0x324db3ea405672cab4c15e823de53cf9827d30d9c39956ca5212ba8baa72588::seeds {
    struct SEEDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEDS>(arg0, 9, b"SEEDs", b"SEED", b"Plant and earn SEED right within Telegram @seedupdates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/dfbdb7aaecb427026a50e52bf67c2f58blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEEDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

