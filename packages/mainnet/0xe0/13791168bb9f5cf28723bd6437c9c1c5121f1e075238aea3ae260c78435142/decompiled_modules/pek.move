module 0xe013791168bb9f5cf28723bd6437c9c1c5121f1e075238aea3ae260c78435142::pek {
    struct PEK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEK>(arg0, 6, b"PEK", b"PEKACHU", b"AUTISTIC PIKACHU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiea26q5tuxvncf6afpxc6c6gyppyuxzq64ys74og2nxy56jvyjg3u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PEK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

