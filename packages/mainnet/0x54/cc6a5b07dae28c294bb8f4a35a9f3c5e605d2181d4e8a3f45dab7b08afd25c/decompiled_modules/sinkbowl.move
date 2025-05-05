module 0x54cc6a5b07dae28c294bb8f4a35a9f3c5e605d2181d4e8a3f45dab7b08afd25c::sinkbowl {
    struct SINKBOWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SINKBOWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SINKBOWL>(arg0, 6, b"SINKBOWL", b"BOWL SINK", b"welcome to sinkbowl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifh2oytkfdzm5bp74tgwutk52jvol6ndapoq556a7k5khuu5pkrc4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SINKBOWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SINKBOWL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

