module 0x3bc89de1ce7ae4a6a0952fd004d48ab8a27eb0bc7d3f193feaf21d9d919a55a4::delorean {
    struct DELOREAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELOREAN, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 801 || 0x2::tx_context::epoch(arg1) == 802, 1);
        let (v0, v1) = 0x2::coin::create_currency<DELOREAN>(arg0, 6, b"DMC", b"DeLorean", b"Official DeLorean Web3 | Powering the future with $DMC on Sui Network. Buckle up for the next era of innovation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.filebase.io/ipfs/QmVpAhqGFXMKdL7RvPHe1Ue56qTWtdSH5oBqwDsYz88Pca"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DELOREAN>(&mut v2, 10000000000000000, @0x87b2d3e661ae7659bdc3ddeda5a3dc1960741a1c39a1986d56cc4d35481dc0b8, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELOREAN>>(v2, @0x87b2d3e661ae7659bdc3ddeda5a3dc1960741a1c39a1986d56cc4d35481dc0b8);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELOREAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

