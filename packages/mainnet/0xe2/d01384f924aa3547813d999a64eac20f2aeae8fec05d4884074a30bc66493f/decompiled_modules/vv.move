module 0xe2d01384f924aa3547813d999a64eac20f2aeae8fec05d4884074a30bc66493f::vv {
    struct VV has drop {
        dummy_field: bool,
    }

    fun init(arg0: VV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VV>(arg0, 6, b"VV", b"fdasfads", b"fdasfdasfgadsf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreictyhzshznstmsgx6freun5fl7jo7vaelzs4qwxdyqq5vsntkzyda")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VV>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

