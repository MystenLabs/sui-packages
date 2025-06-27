module 0xf21e4b33b27d49e00e56ea0bec890a438a8df05d6115c72ab517e245e8284b03::shin {
    struct SHIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIN>(arg0, 6, b"SHIN", b"SHINOBISUI", b"Let's journey to the moon with the lone Shinobi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihvg4nllajtra26g5vpdq27v7bzmpby2edu2yynbw55wusm537iku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHIN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

