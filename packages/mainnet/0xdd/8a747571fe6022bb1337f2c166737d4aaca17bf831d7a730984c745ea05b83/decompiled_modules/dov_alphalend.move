module 0xcc52ce27bc9b70b28a090fa44cdabd9be02ab3609a24b06248dd954123a9cb4f::dov_alphalend {
    struct WITNESS has drop {
        dummy_field: bool,
    }

    struct RewardEvent has copy, drop {
        reward_token: 0x1::type_name::TypeName,
        reward_amount: u64,
        promise_amount: u64,
    }

    public fun collect_reward_alphalend<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>, 0x2::coin::Coin<T0>) {
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, WITNESS>(arg0, arg1, v0);
        let (v2, v3) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::collect_reward<T0>(arg2, arg3, &v1, arg4, arg5);
        let v4 = v2;
        let v5 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, v3, arg4, arg5);
        0x2::coin::join<T0>(&mut v4, v5);
        let v6 = RewardEvent{
            reward_token   : 0x1::type_name::get<T0>(),
            reward_amount  : 0x2::coin::value<T0>(&v4),
            promise_amount : 0x2::coin::value<T0>(&v5),
        };
        0x2::event::emit<RewardEvent>(v6);
        (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg0, v1, 0x1::string::utf8(b"cc52ce27bc9b70b28a090fa44cdabd9be02ab3609a24b06248dd954123a9cb4f::dov_alphalend::WITNESS")), v4)
    }

    public fun deposit_alphalend<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>, arg2: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0x2::balance::Balance<T0>>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap> {
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, WITNESS>(arg0, arg1, v0);
        let v2 = WITNESS{dummy_field: false};
        0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::add_collateral<T0>(arg3, &v1, arg4, 0x2::coin::from_balance<T0>(0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<0x2::balance::Balance<T0>, WITNESS>(arg0, arg2, v2), arg6), arg5, arg6);
        0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg0, v1, 0x1::string::utf8(b"5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::tds_witness_entry::WITNESS"))
    }

    public fun withdraw_alphalend<T0>(arg0: &0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::ecosystem::Version, arg1: 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>, arg2: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>, 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::HotPotato<0x2::balance::Balance<T0>>) {
        let v0 = WITNESS{dummy_field: false};
        let v1 = 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::unwrap<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap, WITNESS>(arg0, arg1, v0);
        let v2 = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg2, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::remove_collateral<T0>(arg2, &v1, arg3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_collateral_amount(arg2, arg3, 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::get_position_id(&v1), arg5), arg5), arg5, arg6);
        0x2::coin::join<T0>(&mut v2, arg4);
        (0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::position::PositionCap>(arg0, v1, 0x1::string::utf8(b"5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::tds_witness_entry::WITNESS")), 0x4b0f4ee1a40ce37ec81c987cc4e76a665419e74b863319492fc7d26f708b835a::witness_lock::wrap<0x2::balance::Balance<T0>>(arg0, 0x2::coin::into_balance<T0>(v2), 0x1::string::utf8(b"5160e4780b58f30a02ed14d3a3a9b78251acdc5cc09f893d71b336ab46701533::tds_witness_entry::WITNESS")))
    }

    // decompiled from Move bytecode v6
}

