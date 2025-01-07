module 0x459a4b3cbcc400fe6038239e7d4f7bd2852bab1468458bf4e4fbcbe3e4e54138::viora5 {
    struct VIORA5 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: VIORA5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<VIORA5>(arg0, 9, b"VIORA5", b"VIORA IS ONLINE", x"f09f91be2056494f5241204953204f4e4c494e4520f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTAM9X8EzuiFXWGdjjHpqxAMjbug2TwuF1iKSpedzTmhx"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<VIORA5>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIORA5>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VIORA5>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VIORA5>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

