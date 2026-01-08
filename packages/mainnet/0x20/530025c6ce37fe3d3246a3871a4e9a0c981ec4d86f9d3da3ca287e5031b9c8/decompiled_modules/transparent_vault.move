module 0x20530025c6ce37fe3d3246a3871a4e9a0c981ec4d86f9d3da3ca287e5031b9c8::transparent_vault {
    struct VaultUsdc<phantom T0> has store, key {
        id: 0x2::object::UID,
        bal_usdc: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        bal_m: 0x2::balance::Balance<T0>,
        has_position: bool,
        pos_tick_lower: u32,
        pos_tick_upper: u32,
        last_sqrt_price_x64: u128,
    }

    public fun bal_m<T0>(arg0: &VaultUsdc<T0>) : &0x2::balance::Balance<T0> {
        &arg0.bal_m
    }

    public fun bal_m_mut<T0>(arg0: &mut VaultUsdc<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.bal_m
    }

    public fun bal_m_value<T0>(arg0: &VaultUsdc<T0>) : u64 {
        0x2::balance::value<T0>(bal_m<T0>(arg0))
    }

    public fun bal_usdc<T0>(arg0: &VaultUsdc<T0>) : &0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        &arg0.bal_usdc
    }

    public fun bal_usdc_mut<T0>(arg0: &mut VaultUsdc<T0>) : &mut 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        &mut arg0.bal_usdc
    }

    public fun bal_usdc_value<T0>(arg0: &VaultUsdc<T0>) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(bal_usdc<T0>(arg0))
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : VaultUsdc<T0> {
        VaultUsdc<T0>{
            id                  : 0x2::object::new(arg0),
            bal_usdc            : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            bal_m               : 0x2::balance::zero<T0>(),
            has_position        : false,
            pos_tick_lower      : 0,
            pos_tick_upper      : 0,
            last_sqrt_price_x64 : 0,
        }
    }

    public fun has_position<T0>(arg0: &VaultUsdc<T0>) : bool {
        arg0.has_position
    }

    public fun id<T0>(arg0: &VaultUsdc<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun id_mut<T0>(arg0: &mut VaultUsdc<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun last_sqrt_price_x64<T0>(arg0: &VaultUsdc<T0>) : u128 {
        arg0.last_sqrt_price_x64
    }

    public fun pos_tick_lower<T0>(arg0: &VaultUsdc<T0>) : u32 {
        arg0.pos_tick_lower
    }

    public fun pos_tick_upper<T0>(arg0: &VaultUsdc<T0>) : u32 {
        arg0.pos_tick_upper
    }

    public fun set_has_position<T0>(arg0: &mut VaultUsdc<T0>, arg1: bool) {
        arg0.has_position = arg1;
    }

    public fun set_last_sqrt_price_x64<T0>(arg0: &mut VaultUsdc<T0>, arg1: u128) {
        arg0.last_sqrt_price_x64 = arg1;
    }

    public fun set_pos_tick_lower<T0>(arg0: &mut VaultUsdc<T0>, arg1: u32) {
        arg0.pos_tick_lower = arg1;
    }

    public fun set_pos_tick_upper<T0>(arg0: &mut VaultUsdc<T0>, arg1: u32) {
        arg0.pos_tick_upper = arg1;
    }

    public fun vault_state<T0>(arg0: &VaultUsdc<T0>) : (u64, u64, bool, u32, u32, u128) {
        (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.bal_usdc), 0x2::balance::value<T0>(&arg0.bal_m), arg0.has_position, arg0.pos_tick_lower, arg0.pos_tick_upper, arg0.last_sqrt_price_x64)
    }

    // decompiled from Move bytecode v6
}

