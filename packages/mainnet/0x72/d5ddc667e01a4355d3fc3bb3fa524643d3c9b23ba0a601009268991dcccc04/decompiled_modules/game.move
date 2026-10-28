module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::game {
    public fun award_achievement<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::award_achievement<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun award_achievement_as_admin<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::award_achievement_as_admin<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun claim_daily<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: &0x2::clock::Clock) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::claim_daily<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun claim_quest<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::claim_quest<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun complete_quest<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::complete_quest<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun complete_quest_as_admin<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: address, arg4: u8, arg5: &0x2::clock::Clock) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::complete_quest_as_admin<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun grant_season_reward<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::GAME_KEEPER>, arg3: address, arg4: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::grant_season_reward<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun grant_season_reward_as_admin<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: address, arg4: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::grant_season_reward_as_admin<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public(friend) fun on_close<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: address, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: u64, arg14: bool, arg15: u64, arg16: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::on_close<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
    }

    public(friend) fun on_loss<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: address, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::on_loss<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun on_open<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: address, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::on_open_fee<T0>(&v0, arg0, arg2, arg4);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::on_open<T0>(&v0, arg0, arg1, arg2, arg3, arg5);
    }

    entry fun open_crate<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: &0x2::random::Random, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::open_crate<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun open_crates<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: u64, arg5: &0x2::random::Random, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::open_crates<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun register_achievement<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: 0x1::option::Option<u8>) : u8 {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::register_achievement<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)
    }

    public fun register_cosmetic<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: vector<u8>) : u8 {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::register_cosmetic<T0>(&v0, arg0, arg1, arg2, arg3)
    }

    public fun register_quest<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: vector<u8>, arg4: u8, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u8>, arg8: u64, arg9: u64, arg10: u64) : u8 {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::register_quest<T0>(&v0, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10)
    }

    public fun roll_season(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64, arg3: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::roll_season(&v0, arg0, arg1, arg2, arg3);
    }

    public fun set_achievement_active<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u8, arg4: bool) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_achievement_active<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_achievement_mint_fraction_bps(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_achievement_mint_fraction_bps(&v0, arg0, arg1, arg2);
    }

    public fun set_crate_params(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64, arg3: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_crate_params(&v0, arg0, arg1, arg2, arg3);
    }

    public fun set_crate_pool<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: vector<u8>, arg4: vector<u64>) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_crate_pool<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_crate_weights(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64, arg3: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_crate_weights(&v0, arg0, arg1, arg2, arg3);
    }

    public fun set_daily_drop(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_daily_drop(&v0, arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun set_game_enabled(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: bool) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_game_enabled(&v0, arg0, arg1, arg2);
    }

    public fun set_global_mint_cap(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_global_mint_cap(&v0, arg0, arg1, arg2);
    }

    public fun set_quest_active<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: u8, arg4: bool) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_quest_active<T0>(&v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_quest_bounds(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_quest_bounds(&v0, arg0, arg1, arg2);
    }

    public fun set_season_reward_ceiling(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_season_reward_ceiling(&v0, arg0, arg1, arg2);
    }

    public fun set_tier_name(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u8, arg3: vector<u8>) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_tier_name(&v0, arg0, arg1, arg2, arg3);
    }

    public fun set_tier_thresholds(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: vector<u64>) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_tier_thresholds(&v0, arg0, arg1, arg2);
    }

    public fun set_wallet_mint_cap(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_wallet_mint_cap(&v0, arg0, arg1, arg2);
    }

    public fun set_win_xp(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg2: u64, arg3: u64) {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::set_win_xp(&v0, arg0, arg1, arg2, arg3);
    }

    public fun achievement_mint_fraction_bps(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::achievement_mint_fraction_bps(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    public fun daily_base(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::daily_base(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    public fun fee_credit<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::fee_credit(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun fee_credit_used<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::fee_credit_used(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun global_mint_cap(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::global_mint_cap(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    public fun global_minted<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::global_minted(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0))
    }

    public fun max_xp_grant(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::max_xp_grant(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    public fun minted_today<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::minted_today(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun pending_mint<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u128 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::pending_mint(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_crates<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_crates(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_crates_opened<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_crates_opened(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_current_season_xp<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_current_season_xp(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg2)
    }

    public fun player_genuine_closes<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_genuine_closes(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_genuine_volume<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_genuine_volume(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_quests_completed<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_quests_completed(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_season_id<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_season_id(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_season_xp<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_season_xp(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_streak<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_streak(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_tier<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u8 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_tier(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_trades<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_trades(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_win_streak<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_win_streak(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun player_xp<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_xp(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1)
    }

    public fun quest_done<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u8) : bool {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::quest_done(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1, arg2)
    }

    public fun tier_name(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: u64) : vector<u8> {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::tier_name(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0), arg1)
    }

    public fun tier_threshold(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg1: u64) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::tier_threshold(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0), arg1)
    }

    public fun tier_threshold_count(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::tier_threshold_count(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    public fun wallet_mint_cap(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::wallet_mint_cap(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    public fun achievement_unlocked<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address, arg2: u8) : bool {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::achievement_on(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1, arg2)
    }

    public fun collect_mint<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3));
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game::owner<T0>(arg0, arg1, arg2, arg3);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg3, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_game());
        assert!(0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg3)), 13835059077484380161);
        let v1 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::take_pending(&v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v0, arg0), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg1));
        let v2 = mint_out<T0, T1>(arg0, arg3, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::owner<T0>(arg1), v1, arg4, arg5);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_identity<T0>(arg0);
        v2
    }

    public fun game_enabled(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : bool {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::enabled(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0))
    }

    fun mint_out<T0, T1>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1));
        let v1 = if (arg3 == 0) {
            0
        } else {
            assert!(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::has_reward_treasury<T0, T1>(arg0), 13835622959445966853);
            18446744073709551615 - 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::reward_supply<T0, T1>(arg0)
        };
        let v2 = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::issue(&v0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v0, arg0), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg1), arg2, arg3, 0x2::clock::timestamp_ms(arg4), v1);
        if (v2 > 0) {
            0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::locked_mint::lock<T0, T1>(&v0, arg0, arg2, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::mint_reward<T0, T1>(&v0, arg0, v2, arg5), 0x2::clock::timestamp_ms(arg4), arg5);
        };
        0x2::coin::zero<T1>(arg5)
    }

    public fun player_realized_pnl<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: address) : (u64, u64) {
        (0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_realized_gain(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1), 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::player_realized_loss(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid<T0>(arg0), arg1))
    }

    public fun season_id(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config) : u64 {
        let (v0, _, _) = 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::season(0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg0));
        v0
    }

    // decompiled from Move bytecode v7
}

