module 0x7d41bf0534206042a2cde75a9eb84d23ef25db791066b583e97bd9b642679792::boop {
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

