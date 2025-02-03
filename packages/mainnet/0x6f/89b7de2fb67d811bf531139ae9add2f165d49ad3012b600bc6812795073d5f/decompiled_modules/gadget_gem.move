module 0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::gadget_gem {
    struct GADGET_GEM has drop {
        dummy_field: bool,
    }

    struct ExchangeRequest has store, key {
        id: 0x2::object::UID,
        g_bucks_amount: u64,
        owner: address,
    }

    public fun create_exchange_request(arg0: &mut 0x2::token::Token<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>, arg1: &mut 0x2::token::TokenPolicy<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ExchangeRequest {
        assert!(arg2 > 0, 0);
        assert!(0x2::token::value<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>(arg0) >= arg2, 1);
        let (_, _, _, _) = 0x2::token::confirm_request_mut<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>(arg1, 0x2::token::spend<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>(0x2::token::split<0x1d25d1dc76866c06a1b68ea659c5c434c924738c71a1fc42ef89ca00bc4494bb::g_bucks::G_BUCKS>(arg0, arg2, arg3), arg3), arg3);
        ExchangeRequest{
            id             : 0x2::object::new(arg3),
            g_bucks_amount : arg2,
            owner          : 0x2::tx_context::sender(arg3),
        }
    }

    fun init(arg0: GADGET_GEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GADGET_GEM>(arg0, 1, b"GG", b"Gadget Gems", b"Gadget Gems are a primary currency for Inspector Gadget on the Gamisodes Platform, used for in-game purchases and upgrades.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gamisodes-blockchain-assets.s3.us-west-1.amazonaws.com/1725916985553Gadget_Gem.png")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<GADGET_GEM>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        0x2::token::allow<GADGET_GEM>(&mut v6, &v5, 0x2::token::spend_action(), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GADGET_GEM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GADGET_GEM>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<GADGET_GEM>>(v5, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<GADGET_GEM>(v6);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<GADGET_GEM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<GADGET_GEM>(arg0, 0x2::token::transfer<GADGET_GEM>(0x2::token::mint<GADGET_GEM>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    public fun process_exchange_request(arg0: &mut 0x2::coin::TreasuryCap<GADGET_GEM>, arg1: ExchangeRequest, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.g_bucks_amount * 10;
        assert!(v0 > 0, 2);
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<GADGET_GEM>(arg0, 0x2::token::transfer<GADGET_GEM>(0x2::token::mint<GADGET_GEM>(arg0, v0, arg2), arg1.owner, arg2), arg2);
        let ExchangeRequest {
            id             : v5,
            g_bucks_amount : _,
            owner          : _,
        } = arg1;
        0x2::object::delete(v5);
    }

    // decompiled from Move bytecode v6
}

