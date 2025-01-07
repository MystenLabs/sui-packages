module 0xef36016972765a2555cfc4b77b45c74fdbd15d8fd737beda4a93cceeb341e8df::hu {
    struct HU has drop {
        dummy_field: bool,
    }

    fun init(arg0: HU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HU>(arg0, 9, b"hu", b"hu", b"suilovehu", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-legislative-sawfish-352.mypinata.cloud/ipfs/QmQyPsierfU2VapyWkqANU3PutBgV64fbr5CiLH7rnbtgV?pinataGatewayToken=qwXZ2V8f36cUnXhRN8WejldrMXAV9ybajZho4GEPLei95CQZ1fgKR_W8BqgDfTVM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HU>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HU>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

