module 0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::market {
    struct Market<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        treasury_cap_outcome_a: 0x2::coin::TreasuryCap<T0>,
        treasury_cap_outcome_b: 0x2::coin::TreasuryCap<T1>,
        raised_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        raise_deadline_ms: u64,
    }

    public fun new_market(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::MetadataCap<0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::OutcomeCoin>, 0x2::coin_registry::MetadataCap<0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::OutcomeCoin>) {
        let (v0, v1) = 0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::new_outcome_coin(arg0, arg1);
        let (v2, v3) = 0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::new_outcome_coin(arg0, arg1);
        let v4 = Market<0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::OutcomeCoin, 0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::OutcomeCoin>{
            id                     : 0x2::object::new(arg1),
            treasury_cap_outcome_a : v0,
            treasury_cap_outcome_b : v2,
            raised_balance         : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            raise_deadline_ms      : 0,
        };
        0x2::transfer::share_object<Market<0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::OutcomeCoin, 0x8a011a4d018733d75ce901a52ba3f8dc41fba69b4c8ca907ebc187e6fe91e3ca::coin::OutcomeCoin>>(v4);
        (v1, v3)
    }

    // decompiled from Move bytecode v6
}

