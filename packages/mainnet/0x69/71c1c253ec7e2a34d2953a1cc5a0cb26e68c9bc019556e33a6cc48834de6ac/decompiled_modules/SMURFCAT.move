module 0x6971c1c253ec7e2a34d2953a1cc5a0cb26e68c9bc019556e33a6cc48834de6ac::SMURFCAT {
    struct SMURFCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMURFCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMURFCAT>(arg0, 6, b"SMURFCAT", b"Smurf Cat", b"We live. We love. We lie. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://uptos-pump.myfilebase.com/ipfs/QmSk8f4BVQtDhLPvvzX4YtJgUArEyqZt5QmnggDB6cSK7m")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMURFCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMURFCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

