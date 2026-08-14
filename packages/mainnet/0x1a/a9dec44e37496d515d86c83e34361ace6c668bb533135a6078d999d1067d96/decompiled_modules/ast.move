module 0x1aa9dec44e37496d515d86c83e34361ace6c668bb533135a6078d999d1067d96::ast {
    struct AST has drop {
        dummy_field: bool,
    }

    struct PendingIssuance has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<AST>,
    }

    struct FixedSupplyIssued has copy, drop {
        recipient: address,
        amount: u64,
        decimals: u8,
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: AST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AST>(arg0, 9, b"AST", b"AST", b"AST fixed-supply token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AST>>(v1);
        let v2 = PendingIssuance{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::transfer<PendingIssuance>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun issue_fixed_supply(arg0: PendingIssuance, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 1);
        let PendingIssuance {
            id           : v0,
            treasury_cap : v1,
        } = arg0;
        let v2 = v1;
        0x2::object::delete(v0);
        assert!(0x2::coin::total_supply<AST>(&v2) == 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<AST>>(0x2::coin::mint<AST>(&mut v2, 100000000000000000, arg2), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AST>>(v2);
        let v3 = FixedSupplyIssued{
            recipient : arg1,
            amount    : 100000000000000000,
            decimals  : 9,
        };
        0x2::event::emit<FixedSupplyIssued>(v3);
    }

    public fun total_supply_raw() : u64 {
        100000000000000000
    }

    public fun whole_token_supply() : u64 {
        100000000
    }

    // decompiled from Move bytecode v7
}

