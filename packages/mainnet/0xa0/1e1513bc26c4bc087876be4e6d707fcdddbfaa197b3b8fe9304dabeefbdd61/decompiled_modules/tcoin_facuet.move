module 0xa01e1513bc26c4bc087876be4e6d707fcdddbfaa197b3b8fe9304dabeefbdd61::tcoin_facuet {
    struct TCOIN_FACUET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCOIN_FACUET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCOIN_FACUET>(arg0, 8, b"TCOIN_FACUET", b"TCOIN_FACUET", b"this is tcoin_facuet coin.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img2.baidu.com/it/u=2249492919,1307050096&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=504")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCOIN_FACUET>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<TCOIN_FACUET>>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TCOIN_FACUET>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<TCOIN_FACUET>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

