module 0x8acb3daaaa1bc33d13fc4eacf3caafbd00a8a955344b79e91b02c9f438a1a64a::seel {
    struct SEEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEEL>(arg0, 6, b"SEEL", b"SELLONSUI", b"The cutes pokemoon seel on Suinetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiem3cuxk7sqawxyovtayuths3t2qisqtiksu5jzmkeypvw2opkpzu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SEEL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

