module 0xa231cf1fcfb4d433a33f0e96cafb77002596067a98abc3b3d4d3d5bab993e9d4::sbbg {
    struct SBBG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBBG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBBG>(arg0, 9, b"SBBG", b"SBBG", b"Sui Bit Bridge", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cloudflare-ipfs.com/ipfs/QmfTe4XqRegTBAGv7j9zpcqK9wnEDg9Bb52mQufAdcFQ4T")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBBG>>(v1);
        0x2::coin::mint_and_transfer<SBBG>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SBBG>>(v2);
    }

    // decompiled from Move bytecode v6
}

