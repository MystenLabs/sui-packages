module 0x85d574dc02a9ed8862ccbae7669c657cfbe5fc33dfc5c408e1b64ffb64969554::loyalty {
    struct LOYALTY has drop {
        dummy_field: bool,
    }

    struct GiftShop has drop {
        dummy_field: bool,
    }

    struct Gift has store, key {
        id: 0x2::object::UID,
    }

    public fun buy_a_gift(arg0: 0x2::token::Token<LOYALTY>, arg1: &mut 0x2::tx_context::TxContext) : (Gift, 0x2::token::ActionRequest<LOYALTY>) {
        assert!(0x2::token::value<LOYALTY>(&arg0) == 10, 0);
        let v0 = Gift{id: 0x2::object::new(arg1)};
        let v1 = 0x2::token::spend<LOYALTY>(arg0, arg1);
        let v2 = GiftShop{dummy_field: false};
        0x2::token::add_approval<LOYALTY, GiftShop>(v2, &mut v1, arg1);
        (v0, v1)
    }

    fun init(arg0: LOYALTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOYALTY>(arg0, 0, b"LOY", b"Loyalty Token", b"Token for Loyalty", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<LOYALTY>(&v2, arg1);
        0x2::token::share_policy<LOYALTY>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOYALTY>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<LOYALTY>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOYALTY>>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun reward_user(arg0: &mut 0x2::coin::TreasuryCap<LOYALTY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<LOYALTY>(arg0, 0x2::token::transfer<LOYALTY>(0x2::token::mint<LOYALTY>(arg0, arg1, arg3), arg2, arg3), arg3);
    }

    // decompiled from Move bytecode v6
}

