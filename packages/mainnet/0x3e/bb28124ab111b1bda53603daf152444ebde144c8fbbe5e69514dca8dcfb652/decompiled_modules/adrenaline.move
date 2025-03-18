module 0x3ebb28124ab111b1bda53603daf152444ebde144c8fbbe5e69514dca8dcfb652::adrenaline {
    struct ADRENALINE has drop {
        dummy_field: bool,
    }

    struct AdrenalineMintEvent has copy, drop {
        amount: u64,
        recipient: address,
        reason: 0x1::string::String,
    }

    struct AdrenalineSplitEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
    }

    struct AdrenalineTransferEvent has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
    }

    struct AdrenalineJoinEvent has copy, drop {
        token_id: 0x2::object::ID,
        another_token_id: 0x2::object::ID,
    }

    struct AdrenalineBurnEvent has copy, drop {
        id: 0x2::object::ID,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ADRENALINE>, arg1: 0x2::token::Token<ADRENALINE>) {
        let v0 = AdrenalineBurnEvent{id: 0x2::object::id<0x2::token::Token<ADRENALINE>>(&arg1)};
        0x2::event::emit<AdrenalineBurnEvent>(v0);
        0x2::token::burn<ADRENALINE>(arg0, arg1);
    }

    public fun confirm_request(arg0: &mut 0x2::token::TokenPolicy<ADRENALINE>, arg1: 0x2::token::ActionRequest<ADRENALINE>, arg2: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_request<ADRENALINE>(arg0, arg1, arg2);
    }

    public fun join(arg0: &mut 0x2::token::Token<ADRENALINE>, arg1: 0x2::token::Token<ADRENALINE>) {
        let v0 = AdrenalineJoinEvent{
            token_id         : 0x2::object::id<0x2::token::Token<ADRENALINE>>(arg0),
            another_token_id : 0x2::object::id<0x2::token::Token<ADRENALINE>>(&arg1),
        };
        0x2::event::emit<AdrenalineJoinEvent>(v0);
        0x2::token::join<ADRENALINE>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ADRENALINE>, arg1: u64, arg2: address, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let (_, _, _, _) = 0x2::token::confirm_with_treasury_cap<ADRENALINE>(arg0, 0x2::token::transfer<ADRENALINE>(0x2::token::mint<ADRENALINE>(arg0, arg1, arg4), arg2, arg4), arg4);
        let v4 = AdrenalineMintEvent{
            amount    : arg1,
            recipient : arg2,
            reason    : arg3,
        };
        0x2::event::emit<AdrenalineMintEvent>(v4);
    }

    public fun split(arg0: &mut 0x2::token::Token<ADRENALINE>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::Token<ADRENALINE> {
        let v0 = AdrenalineSplitEvent{
            id     : 0x2::object::id<0x2::token::Token<ADRENALINE>>(arg0),
            amount : arg1,
        };
        0x2::event::emit<AdrenalineSplitEvent>(v0);
        0x2::token::split<ADRENALINE>(arg0, arg1, arg2)
    }

    public fun transfer(arg0: 0x2::token::Token<ADRENALINE>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : 0x2::token::ActionRequest<ADRENALINE> {
        let v0 = AdrenalineTransferEvent{
            id        : 0x2::object::id<0x2::token::Token<ADRENALINE>>(&arg0),
            recipient : arg1,
        };
        0x2::event::emit<AdrenalineTransferEvent>(v0);
        0x2::token::transfer<ADRENALINE>(arg0, arg1, arg2)
    }

    public fun add_pass_rule(arg0: &mut 0x2::token::TokenPolicy<ADRENALINE>, arg1: &0x2::token::TokenPolicyCap<ADRENALINE>, arg2: &mut 0x2::tx_context::TxContext) {
        0x3ebb28124ab111b1bda53603daf152444ebde144c8fbbe5e69514dca8dcfb652::pass_rule::add_rule<ADRENALINE>(arg0, arg1, arg2);
    }

    fun init(arg0: ADRENALINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADRENALINE>(arg0, 0, b"ADRENALINE", b"Adrenaline", b"In-game currency for One Championship", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<ADRENALINE>(&v2, arg1);
        let v5 = v4;
        let v6 = v3;
        let v7 = &mut v6;
        add_pass_rule(v7, &v5, arg1);
        0x2::token::share_policy<ADRENALINE>(v6);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADRENALINE>>(v1);
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<ADRENALINE>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADRENALINE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

