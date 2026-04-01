module 0x3910ca7c67fa2f6ad2466519dcf3637059871715efa8d494a952d3a29c4cd573::roc_token {
    struct ROC_TOKEN has drop {
        dummy_field: bool,
    }

    struct BalanceChange has copy, drop {
        account: address,
        amount: u64,
        kind: vector<u8>,
    }

    struct SupplyLocked has copy, drop {
        vault_address: address,
        final_supply: u64,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ROC_TOKEN>, arg1: 0x2::coin::Coin<ROC_TOKEN>, arg2: &0x2::tx_context::TxContext) {
        let v0 = BalanceChange{
            account : 0x2::tx_context::sender(arg2),
            amount  : 0x2::coin::value<ROC_TOKEN>(&arg1),
            kind    : b"burn",
        };
        0x2::event::emit<BalanceChange>(v0);
        0x2::coin::burn<ROC_TOKEN>(arg0, arg1);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<ROC_TOKEN>) : u64 {
        0x2::coin::total_supply<ROC_TOKEN>(arg0)
    }

    public fun decimals() : u8 {
        9
    }

    public fun distribute_initial_supply(arg0: 0x2::coin::Coin<ROC_TOKEN>, arg1: address, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<ROC_TOKEN>(&arg0) == 10000000000000000000, 0);
        let v0 = BalanceChange{
            account : arg1,
            amount  : 8500000000000000000,
            kind    : b"transfer",
        };
        0x2::event::emit<BalanceChange>(v0);
        let v1 = BalanceChange{
            account : arg2,
            amount  : 1000000000000000000,
            kind    : b"transfer",
        };
        0x2::event::emit<BalanceChange>(v1);
        let v2 = BalanceChange{
            account : arg3,
            amount  : 500000000000000000,
            kind    : b"transfer",
        };
        0x2::event::emit<BalanceChange>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROC_TOKEN>>(0x2::coin::split<ROC_TOKEN>(&mut arg0, 8500000000000000000, arg4), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROC_TOKEN>>(0x2::coin::split<ROC_TOKEN>(&mut arg0, 1000000000000000000, arg4), arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ROC_TOKEN>>(arg0, arg3);
    }

    public fun freeze_treasury_cap(arg0: 0x2::coin::TreasuryCap<ROC_TOKEN>) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ROC_TOKEN>>(arg0);
    }

    fun init(arg0: ROC_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ROC_TOKEN>(arg0, 9, 0x1::string::utf8(b"ROC"), 0x1::string::utf8(b"ROC Token"), 0x1::string::utf8(b"The native utility token for the RoscasApp ecosystem. ROC is the exclusive medium for bidding on early payout priority within community savings circles."), 0x1::string::utf8(b"https://rxwalrbvurfghhqgaiws.supabase.co/storage/v1/object/public/assets/roc-token.png"), arg1);
        let v2 = v1;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ROC_TOKEN>(&mut v2, 10000000000000000000, v3, arg1);
        let v4 = BalanceChange{
            account : v3,
            amount  : 10000000000000000000,
            kind    : b"mint",
        };
        0x2::event::emit<BalanceChange>(v4);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROC_TOKEN>>(v2, v3);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ROC_TOKEN>>(0x2::coin_registry::finalize<ROC_TOKEN>(v0, arg1), v3);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ROC_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ROC_TOKEN>(arg0, arg1, arg2, arg3);
        let v0 = BalanceChange{
            account : arg2,
            amount  : arg1,
            kind    : b"mint",
        };
        0x2::event::emit<BalanceChange>(v0);
    }

    public fun operational_allocation() : u64 {
        1000000000000000000
    }

    public fun strategic_allocation() : u64 {
        500000000000000000
    }

    public fun total_supply_cap() : u64 {
        10000000000000000000
    }

    public fun transfer_treasury_cap(arg0: 0x2::coin::TreasuryCap<ROC_TOKEN>, arg1: address) {
        let v0 = SupplyLocked{
            vault_address : arg1,
            final_supply  : 0x2::coin::total_supply<ROC_TOKEN>(&arg0),
        };
        0x2::event::emit<SupplyLocked>(v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROC_TOKEN>>(arg0, arg1);
    }

    public fun treasury_allocation() : u64 {
        8500000000000000000
    }

    // decompiled from Move bytecode v6
}

