module 0xb9fba3f0b36130bd752e442791f13194c1d07c7b10f19515829ac0ffb5649c1e::jelly {
    struct JELLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JELLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JELLY>(arg0, 6, b"JELLY", b"immortal jellyfish", b"JellyFish", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigjoka2r23e7rxt22x27gaecs34ifasaib5yutkzgr4c5vr7ejxkm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JELLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JELLY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

