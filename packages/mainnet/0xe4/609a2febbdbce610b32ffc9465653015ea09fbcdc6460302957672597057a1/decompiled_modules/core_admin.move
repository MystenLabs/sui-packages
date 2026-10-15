module 0xe4609a2febbdbce610b32ffc9465653015ea09fbcdc6460302957672597057a1::core_admin {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct AdminEvent has copy, drop {
        sender: address,
        scope: u8,
        kind: u8,
        index: u64,
        types: vector<0x1::type_name::TypeName>,
        ids: vector<0x2::object::ID>,
        values: vector<u64>,
    }

    struct TypusHooksSwitchedEvent has copy, drop {
        disabled: bool,
    }

    struct FeePool has store {
        id: 0x2::object::UID,
        fee_infos: vector<FeeInfo>,
    }

    struct FeeInfo has copy, drop, store {
        token: 0x1::type_name::TypeName,
        value: u64,
    }

    struct FeeRouterConfig has copy, drop, store {
        treasury_bp: u64,
        vesca_bp: u64,
        insurance_bp: u64,
        keeper_bp: u64,
    }

    struct FeeBucketKey has copy, drop, store {
        bucket: u8,
        token: 0x1::type_name::TypeName,
    }

    struct FeeRouterDestinations has copy, drop, store {
        insurance_fund_id: 0x2::object::ID,
        revenue_vault_id: 0x2::object::ID,
        vesca_registry_id: 0x2::object::ID,
        fee_discount_table_id: 0x2::object::ID,
    }

    struct FeeRouterDestinationsUpdatedEvent has copy, drop {
        insurance_fund_id: 0x2::object::ID,
        revenue_vault_id: 0x2::object::ID,
        vesca_registry_id: 0x2::object::ID,
        fee_discount_table_id: 0x2::object::ID,
    }

    struct FeeRouterConfigUpdatedEvent has copy, drop {
        treasury_bp: u64,
        vesca_bp: u64,
        insurance_bp: u64,
        keeper_bp: u64,
    }

    struct FeeRoutedEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        total: u64,
        treasury: u64,
        vesca: u64,
        insurance: u64,
        keeper: u64,
    }

    struct KeeperFeeSentEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct FeeBucketCap has store {
        dummy_field: bool,
    }

    struct PutInsuranceFundEvent has copy, drop {
        token: 0x1::type_name::TypeName,
        amount: u64,
    }

    public(friend) fun uid_mut(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) : &mut 0x2::object::UID {
        let v0 = Witness{dummy_field: false};
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid_mut<Witness>(arg0, v0)
    }

    public(friend) fun verify(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::verify(arg0, arg1);
        version_check(arg0);
    }

    public(friend) fun version_check(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::version_check(arg0);
        let v0 = 0x1::string::utf8(b"core_version");
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(v1, v0), 3003);
        assert!(6 >= *0x2::dynamic_field::borrow<0x1::string::String, u64>(v1, v0), 3);
    }

    public(friend) fun add_competition_leaderboard(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg2: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg3: 0x1::ascii::String, arg4: address, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::ManagerCap>(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0), 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public(friend) fun add_tails_exp_and_leaderboard(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg2: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::user::TypusUserRegistry, arg3: &mut 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::TypusLeaderboardRegistry, arg4: address, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (typus_hooks_disabled(arg0)) {
            return
        };
        let v0 = (((arg5 as u128) * (arg6 as u128) / (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::multiplier(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_usd_decimal()) as u128)) as u64);
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::user::add_tails_exp_amount(0x2::dynamic_field::borrow<0x1::string::String, 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::ManagerCap>(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0), 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg2, arg4, v0);
        0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::leaderboard::score(0x2::dynamic_field::borrow<0x1::string::String, 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::ManagerCap>(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0), 0x1::string::utf8(b"ecosystem_manager_cap")), arg1, arg3, 0x1::ascii::string(b"exp_leaderboard"), arg4, v0, arg7, arg8);
    }

    public fun assert_insurance_fund_destination(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0x2::object::ID) {
        let v0 = fee_router_destinations(arg0);
        assert!(v0.insurance_fund_id == arg1, 2403);
    }

    public fun assert_revenue_destination(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0x2::object::ID, arg2: 0x2::object::ID) {
        let v0 = fee_router_destinations(arg0);
        assert!(v0.revenue_vault_id == arg1 && v0.vesca_registry_id == arg2, 2403);
    }

    public fun bucket_insurance() : u8 {
        3
    }

    public fun bucket_keeper() : u8 {
        4
    }

    public fun bucket_vesca() : u8 {
        2
    }

    public(friend) fun charge_fee<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let (_, v2, v3, v4) = fee_router_config(arg0);
        let v5 = (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128);
        let v6 = (((v0 as u128) * (v2 as u128) / v5) as u64);
        let v7 = (((v0 as u128) * (v3 as u128) / v5) as u64);
        let v8 = (((v0 as u128) * (v4 as u128) / v5) as u64);
        join_fee_bucket<T0>(arg0, 2, 0x2::balance::split<T0>(&mut arg1, v6));
        join_fee_bucket<T0>(arg0, 3, 0x2::balance::split<T0>(&mut arg1, v7));
        join_fee_bucket<T0>(arg0, 4, 0x2::balance::split<T0>(&mut arg1, v8));
        if (v0 > 0) {
            let v9 = FeeRoutedEvent{
                token     : 0x1::type_name::with_defining_ids<T0>(),
                total     : v0,
                treasury  : 0x2::balance::value<T0>(&arg1),
                vesca     : v6,
                insurance : v7,
                keeper    : v8,
            };
            0x2::event::emit<FeeRoutedEvent>(v9);
        };
        let v10 = pool_mut(arg0, b"fee_pool");
        put_into_pool<T0>(v10, arg1);
    }

    public(friend) fun charge_liquidator_fee<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0x2::balance::Balance<T0>) {
        let v0 = pool_mut(arg0, b"liquidator_fee_pool");
        put_into_pool<T0>(v0, arg1);
        let v1 = PutInsuranceFundEvent{
            token  : 0x1::type_name::with_defining_ids<T0>(),
            amount : 0x2::balance::value<T0>(&arg1),
        };
        0x2::event::emit<PutInsuranceFundEvent>(v1);
    }

    public fun core_version(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) : u64 {
        *0x2::dynamic_field::borrow<0x1::string::String, u64>(0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0), 0x1::string::utf8(b"core_version"))
    }

    public(friend) fun emit_admin_event(arg0: u8, arg1: u8, arg2: u64, arg3: vector<0x1::type_name::TypeName>, arg4: vector<0x2::object::ID>, arg5: vector<u64>, arg6: &0x2::tx_context::TxContext) {
        let v0 = AdminEvent{
            sender : 0x2::tx_context::sender(arg6),
            scope  : arg0,
            kind   : arg1,
            index  : arg2,
            types  : arg3,
            ids    : arg4,
            values : arg5,
        };
        0x2::event::emit<AdminEvent>(v0);
    }

    public fun fee_bucket_value<T0>(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u8) : u64 {
        let v0 = FeeBucketKey{
            bucket : arg1,
            token  : 0x1::type_name::with_defining_ids<T0>(),
        };
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0);
        if (!0x2::dynamic_field::exists_<FeeBucketKey>(v1, v0)) {
            return 0
        };
        0x2::balance::value<T0>(0x2::dynamic_field::borrow<FeeBucketKey, 0x2::balance::Balance<T0>>(v1, v0))
    }

    public fun fee_router_config(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) : (u64, u64, u64, u64) {
        let v0 = 0x1::string::utf8(b"fee_router_config");
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            return (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale(), 0, 0, 0)
        };
        let v2 = 0x2::dynamic_field::borrow<0x1::string::String, FeeRouterConfig>(v1, v0);
        (v2.treasury_bp, v2.vesca_bp, v2.insurance_bp, v2.keeper_bp)
    }

    fun fee_router_destinations(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) : FeeRouterDestinations {
        let v0 = 0x1::string::utf8(b"fee_router_destinations");
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(v1, v0), 2402);
        *0x2::dynamic_field::borrow<0x1::string::String, FeeRouterDestinations>(v1, v0)
    }

    entry fun install(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0x2::tx_context::TxContext) {
        0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::register_extension<Witness>(arg0, arg1);
        install_(arg0, arg1);
    }

    fun install_(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = uid_mut(arg0);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(v0, 0x1::string::utf8(b"core_version")), 3004);
        0x2::dynamic_field::add<0x1::string::String, u64>(v0, 0x1::string::utf8(b"core_version"), 6);
        let v1 = FeePool{
            id        : 0x2::object::new(arg1),
            fee_infos : 0x1::vector::empty<FeeInfo>(),
        };
        0x2::dynamic_field::add<0x1::string::String, FeePool>(v0, 0x1::string::utf8(b"fee_pool"), v1);
        let v2 = FeePool{
            id        : 0x2::object::new(arg1),
            fee_infos : 0x1::vector::empty<FeeInfo>(),
        };
        0x2::dynamic_field::add<0x1::string::String, FeePool>(v0, 0x1::string::utf8(b"liquidator_fee_pool"), v2);
    }

    entry fun install_ecosystem_manager_cap_entry(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::Version, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        0x2::dynamic_field::add<0x1::string::String, 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::ManagerCap>(uid_mut(arg0), 0x1::string::utf8(b"ecosystem_manager_cap"), 0x99ded857ba63fc66c21b3d48c0c964c88f4803b4d7a96a41623a30fb9d2cd5c2::ecosystem::issue_manager_cap(arg1, arg2));
    }

    public fun is_fee_discount_table_destination(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0x2::object::ID) : bool {
        let v0 = 0x1::string::utf8(b"fee_router_destinations");
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            return false
        };
        assert!(0x2::dynamic_field::borrow<0x1::string::String, FeeRouterDestinations>(v1, v0).fee_discount_table_id == arg1, 2403);
        true
    }

    public(friend) fun join_fee_bucket<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u8, arg2: 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            0x2::balance::destroy_zero<T0>(arg2);
            return
        };
        let v0 = FeeBucketKey{
            bucket : arg1,
            token  : 0x1::type_name::with_defining_ids<T0>(),
        };
        let v1 = uid_mut(arg0);
        if (0x2::dynamic_field::exists_<FeeBucketKey>(v1, v0)) {
            0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<FeeBucketKey, 0x2::balance::Balance<T0>>(v1, v0), arg2);
        } else {
            0x2::dynamic_field::add<FeeBucketKey, 0x2::balance::Balance<T0>>(v1, v0, arg2);
        };
    }

    public fun mint_fee_bucket_cap(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x2::tx_context::TxContext) : FeeBucketCap {
        verify(arg0, arg1);
        FeeBucketCap{dummy_field: false}
    }

    fun pool_mut(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: vector<u8>) : &mut FeePool {
        let v0 = uid_mut(arg0);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(v0, 0x1::string::utf8(arg1)), 3003);
        0x2::dynamic_field::borrow_mut<0x1::string::String, FeePool>(v0, 0x1::string::utf8(arg1))
    }

    fun put_into_pool<T0>(arg0: &mut FeePool, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<FeeInfo>(&arg0.fee_infos)) {
            let v2 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_infos, v1);
            if (v2.token == v0) {
                v2.value = v2.value + 0x2::balance::value<T0>(&arg1);
                0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1);
                return
            };
            v1 = v1 + 1;
        };
        let v3 = FeeInfo{
            token : v0,
            value : 0x2::balance::value<T0>(&arg1),
        };
        0x1::vector::push_back<FeeInfo>(&mut arg0.fee_infos, v3);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0, arg1);
    }

    public fun return_vesca_bucket<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &FeeBucketCap, arg2: 0x2::balance::Balance<T0>) {
        version_check(arg0);
        join_fee_bucket<T0>(arg0, 2, arg2);
    }

    entry fun send_fee<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0x2::tx_context::TxContext) {
        verify(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = pool_mut(arg0, b"fee_pool");
        let v2 = take_from_pool(v1, v0);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut pool_mut(arg0, b"fee_pool").id, v0)), arg1), @0x1);
            let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v0);
            let v4 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v4, v2);
            emit_admin_event(2, 0, 0, v3, 0x1::vector::empty<0x2::object::ID>(), v4, arg1);
        };
    }

    entry fun send_keeper_fee<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        let v0 = take_fee_bucket<T0>(arg0, 4);
        let v1 = 0x2::balance::value<T0>(&v0);
        assert!(v1 > 0, 2401);
        let v2 = KeeperFeeSentEvent{
            token     : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v1,
            recipient : arg1,
        };
        0x2::event::emit<KeeperFeeSentEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg2), arg1);
    }

    entry fun send_liquidator_fee<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &mut 0x2::tx_context::TxContext) {
        verify(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = pool_mut(arg0, b"liquidator_fee_pool");
        let v2 = take_from_pool(v1, v0);
        if (v2 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut pool_mut(arg0, b"liquidator_fee_pool").id, v0)), arg1), @0x2);
        let v3 = 0x1::vector::empty<0x1::type_name::TypeName>();
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut v3, v0);
        let v4 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v4, v2);
        emit_admin_event(2, 1, 0, v3, 0x1::vector::empty<0x2::object::ID>(), v4, arg1);
    }

    entry fun set_fee_router_config(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        verify(arg0, arg5);
        assert!((arg1 as u128) + (arg2 as u128) + (arg3 as u128) + (arg4 as u128) == (0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::math::get_bp_scale() as u128), 2400);
        let v0 = 0x1::string::utf8(b"fee_router_config");
        let v1 = uid_mut(arg0);
        if (0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            0x2::dynamic_field::remove<0x1::string::String, FeeRouterConfig>(v1, v0);
        };
        let v2 = FeeRouterConfig{
            treasury_bp  : arg1,
            vesca_bp     : arg2,
            insurance_bp : arg3,
            keeper_bp    : arg4,
        };
        0x2::dynamic_field::add<0x1::string::String, FeeRouterConfig>(v1, v0, v2);
        let v3 = FeeRouterConfigUpdatedEvent{
            treasury_bp  : arg1,
            vesca_bp     : arg2,
            insurance_bp : arg3,
            keeper_bp    : arg4,
        };
        0x2::event::emit<FeeRouterConfigUpdatedEvent>(v3);
    }

    entry fun set_fee_router_destinations(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) {
        verify(arg0, arg5);
        let v0 = 0x1::string::utf8(b"fee_router_destinations");
        let v1 = uid_mut(arg0);
        if (0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            0x2::dynamic_field::remove<0x1::string::String, FeeRouterDestinations>(v1, v0);
        };
        let v2 = FeeRouterDestinations{
            insurance_fund_id     : arg1,
            revenue_vault_id      : arg2,
            vesca_registry_id     : arg3,
            fee_discount_table_id : arg4,
        };
        0x2::dynamic_field::add<0x1::string::String, FeeRouterDestinations>(v1, v0, v2);
        let v3 = FeeRouterDestinationsUpdatedEvent{
            insurance_fund_id     : arg1,
            revenue_vault_id      : arg2,
            vesca_registry_id     : arg3,
            fee_discount_table_id : arg4,
        };
        0x2::event::emit<FeeRouterDestinationsUpdatedEvent>(v3);
    }

    entry fun set_typus_hooks_disabled(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        verify(arg0, arg2);
        let v0 = 0x1::string::utf8(b"typus_hooks_disabled");
        let v1 = uid_mut(arg0);
        if (0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            0x2::dynamic_field::remove<0x1::string::String, bool>(v1, v0);
        };
        0x2::dynamic_field::add<0x1::string::String, bool>(v1, v0, arg1);
        let v2 = TypusHooksSwitchedEvent{disabled: arg1};
        0x2::event::emit<TypusHooksSwitchedEvent>(v2);
    }

    public(friend) fun take_fee_bucket<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: u8) : 0x2::balance::Balance<T0> {
        let v0 = FeeBucketKey{
            bucket : arg1,
            token  : 0x1::type_name::with_defining_ids<T0>(),
        };
        let v1 = uid_mut(arg0);
        if (!0x2::dynamic_field::exists_<FeeBucketKey>(v1, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<FeeBucketKey, 0x2::balance::Balance<T0>>(v1, v0))
    }

    fun take_from_pool(arg0: &mut FeePool, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<FeeInfo>(&arg0.fee_infos)) {
            let v1 = 0x1::vector::borrow_mut<FeeInfo>(&mut arg0.fee_infos, v0);
            if (v1.token == arg1) {
                v1.value = 0;
                return v1.value
            };
            v0 = v0 + 1;
        };
        0
    }

    public(friend) fun take_liquidator_fee_pool<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = pool_mut(arg0, b"liquidator_fee_pool");
        let v2 = take_from_pool(v1, v0);
        if (v2 == 0 && !0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&v1.id, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut v1.id, v0))
    }

    public fun take_vesca_bucket<T0>(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &FeeBucketCap) : 0x2::balance::Balance<T0> {
        version_check(arg0);
        take_fee_bucket<T0>(arg0, 2)
    }

    public(friend) fun typus_hooks_disabled(arg0: &0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version) : bool {
        let v0 = 0x1::string::utf8(b"typus_hooks_disabled");
        let v1 = 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::uid(arg0);
        0x2::dynamic_field::exists_<0x1::string::String>(v1, v0) && *0x2::dynamic_field::borrow<0x1::string::String, bool>(v1, v0)
    }

    entry fun upgrade(arg0: &mut 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::admin::Version, arg1: &0x2::tx_context::TxContext) {
        verify(arg0, arg1);
        *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(uid_mut(arg0), 0x1::string::utf8(b"core_version")) = 6;
    }

    // decompiled from Move bytecode v7
}

