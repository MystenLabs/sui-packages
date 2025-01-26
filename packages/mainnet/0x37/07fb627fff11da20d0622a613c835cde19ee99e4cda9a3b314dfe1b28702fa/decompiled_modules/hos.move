module 0x3707fb627fff11da20d0622a613c835cde19ee99e4cda9a3b314dfe1b28702fa::hos {
    struct HOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOS>(arg0, 9, b"HOS", b"Health OS", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUAtoTis29LrJJVS3f7ZNgzU3ZDsfYgmaRrRDrt8jsynF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HOS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

