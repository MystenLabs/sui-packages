module 0xda4025ba236d3349321f1a25ea48001256029dd004920be192745a47d91ff286::noodles {
    struct NOODLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLES>(arg0, 9, b"NOODLES", b"NOODLES", b"suinoodles.com", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://red-legislative-sawfish-352.mypinata.cloud/ipfs/QmTgsNCYGYtqetgZamnXJo1azhsxMBR5KJ8JDtAFuWvBuc?pinataGatewayToken=qwXZ2V8f36cUnXhRN8WejldrMXAV9ybajZho4GEPLei95CQZ1fgKR_W8BqgDfTVM")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOODLES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLES>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<NOODLES>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<NOODLES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

