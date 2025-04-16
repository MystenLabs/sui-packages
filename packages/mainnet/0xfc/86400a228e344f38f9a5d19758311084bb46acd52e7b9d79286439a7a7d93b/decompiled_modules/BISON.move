module 0xfc86400a228e344f38f9a5d19758311084bb46acd52e7b9d79286439a7a7d93b::BISON {
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

