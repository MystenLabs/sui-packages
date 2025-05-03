module 0xa42a9e86e49db339a8780214fa7013cb4313d891345061676042814d4b2c04d6::tarzan {
    struct TokenRules has key {
        id: 0x2::object::UID,
        blocked: vector<address>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TARZAN has drop {
        dummy_field: bool,
    }

    struct RestrictionEvent has copy, drop {
        wallet: address,
        blocked: bool,
        timestamp: u64,
    }

    public entry fun block_wallet(arg0: &AdminCap, arg1: &mut TokenRules, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::contains<address>(&arg1.blocked, &arg2), 0);
        0x1::vector::push_back<address>(&mut arg1.blocked, arg2);
        let v0 = RestrictionEvent{
            wallet    : arg2,
            blocked   : true,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<RestrictionEvent>(v0);
    }

    fun init(arg0: TARZAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARZAN>(arg0, 9, b"penio lainoto", b"Tpeniolainoto", b"Token with transfer restrictions", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
        let v4 = TokenRules{
            id      : 0x2::object::new(arg1),
            blocked : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<TokenRules>(v4);
        0x2::coin::mint_and_transfer<TARZAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TARZAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARZAN>>(v2, @0x0);
    }

    public fun transfer_hook(arg0: &TokenRules, arg1: address, arg2: address, arg3: u64) {
        assert!(!0x1::vector::contains<address>(&arg0.blocked, &arg1), 0);
    }

    public entry fun unblock_wallet(arg0: &AdminCap, arg1: &mut TokenRules, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.blocked, &arg2);
        assert!(v0, 0);
        0x1::vector::remove<address>(&mut arg1.blocked, v1);
        let v2 = RestrictionEvent{
            wallet    : arg2,
            blocked   : false,
            timestamp : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<RestrictionEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

