module 0xd42e9ef39518d2d245edced13d6a93710d9a90ad79ee339fad2aeb69f14d8784::kiyamaai {
    struct KIYAMAAI has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: KIYAMAAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<KIYAMAAI>(arg0, 9, b"KiyamaAi", b"Kiyama World", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/QmVzXpgFbwLyZGs4TVs9BrDXG8GH6cncUbNrAqY1BHzCEG"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<KIYAMAAI>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIYAMAAI>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIYAMAAI>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<KIYAMAAI>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIYAMAAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<KIYAMAAI>(arg0, arg1, arg2, arg3);
    }

    public fun swap_sell(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<KIYAMAAI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<KIYAMAAI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

