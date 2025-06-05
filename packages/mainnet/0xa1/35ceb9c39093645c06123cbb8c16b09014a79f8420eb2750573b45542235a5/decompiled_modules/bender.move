module 0xa135ceb9c39093645c06123cbb8c16b09014a79f8420eb2750573b45542235a5::bender {
    struct BENDER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BENDER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BENDER>(arg0, 6, b"BENDER", b"IAM BOT", b"Kill All Jeeters And Ruggers to Save The Planet.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreie2acnptw4m6oylpah7eq6ybrsam7p4ku25ifml4plaqvywrelrwy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BENDER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BENDER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

