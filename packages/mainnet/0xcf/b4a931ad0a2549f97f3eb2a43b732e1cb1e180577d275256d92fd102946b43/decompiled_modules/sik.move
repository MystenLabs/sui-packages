module 0xcfb4a931ad0a2549f97f3eb2a43b732e1cb1e180577d275256d92fd102946b43::sik {
    struct SIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIK>(arg0, 6, b"Sik", b"jij", b"nope", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhntucrbkbeiwjvczrwzvpbtsirupmurrtkv4ght2p7tckek7odm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SIK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

