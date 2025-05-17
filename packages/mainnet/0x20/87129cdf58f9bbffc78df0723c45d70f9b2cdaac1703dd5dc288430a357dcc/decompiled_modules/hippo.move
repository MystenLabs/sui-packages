module 0x2087129cdf58f9bbffc78df0723c45d70f9b2cdaac1703dd5dc288430a357dcc::hippo {
    struct HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPPO>(arg0, 6, b"Hippo", b"Hippopotasui", b"Get ready to ride the wildest meme coin to the MOON Hippopotasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihcjfpymkozxk2smmbu7b2jeogutm57vhwhgp4tbwl42alivtcnuy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HIPPO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

