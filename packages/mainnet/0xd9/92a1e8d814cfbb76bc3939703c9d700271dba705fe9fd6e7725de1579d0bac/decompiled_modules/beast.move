module 0xd992a1e8d814cfbb76bc3939703c9d700271dba705fe9fd6e7725de1579d0bac::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAST>(arg0, 9, b"BEAST", b"OFFICIAL MrBEAST COIN", x"476f2057617463682042656173742047616d6573206f6e20534f4c21200a0a4974732074696d6520746f2067657420696e206f6e20746865204f6666696369616c204d724265617374204d656d6520436f696e20206c65747320474f2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmfKXMambvMtMzoBgY9dsa4JZAiHztcx2eyfgsJzzKRKFd")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BEAST>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAST>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

