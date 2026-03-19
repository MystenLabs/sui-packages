module 0x2ecdab7fcf1bafc101348f8f08dc8a22d845295c9e78c8a898710c65ec87be7e::boop {
    struct BOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOP>(arg0, 6, b"BOOP", b"BOOP SUI", b"A little bunny hopped onto the Sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreid6eecnfg6tyxqsppqy5nvkpfvyei4tdin32xhjffnbfrufa5prve")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOOP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

