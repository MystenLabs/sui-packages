module 0x8a808aea39deae79bbe4b3c19371677a113853e5602034c0951db8ea8eeda323::st_sui {
    struct ST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ST_SUI>(arg0, 9, b"ST_SBUCK", b"Staked SBUCK", b"yield bearing sBUCK collect the rewards from different strategies created by Strater Protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTSPtmG45f3CvnfzGTw7upoeTvadYmf58sF4JPwA97qkg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ST_SUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ST_SUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

