module 0x1fe9dd2e2f09e9f6bf46f6a57949cf484bfb3e1354c43518ca8bb40e5f62ab0d::bm {
    struct BM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BM>(arg0, 6, b"BM", b"BadMorning", b"Not a GM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigdqk762qpquuvwfbcehywqbplkrt6pnzpdob5ytrk2tn35dteiua")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

