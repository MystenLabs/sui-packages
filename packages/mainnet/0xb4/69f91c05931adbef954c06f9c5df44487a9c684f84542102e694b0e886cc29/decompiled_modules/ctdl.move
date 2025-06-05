module 0xb469f91c05931adbef954c06f9c5df44487a9c684f84542102e694b0e886cc29::ctdl {
    struct CTDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTDL>(arg0, 6, b"CTDL", b"CITADEL", b"the first fully functional social media platform powerd by web 3 on the sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreideb5b7zyhz6xgmcxzqyokgnwee26h7qyixveycznfgbvtbzbgq2i")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CTDL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

