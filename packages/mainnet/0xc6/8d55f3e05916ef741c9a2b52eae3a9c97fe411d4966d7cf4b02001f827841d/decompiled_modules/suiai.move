module 0xc68d55f3e05916ef741c9a2b52eae3a9c97fe411d4966d7cf4b02001f827841d::suiai {
    struct SUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIAI>(arg0, 6, b"SuiAi", b"Sui Ai", b"Launch and Co-Create Onchain AI Agents", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifxbesefbkeq34qqarbtj2n3ggt7iux32y5bjpdob6jqspbenzl3q")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

