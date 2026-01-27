module 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::controller {
    struct Controller has store, key {
        id: 0x2::object::UID,
    }

    entry fun next_season(arg0: &mut Controller, arg1: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::Config, arg2: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::Oracle, arg3: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::admin::AdminCap, arg4: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::market::Market, arg5: &0x2::random::Random, arg6: &mut 0x2::tx_context::TxContext) {
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::update_prices(arg2, arg5, arg6);
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::next_season(arg1);
        let v0 = 0x2::random::new_generator(arg5, arg6);
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(arg4, arg1, 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>()), 0x2::random::generate_u64_in_range(&mut v0, 50000000000, 150000000000)));
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(arg4, arg1, 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>()), 0x2::random::generate_u64_in_range(&mut v0, 60000000000, 200000000000)));
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(arg4, arg1, 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>()), 0x2::random::generate_u64_in_range(&mut v0, 55000000000, 175000000000)));
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg4, arg1, 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>()), 0x2::random::generate_u64_in_range(&mut v0, 25000000000, 75000000000)));
    }

    fun add_liquidity<T0, T1>(arg0: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::add_liquidity<T0, T1>(arg0, arg1, arg2);
    }

    fun add_reserve<T0>(arg0: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::market::Market, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::market::add_reserve<T0>(arg0, arg1, arg2);
    }

    fun add_reward<T0>(arg0: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::market::Market, arg1: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::Config, arg2: 0x2::balance::Balance<T0>) {
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::market::add_reward<T0>(arg0, arg1, arg2);
    }

    entry fun allocate_usdg_to_players(arg0: &mut Controller, arg1: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::admin::AdminCap, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>());
        0x1::vector::reverse<address>(&mut arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(0x2::coin::from_balance<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(v0, 100000000000), arg3), 0x1::vector::pop_back<address>(&mut arg2));
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    fun create_casino<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino::Casino<T0> {
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino::new_casino<T0>(arg0, arg1)
    }

    fun create_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::Pool<T0, T1> {
        0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::new_pool<T0, T1>(arg0)
    }

    public fun new_controller(arg0: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::admin::AdminCap, arg1: 0x2::coin::TreasuryCap<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>, arg2: 0x2::coin::TreasuryCap<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>, arg3: 0x2::coin::TreasuryCap<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>, arg4: 0x2::coin::TreasuryCap<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>, arg5: &mut 0x2::tx_context::TxContext) : Controller {
        let v0 = Controller{id: 0x2::object::new(arg5)};
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>>(&mut v0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(), 0x2::coin::treasury_into_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(arg1));
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>>(&mut v0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(), 0x2::coin::treasury_into_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(arg2));
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>>(&mut v0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(), 0x2::coin::treasury_into_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(arg3));
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(&mut v0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(), 0x2::coin::treasury_into_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg4));
        v0
    }

    public fun setup(arg0: &mut Controller, arg1: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::admin::AdminCap, arg2: &mut 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::market::Market, arg3: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::config::Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>()), 1000000000000000 * 3 + 100000000000);
        let v1 = 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>()), 1000000000000000 * 3 + 100000000000);
        let v2 = 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>()), 1000000000000000 * 3 + 100000000000);
        let v3 = 0x2::balance::increase_supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Supply<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(&mut arg0.id, 0x1::type_name::with_defining_ids<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>()), 1000000000000000 * 5 + 50000000000);
        let v4 = create_pool<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg4);
        let v5 = create_pool<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg4);
        let v6 = create_pool<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg4);
        let v7 = &mut v4;
        add_liquidity<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(v7, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(&mut v0, 1000000000000000), 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(&mut v3, 1000000000000000));
        let v8 = &mut v5;
        add_liquidity<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(v8, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(&mut v1, 1000000000000000), 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(&mut v3, 1000000000000000));
        let v9 = &mut v6;
        add_liquidity<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(v9, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(&mut v2, 1000000000000000), 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(&mut v3, 1000000000000000));
        add_reserve<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(arg2, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(&mut v0, 1000000000000000), arg4);
        add_reserve<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(arg2, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(&mut v1, 1000000000000000), arg4);
        add_reserve<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(arg2, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(&mut v2, 1000000000000000), arg4);
        add_reserve<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg2, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(&mut v3, 1000000000000000), arg4);
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(arg2, arg3, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(&mut v0, 100000000000));
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(arg2, arg3, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(&mut v1, 100000000000));
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(arg2, arg3, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(&mut v2, 100000000000));
        add_reward<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(arg2, arg3, 0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(&mut v3, 50000000000));
        let v10 = create_casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(&mut v0, 1000000000000000), arg4);
        let v11 = create_casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(&mut v1, 1000000000000000), arg4);
        let v12 = create_casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(&mut v2, 1000000000000000), arg4);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::Pool<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(v4);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::Pool<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(v5);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool::Pool<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI, 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(v6);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino::Casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>>(v10);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino::Casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>>(v11);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino::Casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>>(v12);
        0x2::transfer::public_share_object<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::casino::Casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>>(create_casino<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(0x2::balance::split<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(&mut v3, 1000000000000000), arg4));
        0x2::balance::destroy_zero<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::aui::AUI>(v0);
        0x2::balance::destroy_zero<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::bui::BUI>(v1);
        0x2::balance::destroy_zero<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::cui::CUI>(v2);
        0x2::balance::destroy_zero<0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg::USDG>(v3);
    }

    // decompiled from Move bytecode v6
}

