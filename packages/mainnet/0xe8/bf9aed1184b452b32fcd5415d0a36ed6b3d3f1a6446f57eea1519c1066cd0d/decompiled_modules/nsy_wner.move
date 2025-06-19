module 0xe8bf9aed1184b452b32fcd5415d0a36ed6b3d3f1a6446f57eea1519c1066cd0d::nsy_wner {
    struct NSY_WNER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSY_WNER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NSY_WNER>(arg0, 6, b"Nsy wner", b"Nosey wiener", b"Just a nosey little wiener dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreigpb2lz2e22ndmz5nsdcfqz36au5tug2caavmu23qy6ssxozzqbie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSY_WNER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NSY_WNER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

