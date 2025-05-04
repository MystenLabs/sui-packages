module 0x97d238fd9cb346090005200fc803d1ee0fb25d1124a2a41b379fd143f8b79253::barkitect {
    struct BARKITECT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARKITECT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARKITECT>(arg0, 9, b"BARKI", b"Barkitect", b"The token for dogs who (think they) invented DeFi.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeid7baqacg2lx5daq2wzeget2hubmiwx2vrjbkxussbnhn3vorwwom")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BARKITECT>(&mut v2, 1000000000000000000, @0xfb20acd7e2a2647568cb859bbe174ade70f49a7e9c762c3ff635ff4a0915dad9, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARKITECT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BARKITECT>>(v1);
    }

    // decompiled from Move bytecode v6
}

