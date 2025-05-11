module 0x6ad484ebd5a002f7fc5765e10b0446d9a568d8d8aa5294d1e695679200b49699::sfs {
    struct SFS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFS>(arg0, 6, b"SFS", b"SHIBFAN SUI", b"Community for sui memes. shiba lovers come here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicqznnhavs73iva5pjvaqvyicviobdis2exl22eaehmvnqk6rg7jq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SFS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

