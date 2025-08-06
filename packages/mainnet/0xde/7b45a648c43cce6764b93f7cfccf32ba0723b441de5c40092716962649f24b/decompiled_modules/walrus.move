module 0xde7b45a648c43cce6764b93f7cfccf32ba0723b441de5c40092716962649f24b::walrus {
    struct WALRUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALRUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALRUS>(arg0, 6, b"WALRUS", b"WALRUS SUI", b"Welcome to the next generation of data storage.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih5pukwtsczi4qzk4oleazle7dcu76ugx2vqdeacsmpablhy7fy4u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALRUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WALRUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

