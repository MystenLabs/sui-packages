module 0x92b608477dd8d8b02ec2d3e9cc5ff8d6a479cc0e2356cc8239462c9a4d82c294::bullrun {
    struct BULLRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BULLRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BULLRUN>(arg0, 6, b"BULLRUN", b"BTCETHLTCBUSHOBAMATRUMPBIDENSUI", x"4254434554484c5443425553484f42414d415452554d50424944454e535549200a4953204c49544552414c4c592041204d454d4520434f494e2e0a4e4f205554494c4954592e204e4f20524f41444d41502e204e4f2050524f4d495345532e204e4f2042554c4c534849542e0a4e4f204558504543544154494f4e204f462046494e414e4349414c2052455455524e2e0a4a5553542031303025204d454d45532e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihky2utwzrkzalee3ri2ptxdtgpwer2mj2oqfdgpumgk5nwq4jcq4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BULLRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BULLRUN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

