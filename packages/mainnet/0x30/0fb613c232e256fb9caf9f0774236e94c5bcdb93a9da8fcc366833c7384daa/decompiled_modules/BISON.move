module 0x300fb613c232e256fb9caf9f0774236e94c5bcdb93a9da8fcc366833c7384daa::BISON {
    struct BISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISON>(arg0, 6, b"BISON", b"BISON", b"BISON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmUe9LspLqo5z9mzYZRj97ivsdPdbQWcBdhXcK9iNNFyHf")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BISON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

