module 0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::vault {
    struct MarketVault<phantom T0> has key {
        id: 0x2::object::UID,
        collateral: 0x2::balance::Balance<T0>,
        yes_cap: 0x2::coin::TreasuryCap<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::yes::YES>,
        no_cap: 0x2::coin::TreasuryCap<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::no::NO>,
        user_positions: 0x2::table::Table<address, UserPosition>,
        global_yield_index: u128,
    }

    struct UserPosition has store {
        principal: u64,
        last_index: u128,
        pending_yield: u64,
    }

    public fun atomic_mint<T0>(arg0: &mut MarketVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::yes::YES>, 0x2::coin::Coin<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::no::NO>) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::coin::value<T0>(&arg1);
        arg0.global_yield_index = arg2;
        if (0x2::table::contains<address, UserPosition>(&arg0.user_positions, v0)) {
            let v2 = 0x2::table::borrow_mut<address, UserPosition>(&mut arg0.user_positions, v0);
            v2.pending_yield = v2.pending_yield + (((arg2 - v2.last_index) * (v2.principal as u128) / 1000000000) as u64);
            v2.principal = v2.principal + v1;
            v2.last_index = arg2;
        } else {
            let v3 = UserPosition{
                principal     : v1,
                last_index    : arg2,
                pending_yield : 0,
            };
            0x2::table::add<address, UserPosition>(&mut arg0.user_positions, v0, v3);
        };
        0x2::balance::join<T0>(&mut arg0.collateral, 0x2::coin::into_balance<T0>(arg1));
        (0x2::coin::mint<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::yes::YES>(&mut arg0.yes_cap, v1, arg3), 0x2::coin::mint<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::no::NO>(&mut arg0.no_cap, v1, arg3))
    }

    public entry fun atomic_mint_and_keep<T0>(arg0: &mut MarketVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u128, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = atomic_mint<T0>(arg0, arg1, arg2, arg3);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::yes::YES>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::no::NO>>(v1, v2);
    }

    public entry fun claim_yield<T0>(arg0: &mut MarketVault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, UserPosition>(&arg0.user_positions, v0), 2);
        let v1 = 0x2::table::borrow_mut<address, UserPosition>(&mut arg0.user_positions, v0);
        let v2 = v1.pending_yield;
        assert!(v2 > 0, 1);
        v1.pending_yield = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.collateral, v2), arg1), v0);
    }

    public entry fun create_vault<T0>(arg0: 0x2::coin::TreasuryCap<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::yes::YES>, arg1: 0x2::coin::TreasuryCap<0x9b2a744c1751573822e99bae1bc66724aca64928850aa8ef4a2263271d5516f6::no::NO>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketVault<T0>{
            id                 : 0x2::object::new(arg2),
            collateral         : 0x2::balance::zero<T0>(),
            yes_cap            : arg0,
            no_cap             : arg1,
            user_positions     : 0x2::table::new<address, UserPosition>(arg2),
            global_yield_index : 0,
        };
        0x2::transfer::share_object<MarketVault<T0>>(v0);
    }

    public fun get_collateral_balance<T0>(arg0: &MarketVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral)
    }

    public fun get_global_yield_index<T0>(arg0: &MarketVault<T0>) : u128 {
        arg0.global_yield_index
    }

    public fun get_user_position<T0>(arg0: &MarketVault<T0>, arg1: address) : (u64, u128, u64) {
        if (0x2::table::contains<address, UserPosition>(&arg0.user_positions, arg1)) {
            let v3 = 0x2::table::borrow<address, UserPosition>(&arg0.user_positions, arg1);
            (v3.principal, v3.last_index, v3.pending_yield)
        } else {
            (0, 0, 0)
        }
    }

    // decompiled from Move bytecode v6
}

