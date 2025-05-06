module 0x23bb50ebf6df6a4b84b5a7b412ee0d2a455666acd5fbcbc0acbf2566c975f0fe::aeromesi {
    struct AEROMESI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEROMESI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AEROMESI>(arg0, 6, b"AEROMESI", b"Sui Detective Aeromesi", b"Buy my coin to support my work! Ride the $SUI Wave of Aeromesi Investigating Criminals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibgdzxu4y74qrb6oacuheu6oc43oejw5nsfrimjyhjancmebepoee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEROMESI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AEROMESI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

