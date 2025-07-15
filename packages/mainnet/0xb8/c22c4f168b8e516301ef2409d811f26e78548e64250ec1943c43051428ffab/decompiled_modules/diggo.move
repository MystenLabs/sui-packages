module 0xb8c22c4f168b8e516301ef2409d811f26e78548e64250ec1943c43051428ffab::diggo {
    struct DIGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIGGO>(arg0, 6, b"DIGGO", b"Diggo The Dog", b"Who controls the meme controls the universe, and the meme is under the control of Diggo.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih2k4fasxtorpk4cmjole455yka3flz666rmskxbxbhjdiat6hqvq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DIGGO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

