module 0xe8e39da84c184c2756e4acbc96bfc741aa01e58c5a954f7e51198b03998c02af::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"SEELONSUI", b"Cutteat pokemoon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiem3cuxk7sqawxyovtayuths3t2qisqtiksu5jzmkeypvw2opkpzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

