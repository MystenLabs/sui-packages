module 0x8c9fbe688d433bb24a3e059a5dc7e8deb135c1b56287fb2be54f7cbeb8f94329::trumpwifbat {
    struct TRUMPWIFBAT has drop {
        dummy_field: bool,
    }

    public entry fun addToDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPWIFBAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TRUMPWIFBAT>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: TRUMPWIFBAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TRUMPWIFBAT>(arg0, 9, b"TrumpWifBat", b"TrumpWifBat", b"TrumpWifBat Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TRUMPWIFBAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPWIFBAT>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPWIFBAT>>(v3, @0x0);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TRUMPWIFBAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun removeFromDenyList(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TRUMPWIFBAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<TRUMPWIFBAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

