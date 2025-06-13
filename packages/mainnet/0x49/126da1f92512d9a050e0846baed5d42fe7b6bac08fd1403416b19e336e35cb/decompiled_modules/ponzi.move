module 0x49126da1f92512d9a050e0846baed5d42fe7b6bac08fd1403416b19e336e35cb::ponzi {
    struct PONZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONZI>(arg0, 6, b"Ponzi", b"ponziaccelerator", b"ponziaccelerator accelerates", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreieeq3pmni7dfmv2wpv3mszgjyv2wjnbvniim3jhqlfmac76sipuyi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PONZI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

