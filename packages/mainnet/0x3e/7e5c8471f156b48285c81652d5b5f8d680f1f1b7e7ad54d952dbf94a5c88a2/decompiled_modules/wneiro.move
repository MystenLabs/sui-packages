module 0x3e7e5c8471f156b48285c81652d5b5f8d680f1f1b7e7ad54d952dbf94a5c88a2::wneiro {
    struct WNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WNEIRO>(arg0, 9, b"WNEIRO", b"Wrapped Neiro", b"Whapped Neiro Is meme On sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aquamarine-giant-muskox-172.mypinata.cloud/ipfs/QmeseZEBxuEYiQLBDwr66wkhRCqwpZQ9DWPCXozbMc99dY")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WNEIRO>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WNEIRO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

