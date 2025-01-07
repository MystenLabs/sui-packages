module 0xd4886379bdeb0ecd768b3d89e49c93c8c052f73155463890c862833569e1170f::mobi {
    struct MOBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBI>(arg0, 9, b"MOBi", b"MOBI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-legislative-sawfish-352.mypinata.cloud/ipfs/QmWNHd1eKmAXMoBof5LaAh9pEMBencN9KumfJ8KapCFzFF?pinataGatewayToken=qwXZ2V8f36cUnXhRN8WejldrMXAV9ybajZho4GEPLei95CQZ1fgKR_W8BqgDfTVM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOBI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBI>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOBI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<MOBI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

