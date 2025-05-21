module 0x283aaf9840e80a36a18836fe409edaccff4b4564d41dcb53929376b2ccb84bcb::chrz {
    struct CHRZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHRZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHRZ>(arg0, 6, b"CHRZ", b"CHARIZARD", b"Meet CHARIZARD - The legendary dragon whose fiery spirit forges paths and commands respect", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiatvob65ghazuqeewjxzaevpoghqh4hgwdugiayazzow4weduwntm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHRZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHRZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

