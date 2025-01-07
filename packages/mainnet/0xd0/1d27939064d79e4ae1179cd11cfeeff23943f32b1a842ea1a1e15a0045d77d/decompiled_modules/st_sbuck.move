module 0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck {
    struct ST_SBUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_SBUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_SBUCK>(arg0, 9, b"ST_SBUCK", b"Staked SBUCK", b"yield bearing sBUCK collect the rewards from different strategies created by Strater Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTSPtmG45f3CvnfzGTw7upoeTvadYmf58sF4JPwA97qkg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST_SBUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_SBUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

