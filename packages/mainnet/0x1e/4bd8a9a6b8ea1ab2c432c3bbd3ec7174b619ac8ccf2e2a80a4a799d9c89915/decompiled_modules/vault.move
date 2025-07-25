module 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::vault {
    struct Vault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        reserve: 0x2::bag::Bag,
        reserve_record: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
        supply: 0x2::balance::Supply<T1>,
        share_metadata: ShareMetadata,
        fee_rate: 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float,
        is_verified: bool,
        allocation: 0x2::vec_map::VecMap<0x1::type_name::TypeName, BaseAmount>,
        is_individual: bool,
        latest_updated_ts: u64,
    }

    struct ShareMetadata has store {
        supply_limit: u64,
        share_decimal: u8,
    }

    struct BaseAmount has store {
        amount: u64,
        last_update_ts: u64,
    }

    struct VaultCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct SellShareRequest<phantom T0> {
        vault_id: 0x2::object::ID,
        burned_share: u64,
        weight: 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float,
        expected_amount: u64,
        collector: 0x2::balance::Balance<T0>,
        partner_requests: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        partner_confirm_requests: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        partner_receipts: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct RedeemSuccessReceipt {
        unlock_partners: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct ReserveState {
        reserve: 0x2::vec_map::VecMap<0x1::ascii::String, u64>,
    }

    struct ManagementKey has copy, drop, store {
        dummy_field: bool,
    }

    struct MainVault has drop {
        dummy_field: bool,
    }

    public fun new<T0, T1>(arg0: &0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg1: 0x2::coin::TreasuryCap<T1>, arg2: &0x2::coin::CoinMetadata<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: bool, arg7: &mut 0x2::tx_context::TxContext) : VaultCap {
        if (!0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::is_allowed_base<T0>(arg0)) {
            err_base_not_allowed();
        };
        let v0 = ShareMetadata{
            supply_limit  : arg3,
            share_decimal : 0x2::coin::get_decimals<T1>(arg2),
        };
        let v1 = Vault<T0, T1>{
            id                : 0x2::object::new(arg7),
            reserve           : 0x2::bag::new(arg7),
            reserve_record    : 0x2::vec_map::empty<0x1::ascii::String, u64>(),
            supply            : 0x2::coin::treasury_into_supply<T1>(arg1),
            share_metadata    : v0,
            fee_rate          : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from_bps(arg4),
            is_verified       : false,
            allocation        : 0x2::vec_map::empty<0x1::type_name::TypeName, BaseAmount>(),
            is_individual     : arg6,
            latest_updated_ts : 0x2::clock::timestamp_ms(arg5),
        };
        let v2 = VaultCap{
            id       : 0x2::object::new(arg7),
            vault_id : *0x2::object::uid_as_inner(&v1.id),
        };
        let v3 = 0x1::type_name::get<T0>();
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut v1.reserve_record, 0x1::type_name::into_string(v3), 0);
        0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.reserve, v3, 0x2::balance::zero<T0>());
        let v4 = BaseAmount{
            amount         : 0,
            last_update_ts : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, BaseAmount>(&mut v1.allocation, 0x1::type_name::get<MainVault>(), v4);
        let v5 = ManagementKey{dummy_field: false};
        0x2::dynamic_field::add<ManagementKey, 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::Collector<T0>>(&mut v1.id, v5, 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::new<T0>());
        0x2::transfer::share_object<Vault<T0, T1>>(v1);
        v2
    }

    fun add_amount(arg0: &mut 0x2::vec_map::VecMap<0x1::ascii::String, u64>, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = 0x2::vec_map::keys<0x1::ascii::String, u64>(arg0);
        let v1 = if (0x1::vector::contains<0x1::ascii::String>(&v0, &arg1)) {
            let (_, v3) = 0x2::vec_map::remove<0x1::ascii::String, u64>(arg0, &arg1);
            v3
        } else {
            0
        };
        0x2::vec_map::insert<0x1::ascii::String, u64>(arg0, arg1, v1 + arg2);
    }

    fun add_to_reserve<T0, T1, T2>(arg0: &mut Vault<T0, T1>, arg1: 0x2::balance::Balance<T2>) {
        let v0 = 0x1::type_name::get<T2>();
        let v1 = 0x1::type_name::into_string(v0);
        if (0x2::vec_map::contains<0x1::ascii::String, u64>(&arg0.reserve_record, &v1)) {
            0x2::balance::join<T2>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.reserve, v0), arg1);
            let v2 = 0x1::type_name::into_string(v0);
            let (_, v4) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.reserve_record, &v2);
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.reserve_record, 0x1::type_name::into_string(v0), v4 + 0x2::balance::value<T2>(&arg1));
        } else {
            0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.reserve_record, 0x1::type_name::into_string(v0), 0x2::balance::value<T2>(&arg1));
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T2>>(&mut arg0.reserve, v0, arg1);
        };
    }

    fun borrow_collector_mut<T0, T1>(arg0: &mut Vault<T0, T1>) : &mut 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::Collector<T0> {
        let v0 = ManagementKey{dummy_field: false};
        0x2::dynamic_field::borrow_mut<ManagementKey, 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::Collector<T0>>(&mut arg0.id, v0)
    }

    public fun burn_redeem_success_receipt(arg0: RedeemSuccessReceipt) {
        let RedeemSuccessReceipt { unlock_partners: v0 } = arg0;
        if (0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&v0)) > 0) {
            err_exsited_partner_not_unlocked();
        };
    }

    public fun buy_share<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        if (arg0.is_individual) {
            err_individual_vault();
        };
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::assert_version_not_allowed(arg1);
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = 0x2::coin::into_balance<T0>(arg2);
        let v2 = vault_total_base_amount<T0, T1>(arg0, arg1, arg3);
        let v3 = if (v2 != 0) {
            let v4 = calculate_platform_fee<T0, T1>(arg0, v2, arg1, arg3);
            0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::add_record<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), v4);
            0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::fill_record<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), &mut v1);
            arg0.latest_updated_ts = 0x2::clock::timestamp_ms(arg3);
            let v5 = calculate_management_fee<T0, T1>(arg0, v2, arg3);
            let v6 = borrow_collector_mut<T0, T1>(arg0);
            0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::add_unclaimed_amount<T0>(v6, v5);
            0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::fill_balance<T0>(v6, &mut v1);
            0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from_fraction(0x2::balance::supply_value<T1>(&arg0.supply), v2 - v4 + v5)
        } else {
            0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(1)
        };
        let v7 = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::floor(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul(v3, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(v0)));
        let v8 = 0x2::balance::increase_supply<T1>(&mut arg0.supply, v7);
        add_to_reserve<T0, T1, T0>(arg0, v1);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::vault_event::buy_share_event<T0, ShareMetadata>(*0x2::object::uid_as_inner(&arg0.id), v0, v7);
        0x2::coin::from_balance<T1>(v8, arg4)
    }

    fun calculate_management_fee<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::floor(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(arg0.fee_rate, (0x2::clock::timestamp_ms(arg2) - arg0.latest_updated_ts) / 1000), arg1))
    }

    fun calculate_platform_fee<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64, arg2: &0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg3: &0x2::clock::Clock) : u64 {
        0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::floor(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::div_u64(0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::vault_platform_fee(arg2), 31536000), (0x2::clock::timestamp_ms(arg3) - arg0.latest_updated_ts) / 1000), arg1))
    }

    fun check_and_burn_verified_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T2, MainVault>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T2, MainVault>(arg1, &v0);
        if (!0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_verified")) {
            err_redeem_verify_failed();
        };
        if (0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id") != *0x2::object::uid_as_inner(&arg0.id)) {
            err_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
    }

    fun check_and_extract_weight<T0, T1>(arg0: &Vault<T0, T1>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault>) : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<MainVault, MainVault>(arg1, &v0);
        if (!(*0x2::object::uid_as_inner(&arg0.id) != 0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id"))) {
            err_main_vault_id_not_matched();
        };
        0x2::bag::destroy_empty(v1);
        0x2::bag::remove<vector<u8>, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float>(&mut v1, b"weight")
    }

    fun check_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &mut 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T2, MainVault>) {
        let v0 = stamp();
        if (*0x2::bag::borrow<vector<u8>, 0x2::object::ID>(0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::borrow_info<T2, MainVault>(arg1, &v0), b"main_vault_id") != *0x2::object::uid_as_inner(&arg0.id)) {
            err_vault_id_not_matched();
        };
    }

    public fun claim_management_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap) : 0x2::balance::Balance<T0> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        0x2::balance::withdraw_all<T0>(0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::borrow_balance_mut<T0>(borrow_collector_mut<T0, T1>(arg0)))
    }

    public fun confirm_partner_state_generated<T0, T1: drop>(arg0: &mut SellShareRequest<T0>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T1, MainVault>) {
        request_confirm_<T0, T1>(arg0, arg1);
    }

    public fun create_operate_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &VaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        new_simple_message_<T0, T1, T2>(arg0, arg2)
    }

    public fun create_sell_share_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock) : SellShareRequest<T0> {
        let v0 = SellShareRequest<T0>{
            vault_id                 : *0x2::object::uid_as_inner(&arg0.id),
            burned_share             : 0,
            weight                   : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(0),
            expected_amount          : 0,
            collector                : 0x2::balance::zero<T0>(),
            partner_requests         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            partner_confirm_requests : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            partner_receipts         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = get_withdraw_float<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2));
        v0.weight = v1;
        let v2 = vault_total_base_amount<T0, T1>(arg0, arg1, arg3);
        let v3 = calculate_platform_fee<T0, T1>(arg0, v2, arg1, arg3);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::add_record<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), v3);
        let v4 = calculate_management_fee<T0, T1>(arg0, v2, arg3);
        let v5 = borrow_collector_mut<T0, T1>(arg0);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::add_unclaimed_amount<T0>(v5, v4);
        arg0.latest_updated_ts = 0x2::clock::timestamp_ms(arg3);
        let v6 = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::floor(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(v1, v2 - v3 + v4));
        let v7 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserve, 0x1::type_name::get<T0>());
        if (0x2::balance::value<T0>(v7) >= v6) {
            v0.weight = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(0);
            0x2::balance::join<T0>(&mut v0.collector, 0x2::balance::split<T0>(v7, v6));
            v0.expected_amount = 0;
        } else {
            0x2::balance::join<T0>(&mut v0.collector, 0x2::balance::withdraw_all<T0>(v7));
            v0.expected_amount = v6 - 0x2::balance::value<T0>(&v0.collector);
        };
        let v8 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        while (0x1::vector::length<0x1::type_name::TypeName>(&v8) > 0) {
            let v9 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v8);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.partner_receipts, v9);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.partner_requests, v9);
        };
        v0.burned_share = 0x2::coin::value<T1>(&arg2);
        0x2::balance::decrease_supply<T1>(&mut arg0.supply, 0x2::coin::into_balance<T1>(arg2));
        v0
    }

    public fun create_sell_share_request_by_stingray<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg2: &0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::AdminCap, arg3: &0x2::clock::Clock) : SellShareRequest<T0> {
        let v0 = SellShareRequest<T0>{
            vault_id                 : *0x2::object::uid_as_inner(&arg0.id),
            burned_share             : 0,
            weight                   : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(0),
            expected_amount          : 0,
            collector                : 0x2::balance::zero<T0>(),
            partner_requests         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            partner_confirm_requests : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            partner_receipts         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = vault_total_base_amount<T0, T1>(arg0, arg1, arg3);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::add_record<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), calculate_platform_fee<T0, T1>(arg0, v1, arg1, arg3));
        let v2 = calculate_management_fee<T0, T1>(arg0, v1, arg3);
        let v3 = borrow_collector_mut<T0, T1>(arg0);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::add_unclaimed_amount<T0>(v3, v2);
        arg0.latest_updated_ts = 0x2::clock::timestamp_ms(arg3);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::set_unclaimed_amount_to_zero<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id));
        v0.weight = get_fee_float(0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::unclaimed_base_amount<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id)), v1);
        let v4 = 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::unclaimed_base_amount<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id));
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserve, 0x1::type_name::get<T0>());
        if (0x2::balance::value<T0>(v5) >= v4) {
            v0.weight = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(0);
            0x2::balance::join<T0>(&mut v0.collector, 0x2::balance::split<T0>(v5, v4));
            v0.expected_amount = 0;
        } else {
            0x2::balance::join<T0>(&mut v0.collector, 0x2::balance::withdraw_all<T0>(v5));
            v0.expected_amount = v4 - 0x2::balance::value<T0>(&v0.collector);
        };
        let v6 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        while (0x1::vector::length<0x1::type_name::TypeName>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v6);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.partner_receipts, v7);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.partner_requests, v7);
        };
        v0
    }

    public fun create_sell_share_request_for_claiming_management_fee<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg2: &VaultCap, arg3: &0x2::clock::Clock) : SellShareRequest<T0> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg2.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = SellShareRequest<T0>{
            vault_id                 : *0x2::object::uid_as_inner(&arg0.id),
            burned_share             : 0,
            weight                   : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(0),
            expected_amount          : 0,
            collector                : 0x2::balance::zero<T0>(),
            partner_requests         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            partner_confirm_requests : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            partner_receipts         : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v1 = vault_total_base_amount<T0, T1>(arg0, arg1, arg3);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::add_record<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id), calculate_platform_fee<T0, T1>(arg0, v1, arg1, arg3));
        arg0.latest_updated_ts = 0x2::clock::timestamp_ms(arg3);
        let v2 = calculate_management_fee<T0, T1>(arg0, v1, arg3);
        let v3 = borrow_collector_mut<T0, T1>(arg0);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::add_unclaimed_amount<T0>(v3, v2);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::set_unclaimed_amount_to_zero<T0>(v3);
        v0.weight = get_fee_float(0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::collector::unclaimed_amount<T0>(v3), v1);
        let v4 = 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::unclaimed_base_amount<T0>(arg1, *0x2::object::uid_as_inner(&arg0.id));
        let v5 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserve, 0x1::type_name::get<T0>());
        if (0x2::balance::value<T0>(v5) >= v4) {
            v0.weight = 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(0);
            0x2::balance::join<T0>(&mut v0.collector, 0x2::balance::split<T0>(v5, v4));
            v0.expected_amount = 0;
        } else {
            0x2::balance::join<T0>(&mut v0.collector, 0x2::balance::withdraw_all<T0>(v5));
            v0.expected_amount = v4 - 0x2::balance::value<T0>(&v0.collector);
        };
        let v6 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        while (0x1::vector::length<0x1::type_name::TypeName>(&v6) > 0) {
            let v7 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v6);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.partner_receipts, v7);
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.partner_requests, v7);
        };
        v0
    }

    public fun create_unlock_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &mut RedeemSuccessReceipt, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.unlock_partners, &v0)) {
            err_partner_not_locked();
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.unlock_partners, &v0);
        new_unlock_message<T0, T1, T2>(arg0, arg2)
    }

    fun err_adapter_amount_expired() {
        abort 100000
    }

    fun err_asset_not_in_whitelist() {
        abort 100004
    }

    fun err_base_not_allowed() {
        abort 100022
    }

    fun err_confirm_amount_not_matched() {
        abort 100015
    }

    fun err_different_partners_after_sell_share() {
        abort 100016
    }

    fun err_existed_redeem_message_not_create() {
        abort 100011
    }

    fun err_exsited_partner_not_unlocked() {
        abort 100017
    }

    fun err_exsited_partner_not_verified() {
        abort 100012
    }

    fun err_individual_vault() {
        abort 100021
    }

    fun err_less_than_reserve_state() {
        abort 100019
    }

    fun err_main_vault_id_not_matched() {
        abort 100018
    }

    fun err_partner_already_existed() {
        abort 100007
    }

    fun err_partner_not_locked() {
        abort 100014
    }

    fun err_partner_not_supported() {
        abort 100006
    }

    fun err_partner_receipt_not_existed() {
        abort 100009
    }

    fun err_partner_request_existed() {
        abort 100010
    }

    fun err_redeem_balance_not_enough() {
        abort 100013
    }

    fun err_redeem_verify_failed() {
        abort 100008
    }

    fun err_reserve_balance_not_enough() {
        abort 100005
    }

    fun err_reserve_state_not_the_last() {
        abort 100020
    }

    fun err_source_not_allowed() {
        abort 100002
    }

    fun err_vault_cap_id_not_matched() {
        abort 100003
    }

    fun err_vault_id_not_matched() {
        abort 100001
    }

    fun extract_asset_info<T0: drop>(arg0: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T0, MainVault>) : (vector<0x1::ascii::String>, vector<u64>, vector<bool>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T0, MainVault>(arg0, &v0);
        0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id");
        0x2::bag::destroy_empty(v1);
        (0x2::bag::remove<vector<u8>, vector<0x1::ascii::String>>(&mut v1, b"asset_types"), 0x2::bag::remove<vector<u8>, vector<u64>>(&mut v1, b"amounts"), 0x2::bag::remove<vector<u8>, vector<bool>>(&mut v1, b"is_positives"))
    }

    public fun fetch_reserve_total_value<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault> {
        let v0 = 0x1::vector::empty<0x1::ascii::String>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.reserve_record);
        if (0x1::vector::length<0x1::ascii::String>(&v2) > 0) {
            let v3 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v2);
            let v4 = *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.reserve_record, &v3);
            0x1::vector::push_back<0x1::ascii::String>(&mut v0, v3);
            0x1::vector::push_back<u64>(&mut v1, v4);
            abort v4
        };
        new_total_value_message<T0, T1, MainVault>(arg0, v0, v1, 0x1::vector::empty<bool>(), arg1)
    }

    public fun fill_balance_to_request<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: &mut SellShareRequest<T0>) {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = 0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reserve, 0x1::type_name::get<T0>());
        let v1 = 0x2::balance::value<T0>(v0);
        if (v1 >= arg1.expected_amount) {
            0x2::balance::join<T0>(&mut arg1.collector, 0x2::balance::split<T0>(v0, arg1.expected_amount));
            arg1.expected_amount = 0;
        } else {
            0x2::balance::join<T0>(&mut arg1.collector, 0x2::balance::withdraw_all<T0>(v0));
            arg1.expected_amount = arg1.expected_amount - v1;
        };
    }

    public fun generate_simple_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &VaultCap, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, T2>(&v0, arg2);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v1
    }

    fun get_fee_float(arg0: u64, arg1: u64) : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float {
        0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from_fraction(arg0, arg1)
    }

    fun get_withdraw_float<T0, T1>(arg0: &Vault<T0, T1>, arg1: u64) : 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float {
        0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from_fraction(arg1, 0x2::balance::supply_value<T1>(&arg0.supply))
    }

    fun is_partner_supported<T0, T1, T2: drop>(arg0: &Vault<T0, T1>) : bool {
        let v0 = 0x1::type_name::get<T2>();
        0x2::vec_map::contains<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation, &v0)
    }

    fun new_generated_state_proof_message<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, MainVault>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, MainVault, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, MainVault, vector<u8>, bool>(&mut v1, &v3, b"is_sate_generated", true);
        v1
    }

    public fun new_redeem_message<T0, T1, T2: drop>(arg0: &mut SellShareRequest<T0>, arg1: &Vault<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        let v0 = 0x1::type_name::get<T2>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.partner_requests, &v0)) {
            err_partner_already_existed();
        };
        if (is_partner_supported<T0, T1, T2>(arg1)) {
            err_partner_not_supported();
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.partner_receipts, &v0);
        let v1 = stamp();
        let v2 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, T2>(&v1, arg2);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::Float>(&mut v2, &v3, b"weight", arg0.weight);
        let v4 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0x2::object::ID>(&mut v2, &v4, b"main_vault_id", *0x2::object::uid_as_inner(&arg1.id));
        v2
    }

    public fun new_reserve_state<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault>, arg2: &mut 0x2::tx_context::TxContext) : (ReserveState, 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault>) {
        let v0 = ReserveState{reserve: 0x2::vec_map::empty<0x1::ascii::String, u64>()};
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.reserve_record);
        while (0x1::vector::length<0x1::ascii::String>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v1);
            if (v2 != 0x1::type_name::into_string(0x1::type_name::get<T0>())) {
                let v3 = &mut v0.reserve;
                add_amount(v3, v2, 0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::floor(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::mul_u64(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::sub(0xce36dcf1d175659e78e42e3478e6fea3110fc3914bb70210df51dec9ef3d6c37::float::from(1), check_and_extract_weight<T0, T1>(arg0, arg1)), *0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.reserve_record, &v2))));
            };
        };
        (v0, new_generated_state_proof_message<T0, T1>(arg0, arg2))
    }

    fun new_simple_message_<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, T2>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v1
    }

    fun new_single_asset<T0, T1, T2: drop, T3>(arg0: &Vault<T0, T1>, arg1: 0x2::balance::Balance<T3>, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<MainVault, T2, T3> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::new<MainVault, T2, T3>(&v0, arg1, arg2);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::set_extra_info<MainVault, T2, T3, vector<u8>, 0x2::object::ID>(&mut v1, &v2, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v1
    }

    fun new_total_value_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: vector<0x1::ascii::String>, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, T2>(&v0, arg4);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, vector<0x1::ascii::String>>(&mut v1, &v2, b"asset_types", arg1);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, vector<u64>>(&mut v1, &v3, b"amounts", arg2);
        let v4 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, vector<bool>>(&mut v1, &v4, b"is_positives", arg3);
        let v5 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0x2::object::ID>(&mut v1, &v5, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v1
    }

    fun new_unlock_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, T2>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, bool>(&mut v1, &v2, b"is_unlocked", true);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0x2::object::ID>(&mut v1, &v3, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v1
    }

    fun new_verified_message<T0, T1>(arg0: &Vault<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault> {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, MainVault>(&v0, arg1);
        let v2 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, MainVault, vector<u8>, bool>(&mut v1, &v2, b"is_verified", true);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, MainVault, vector<u8>, 0x2::object::ID>(&mut v1, &v3, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v1
    }

    fun pre_check_and_extract_asset<T0, T1, T2: drop, T3>(arg0: &Vault<T0, T1>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T2, MainVault, T3>) : 0x2::balance::Balance<T3> {
        let v0 = stamp();
        if (0x2::bag::remove<vector<u8>, 0x2::object::ID>(0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::borrow_extra_info_mut<T2, MainVault, T3>(&mut arg1, &v0), b"main_vault_id") != *0x2::object::uid_as_inner(&arg0.id)) {
            err_vault_id_not_matched();
        };
        let v1 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::burn<T2, MainVault, T3>(arg1, &v1)
    }

    public fun put_asset_back<T0, T1, T2: drop, T3>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg3: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T2, MainVault, T3>) {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        put_asset_back_<T0, T1, T2, T3>(arg0, arg2, arg3);
    }

    public fun put_asset_back_<T0, T1, T2: drop, T3>(arg0: &mut Vault<T0, T1>, arg1: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg2: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T2, MainVault, T3>) {
        if (!0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::is_allowed_protocol<T2>(arg1)) {
            err_source_not_allowed();
        };
        if (!0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::is_coin_type_in_whitelist(arg1, 0x1::type_name::into_string(0x1::type_name::get<T3>()))) {
            err_asset_not_in_whitelist();
        };
        if (!is_partner_supported<T0, T1, T2>(arg0)) {
            err_partner_not_supported();
        };
        let v0 = pre_check_and_extract_asset<T0, T1, T2, T3>(arg0, arg2);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::vault_event::put_balance_event<T0, T1, T2, T3>(*0x2::object::uid_as_inner(&arg0.id), 0x2::balance::value<T3>(&v0));
        add_to_reserve<T0, T1, T3>(arg0, v0);
    }

    public fun put_asset_back_for_selling_shares<T0, T1, T2: drop, T3>(arg0: &mut Vault<T0, T1>, arg1: &SellShareRequest<T0>, arg2: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg3: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<T2, MainVault, T3>) {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        if (0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.partner_confirm_requests)) != 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            err_confirm_amount_not_matched();
        };
        put_asset_back_<T0, T1, T2, T3>(arg0, arg2, arg3);
    }

    public fun repay_sell_share<T0, T1>(arg0: &Vault<T0, T1>, arg1: SellShareRequest<T0>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, RedeemSuccessReceipt) {
        let SellShareRequest {
            vault_id                 : v0,
            burned_share             : v1,
            weight                   : _,
            expected_amount          : v3,
            collector                : v4,
            partner_requests         : v5,
            partner_confirm_requests : v6,
            partner_receipts         : v7,
        } = arg1;
        let v8 = v7;
        let v9 = v6;
        let v10 = v5;
        let v11 = v4;
        if (0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&v10)) != 0) {
            err_existed_redeem_message_not_create();
        };
        if (0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&v8)) != 0) {
            err_exsited_partner_not_verified();
        };
        if (*0x2::object::uid_as_inner(&arg0.id) != v0) {
            err_vault_id_not_matched();
        };
        if (v3 > 0) {
            err_redeem_balance_not_enough();
        };
        let v12 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        if (0x1::vector::length<0x1::type_name::TypeName>(&v12) != 0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&v9))) {
            err_different_partners_after_sell_share();
        };
        let v13 = *0x2::vec_set::keys<0x1::type_name::TypeName>(&v9);
        while (0x1::vector::length<0x1::type_name::TypeName>(&v13) > 0) {
            let v14 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v13);
            if (!0x2::vec_map::contains<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation, &v14)) {
                err_different_partners_after_sell_share();
            };
        };
        let v15 = 0x1::type_name::get<MainVault>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v9, &v15);
        let v16 = RedeemSuccessReceipt{unlock_partners: v9};
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::vault_event::sell_share_event<T0, T1>(*0x2::object::uid_as_inner(&arg0.id), 0x2::balance::value<T0>(&v11), v1);
        (0x2::coin::from_balance<T0>(v11, arg2), v16)
    }

    fun request_confirm_<T0, T1: drop>(arg0: &mut SellShareRequest<T0>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T1, MainVault>) {
        let v0 = stamp();
        let v1 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::burn_and_get_info<T1, MainVault>(arg1, &v0);
        if (0x2::bag::remove<vector<u8>, 0x2::object::ID>(&mut v1, b"main_vault_id") != arg0.vault_id) {
            err_vault_id_not_matched();
        };
        if (0x2::bag::remove<vector<u8>, bool>(&mut v1, b"is_state_generated")) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.partner_confirm_requests, 0x1::type_name::get<T1>());
        };
        0x2::bag::destroy_empty(v1);
    }

    fun stamp() : MainVault {
        MainVault{dummy_field: false}
    }

    public fun support_new_partner<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, T2> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = BaseAmount{
            amount         : 0,
            last_update_ts : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, BaseAmount>(&mut arg0.allocation, 0x1::type_name::get<T2>(), v0);
        let v1 = stamp();
        let v2 = 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::new<MainVault, T2>(&v1, arg3);
        let v3 = stamp();
        0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::set_info<MainVault, T2, vector<u8>, 0x2::object::ID>(&mut v2, &v3, b"main_vault_id", *0x2::object::uid_as_inner(&arg0.id));
        v2
    }

    public fun take_asset_out<T0, T1, T2: drop, T3>(arg0: &mut Vault<T0, T1>, arg1: &VaultCap, arg2: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<MainVault, T2, T3> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = take_asset_out_<T0, T1, T2, T3>(arg0, arg2, arg3);
        new_single_asset<T0, T1, T2, T3>(arg0, v0, arg4)
    }

    fun take_asset_out_<T0, T1, T2: drop, T3>(arg0: &mut Vault<T0, T1>, arg1: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg2: u64) : 0x2::balance::Balance<T3> {
        let v0 = 0x1::type_name::get<T3>();
        if (!0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::is_allowed_protocol<T2>(arg1)) {
            err_source_not_allowed();
        };
        if (!is_partner_supported<T0, T1, T2>(arg0)) {
            err_partner_not_supported();
        };
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&arg0.reserve_record);
        let v2 = 0x1::type_name::into_string(v0);
        if (!0x1::vector::contains<0x1::ascii::String>(&v1, &v2)) {
            return 0x2::balance::zero<T3>()
        };
        if (0x2::balance::value<T3>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&arg0.reserve, v0)) < arg2) {
            err_reserve_balance_not_enough();
        };
        let v3 = 0x2::balance::split<T3>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T3>>(&mut arg0.reserve, v0), arg2);
        let v4 = 0x1::type_name::get<T3>();
        let v5 = 0x1::type_name::into_string(v4);
        let (_, v7) = 0x2::vec_map::remove<0x1::ascii::String, u64>(&mut arg0.reserve_record, &v5);
        0x2::vec_map::insert<0x1::ascii::String, u64>(&mut arg0.reserve_record, 0x1::type_name::into_string(v4), v7 - arg2);
        0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::vault_event::take_balance_event<T0, T1, T2, T3>(*0x2::object::uid_as_inner(&arg0.id), 0x2::balance::value<T3>(&v3));
        v3
    }

    public fun take_asset_out_for_selling_shares<T0, T1, T2: drop, T3>(arg0: &mut Vault<T0, T1>, arg1: &SellShareRequest<T0>, arg2: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::asset::Asset<MainVault, T2, T3> {
        if (*0x2::object::uid_as_inner(&arg0.id) != arg1.vault_id) {
            err_vault_cap_id_not_matched();
        };
        let v0 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        if (0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.partner_confirm_requests)) != 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            err_confirm_amount_not_matched();
        };
        let v1 = take_asset_out_<T0, T1, T2, T3>(arg0, arg2, arg3);
        new_single_asset<T0, T1, T2, T3>(arg0, v1, arg4)
    }

    public fun update_vault_value<T0, T1, T2: drop>(arg0: &mut Vault<T0, T1>, arg1: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T2, MainVault>, arg2: &0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::stingray_oracle::StingrayOracle, arg3: &0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::Whitelist, arg4: &0x2::clock::Clock) {
        let v0 = 0;
        if (!0x6e9ee79a8ac36806d5db62f5578ce4f38c6c79fb5937fcf3b2fdae7285811d3f::whitelist::is_allowed_protocol<T2>(arg3)) {
            err_source_not_allowed();
        };
        let v1 = &mut arg1;
        check_message<T0, T1, T2>(arg0, v1);
        let v2 = 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::stingray_oracle::get_price(arg2, arg4, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let (v3, v4, v5) = extract_asset_info<T2>(arg1);
        let v6 = v5;
        let v7 = v4;
        let v8 = v3;
        if (0x1::vector::length<0x1::ascii::String>(&v8) == 0) {
            let v9 = 0x1::type_name::get<T2>();
            let v10 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, BaseAmount>(&mut arg0.allocation, &v9);
            v10.amount = 0;
            v10.last_update_ts = 0x2::clock::timestamp_ms(arg4);
        };
        let v11 = 0;
        while (v11 < 0x1::vector::length<0x1::ascii::String>(&v8)) {
            let v12 = 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::stingray_oracle::get_price(arg2, arg4, *0x1::vector::borrow<0x1::ascii::String>(&v8, v11));
            let v13 = if (0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v12) >= 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v2)) {
                *0x1::vector::borrow<u64>(&v7, v11) * 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::price(&v2) / 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::price(&v12) / 0x1::u64::pow(10, 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v12) - 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v2))
            } else {
                *0x1::vector::borrow<u64>(&v7, v11) * 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::price(&v2) / 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::price(&v12) * 0x1::u64::pow(10, 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v12) - 0xae407da0a7721a991faab902372505c1cec368777086bfd4bc8202645a6cb9fd::oracle_aggregator::decimals(&v2))
            };
            if (*0x1::vector::borrow<bool>(&v6, v11)) {
                v0 = v0 + v13;
            } else {
                v0 = v0 - v13;
            };
            let v14 = 0x1::type_name::get<T2>();
            let v15 = 0x2::vec_map::get_mut<0x1::type_name::TypeName, BaseAmount>(&mut arg0.allocation, &v14);
            v15.amount = v0;
            v15.last_update_ts = 0x2::clock::timestamp_ms(arg4);
            v11 = v11 + 1;
        };
    }

    public fun vault_total_base_amount<T0, T1>(arg0: &Vault<T0, T1>, arg1: &0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::Stingray, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0;
        let v1 = 0x2::vec_map::keys<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation);
        while (0x1::vector::length<0x1::type_name::TypeName>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::type_name::TypeName>(&mut v1);
            let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, BaseAmount>(&arg0.allocation, &v2);
            if (0x2::clock::timestamp_ms(arg2) - v3.last_update_ts > 0x860442e62426c5fb4f00fc08fde155e39253f1cd4496fdb16c926c94760241a2::stingray::tolerance_ts(arg1)) {
                err_adapter_amount_expired();
            };
            v0 = v0 + v3.amount;
        };
        v0
    }

    public fun verify_redeem_message<T0, T1, T2: drop>(arg0: &Vault<T0, T1>, arg1: &mut SellShareRequest<T0>, arg2: 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<T2, MainVault>) {
        let v0 = 0x1::type_name::get<T2>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.partner_receipts, &v0)) {
            err_partner_receipt_not_existed();
        };
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg1.partner_requests, &v0)) {
            err_partner_request_existed();
        };
        check_and_burn_verified_message<T0, T1, T2>(arg0, arg2);
        if (v0 == 0x1::type_name::get<MainVault>()) {
            if (0x1::vector::length<0x1::type_name::TypeName>(0x2::vec_set::keys<0x1::type_name::TypeName>(&arg1.partner_receipts)) > 1) {
                err_reserve_state_not_the_last();
            };
        };
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg1.partner_receipts, &v0);
    }

    public fun verify_reserve_state<T0, T1>(arg0: &mut Vault<T0, T1>, arg1: ReserveState, arg2: &mut 0x2::tx_context::TxContext) : 0xd0a66f97193dde2b87a4c3e817bba626114067f27e1323086fb1f41b1117451d::message::Message<MainVault, MainVault> {
        let ReserveState { reserve: v0 } = arg1;
        let v1 = 0x2::vec_map::keys<0x1::ascii::String, u64>(&v0);
        while (0x1::vector::length<0x1::ascii::String>(&v1) > 0) {
            let v2 = 0x1::vector::pop_back<0x1::ascii::String>(&mut v1);
            if (*0x2::vec_map::get<0x1::ascii::String, u64>(&arg0.reserve_record, &v2) < *0x2::vec_map::get<0x1::ascii::String, u64>(&v0, &v2)) {
                err_less_than_reserve_state();
            };
        };
        new_verified_message<T0, T1>(arg0, arg2)
    }

    // decompiled from Move bytecode v6
}

