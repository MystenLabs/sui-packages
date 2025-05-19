module 0xedf6569a32ce0bbf3406ff1bc8baad24885b563345e7529576236bb126506937::nemos {
    struct NEMOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEMOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEMOS>(arg0, 6, b"NEMOS", b"NEMO SUI", b"Hello im nemos, Nice to meet you chad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiazgyhvtj52eiulbu2pxiotdk3rsoffwfqbk2ggk6og7ie342cixm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEMOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NEMOS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

