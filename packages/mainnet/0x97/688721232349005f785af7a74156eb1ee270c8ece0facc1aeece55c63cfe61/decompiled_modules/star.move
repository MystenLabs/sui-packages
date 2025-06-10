module 0x97688721232349005f785af7a74156eb1ee270c8ece0facc1aeece55c63cfe61::star {
    struct STAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAR>(arg0, 6, b"STAR", b"STARYU", b"Relaunched", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifft4kvl4r6ty3ziapsprddad5qvybhxm5cymand6fdnwnqyespkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

