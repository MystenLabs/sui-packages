module 0x8532dae68e62d42d6938f62ea1a40550c31a0bd35a2e23f48130e460fcce7b21::st_buck {
    struct ST_BUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_BUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_BUCK>(arg0, 9, b"ST_BUCK", b"Staked SBUCK", b"yield bearing sBUCK collect the rewards from different strategies created by Strater Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTSPtmG45f3CvnfzGTw7upoeTvadYmf58sF4JPwA97qkg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST_BUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_BUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

