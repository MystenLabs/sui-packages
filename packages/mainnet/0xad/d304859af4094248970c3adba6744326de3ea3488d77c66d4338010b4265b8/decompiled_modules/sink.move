module 0xadd304859af4094248970c3adba6744326de3ea3488d77c66d4338010b4265b8::sink {
    struct SINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINK>(arg0, 6, b"Sink", b"sinkbowl", b"zzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifh2oytkfdzm5bp74tgwutk52jvol6ndapoq556a7k5khuu5pkrc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SINK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

