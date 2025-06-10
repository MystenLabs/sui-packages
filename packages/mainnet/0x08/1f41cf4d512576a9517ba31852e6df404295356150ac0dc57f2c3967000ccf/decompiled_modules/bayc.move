module 0x81f41cf4d512576a9517ba31852e6df404295356150ac0dc57f2c3967000ccf::bayc {
    struct BAYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAYC>(arg0, 6, b"BAYC", b"Buy Apes Yell CASH!", b"This is BAYC reimagined as a meme-powered, NFT-infused, pride-fueled rocket ship straight to the stratosphere.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeigt5clcajmqklzofm3gxe7vfyohuw4gifu74thdprcckpxegf6jvy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BAYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

