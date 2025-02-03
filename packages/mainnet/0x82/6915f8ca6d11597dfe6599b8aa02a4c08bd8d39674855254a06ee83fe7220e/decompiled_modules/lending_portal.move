module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_portal {
    struct LendingPortal has key {
        id: 0x2::object::UID,
        relayer: address,
        next_nonce: u64,
    }

    struct RelayEvent has copy, drop {
        sequence: u64,
        nonce: u64,
        dst_pool: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress,
        fee_amount: u64,
        call_type: u8,
    }

    struct LendingPortalEvent has copy, drop {
        nonce: u64,
        sender: address,
        dola_pool_address: vector<u8>,
        source_chain_id: u16,
        dst_chain_id: u16,
        receiver: vector<u8>,
        amount: u64,
        call_type: u8,
    }

    struct LendingLocalEvent has copy, drop {
        nonce: u64,
        sender: address,
        dola_pool_address: vector<u8>,
        amount: u64,
        call_type: u8,
    }

    public entry fun as_collateral(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg6: vector<u16>, arg7: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg6)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::as_collateral(arg4, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg7))), *0x1::vector::borrow<u16>(&arg6, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun cancel_as_collateral(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg6: vector<u16>, arg7: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u16>(&arg6)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::cancel_as_collateral(arg4, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg7))), *0x1::vector::borrow<u16>(&arg6, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun borrow_local<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg9));
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg5, v0);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::find_pool_by_chain(arg5, v2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id());
        assert!(0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v3), 0);
        let v4 = 0x1::option::destroy_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(v3);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg5, v4) >= (arg8 as u256), 1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_borrow(arg5, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg6, v1), v2, (arg8 as u256));
        let (v5, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::remove_liquidity(arg5, v4, 1, (arg8 as u256));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::withdraw<T0>(arg7, v1, (v5 as u64), v0, arg9);
        let v7 = LendingLocalEvent{
            nonce             : get_nonce(arg4),
            sender            : 0x2::tx_context::sender(arg9),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            amount            : arg8,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type(),
        };
        0x2::event::emit<LendingLocalEvent>(v7);
    }

    public entry fun borrow_remote(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg5: &mut LendingPortal, arg6: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg8: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg9: vector<u8>, arg10: vector<u8>, arg11: u16, arg12: u64, arg13: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg11, arg9);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg7, v0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::find_pool_by_chain(arg7, v1, arg11);
        assert!(0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v2), 0);
        let v3 = 0x1::option::destroy_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(v2);
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg7, v3) >= (arg12 as u256), 1);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_borrow(arg7, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg8, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg15))), v1, (arg12 as u256));
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<0x2::sui::SUI>(arg13, arg14, arg15);
        let v5 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg6);
        assert!(arg14 >= v5, 3);
        let v6 = get_nonce(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, arg5.relayer);
        let v7 = RelayEvent{
            sequence   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::send_withdraw(arg6, arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_cap(arg1), arg7, v3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg11, arg10), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v6, (arg12 as u256), 0x2::coin::split<0x2::sui::SUI>(&mut v4, v5, arg15), arg3),
            nonce      : v6,
            dst_pool   : v3,
            fee_amount : 0x2::coin::value<0x2::sui::SUI>(&v4),
            call_type  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type(),
        };
        0x2::event::emit<RelayEvent>(v7);
        let v8 = LendingPortalEvent{
            nonce             : v6,
            sender            : 0x2::tx_context::sender(arg15),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : arg11,
            receiver          : arg10,
            amount            : arg12,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_borrow_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v8);
    }

    fun get_nonce(arg0: &mut LendingPortal) : u64 {
        arg0.next_nonce = arg0.next_nonce + 1;
        arg0.next_nonce
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LendingPortal{
            id         : 0x2::object::new(arg0),
            relayer    : 0x2::tx_context::sender(arg0),
            next_nonce : 0,
        };
        0x2::transfer::share_object<LendingPortal>(v0);
    }

    public entry fun liquidate<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg8: vector<0x2::coin::Coin<T0>>, arg9: u64, arg10: u16, arg11: vector<u8>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x2::tx_context::sender(arg13);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>());
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg6, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg10, arg11));
        let v3 = get_nonce(arg4);
        if (arg9 > 0) {
            supply<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg13);
        } else {
            0x2::coin::destroy_zero<T0>(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T0>(arg8, arg9, arg13));
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_liquidate(arg6, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg5, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(v0)), arg12, v2, v1);
        let v4 = LendingLocalEvent{
            nonce             : v3,
            sender            : v0,
            dola_pool_address : arg11,
            amount            : arg9,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_liquidate_type(),
        };
        0x2::event::emit<LendingLocalEvent>(v4);
    }

    public entry fun repay<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg8: vector<0x2::coin::Coin<T0>>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        assert!(arg9 > 0, 4);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg10));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T0>(arg8, arg9, arg10);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::normal_amount<T0>(arg7, 0x2::coin::value<T0>(&v2));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::deposit<T0>(arg7, v2, 1, 0x1::vector::empty<u8>(), arg10);
        let (v4, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::add_liquidity(arg6, v1, 1, (v3 as u256));
        if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::is_dola_user(arg5, v0)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_user_id(arg5, v0);
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_repay(arg6, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg5, v0), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg6, v1), v4);
        let v6 = LendingLocalEvent{
            nonce             : get_nonce(arg4),
            sender            : 0x2::tx_context::sender(arg10),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            amount            : v3,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_repay_type(),
        };
        0x2::event::emit<LendingLocalEvent>(v6);
    }

    public fun set_relayer(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut LendingPortal, arg2: address) {
        arg1.relayer = arg2;
    }

    public entry fun supply<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg8: vector<0x2::coin::Coin<T0>>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        assert!(arg9 > 0, 4);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg10));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<T0>(arg8, arg9, arg10);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::normal_amount<T0>(arg7, 0x2::coin::value<T0>(&v2));
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::deposit<T0>(arg7, v2, 1, 0x1::vector::empty<u8>(), arg10);
        let (v4, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::add_liquidity(arg6, v1, 1, (v3 as u256));
        if (!0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::is_dola_user(arg5, v0)) {
            0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::register_dola_user_id(arg5, v0);
        };
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_supply(arg6, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg5, v0), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg6, v1), v4);
        let v6 = LendingLocalEvent{
            nonce             : get_nonce(arg4),
            sender            : 0x2::tx_context::sender(arg10),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            amount            : v3,
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_supply_type(),
        };
        0x2::event::emit<LendingLocalEvent>(v6);
    }

    public entry fun withdraw_local<T0>(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut LendingPortal, arg5: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg6: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::Pool<T0>, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg9));
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_pool_to_dola<T0>();
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg5, v1);
        let v3 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::find_pool_by_chain(arg5, v2, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id());
        assert!(0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v3), 0);
        let v4 = 0x1::option::destroy_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(v3);
        let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_withdraw(arg5, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg6, v0), v2, (arg8 as u256));
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg5, v4) >= v5, 1);
        let (v6, _) = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::remove_liquidity(arg5, v4, 1, v5);
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_pool::withdraw<T0>(arg7, v0, (v6 as u64), v1, arg9);
        let v8 = LendingLocalEvent{
            nonce             : get_nonce(arg4),
            sender            : 0x2::tx_context::sender(arg9),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v1),
            amount            : (v5 as u64),
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type(),
        };
        0x2::event::emit<LendingLocalEvent>(v8);
    }

    public entry fun withdraw_remote(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceGenesis, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::Storage, arg2: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::oracle::PriceOracle, arg3: &0x2::clock::Clock, arg4: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::CoreState, arg5: &mut LendingPortal, arg6: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg7: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::PoolManagerInfo, arg8: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::UserManagerInfo, arg9: vector<u8>, arg10: vector<u8>, arg11: u16, arg12: u64, arg13: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::check_latest_version(arg0);
        let v0 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg11, arg9);
        let v1 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_id_by_pool(arg7, v0);
        let v2 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::find_pool_by_chain(arg7, v1, arg11);
        assert!(0x1::option::is_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(&v2), 0);
        let v3 = 0x1::option::destroy_some<0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::DolaAddress>(v2);
        let v4 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_logic::execute_withdraw(arg7, arg1, arg2, arg3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::user_manager::get_dola_user_id(arg8, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::convert_address_to_dola(0x2::tx_context::sender(arg15))), v1, (arg12 as u256));
        assert!(0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::pool_manager::get_pool_liquidity(arg7, v3) >= v4, 1);
        let v5 = 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::merge_coins::merge_coin<0x2::sui::SUI>(arg13, arg14, arg15);
        let v6 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg6);
        assert!(arg14 >= v6, 3);
        let v7 = get_nonce(arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v5, arg5.relayer);
        let v8 = RelayEvent{
            sequence   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::wormhole_adapter_core::send_withdraw(arg6, arg4, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage::get_app_cap(arg1), arg7, v3, 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::create_dola_address(arg11, arg10), 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(), v7, v4, 0x2::coin::split<0x2::sui::SUI>(&mut v5, v6, arg15), arg3),
            nonce      : v7,
            dst_pool   : v3,
            fee_amount : 0x2::coin::value<0x2::sui::SUI>(&v5),
            call_type  : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type(),
        };
        0x2::event::emit<RelayEvent>(v8);
        let v9 = LendingPortalEvent{
            nonce             : v7,
            sender            : 0x2::tx_context::sender(arg15),
            dola_pool_address : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_dola_address(&v0),
            source_chain_id   : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::dola_address::get_native_dola_chain_id(),
            dst_chain_id      : arg11,
            receiver          : arg10,
            amount            : (v4 as u64),
            call_type         : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_codec::get_withdraw_type(),
        };
        0x2::event::emit<LendingPortalEvent>(v9);
    }

    // decompiled from Move bytecode v6
}

