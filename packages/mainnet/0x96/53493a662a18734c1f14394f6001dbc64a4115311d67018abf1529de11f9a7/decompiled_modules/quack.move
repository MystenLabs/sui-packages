module 0x9653493a662a18734c1f14394f6001dbc64a4115311d67018abf1529de11f9a7::quack {
    struct QUACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUACK, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch(arg1) == 663 || 0x2::tx_context::epoch(arg1) == 664, 1);
        let (v0, v1) = 0x2::coin::create_currency<QUACK>(arg0, 9, b"QUACK", b"Quack", x"515541434b20e2809320546865204c6f7564657374204d656d6520436f696e206f6e205355492120f09fa686f09f9a800a41207075726520646567656e206d656d6520636f696e206275696c7420666f72207468652053554920626c6f636b636861696e2e20312520746178206675656c7320636f6d6d756e6974792067726f7774682c206275796261636b732c20616e64206275726e732e204e6f206c696d6974732c206a75737420515541434b21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://bafkreibwm3ajvq4o7qsgv6yyyyas3ff64lobm4iictn42wkuhm6cepq34m.ipfs.w3s.link/"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<QUACK>(&mut v2, 1000000000000000000, @0x6b420009ac19ec6c5f2eab9f4f4274462699347c4108fe1ffc33316fcf371952, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUACK>>(v2, @0x6b420009ac19ec6c5f2eab9f4f4274462699347c4108fe1ffc33316fcf371952);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<QUACK>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun revoke_metadata(arg0: 0x2::coin::CoinMetadata<QUACK>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<QUACK>>(arg0);
    }

    public entry fun update_metadata(arg0: &mut 0x2::coin::TreasuryCap<QUACK>, arg1: &mut 0x2::coin::CoinMetadata<QUACK>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::string::String, arg5: 0x1::ascii::String) {
        0x2::coin::update_name<QUACK>(arg0, arg1, arg2);
        0x2::coin::update_symbol<QUACK>(arg0, arg1, arg3);
        0x2::coin::update_description<QUACK>(arg0, arg1, arg4);
        0x2::coin::update_icon_url<QUACK>(arg0, arg1, arg5);
    }

    // decompiled from Move bytecode v6
}

