module 0x29472b87559e36c955522062ca4bdfb81c3ece0d25f552169d156583c209ebc5::bmoc {
    struct BMOC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMOC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMOC>(arg0, 6, b"BMOC", b"COWINANCE", b"BMOC IS A MEME TOKEN WITH COW BUSINESS CONCEPT. PLAN ITS OWN FUTURE DEX, LAUNCHPAD, STAKING, WALLET, AND BMOC IS THE NATIVE COIN ON COWINANCE PROTOCOL.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/COWINANCE_HEAD_LOGO_76b95dfda6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMOC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMOC>>(v1);
    }

    // decompiled from Move bytecode v6
}

