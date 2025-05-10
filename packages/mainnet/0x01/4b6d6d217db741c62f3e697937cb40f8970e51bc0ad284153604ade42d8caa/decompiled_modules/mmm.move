module 0x14b6d6d217db741c62f3e697937cb40f8970e51bc0ad284153604ade42d8caa::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 6, b"MMM", b"mama", b"blob mama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrtgo5bbx2s6n3gafxdghum4ttdzfb7dfvau5kptgmkgnwd5xayi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MMM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

