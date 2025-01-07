module 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool_account {
    struct SpoolAccount<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>,
        stake_type: 0x1::type_name::TypeName,
        stakes: 0x2::balance::Balance<T0>,
        points: 0x2::table::Table<0x1::type_name::TypeName, SpoolAccountPoint>,
        points_list: vector<0x1::type_name::TypeName>,
        binded_ve_sca_key: 0x1::option::Option<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>>,
    }

    struct SpoolAccountPoint has store {
        weighted_amount: u64,
        points: u64,
        total_points: u64,
        index: u64,
    }

    struct SpoolAccountKey has store, key {
        id: 0x2::object::UID,
        spool_account_id: 0x2::object::ID,
        spool_stake_type: 0x1::type_name::TypeName,
    }

    struct EarningWeight has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        weighted_amount: u64,
    }

    public(friend) fun new<T0>(arg0: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg1: &mut 0x2::tx_context::TxContext) : (SpoolAccount<T0>, SpoolAccountKey) {
        let v0 = SpoolAccount<T0>{
            id                : 0x2::object::new(arg1),
            spool_id          : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::new<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg0),
            stake_type        : 0x1::type_name::get<T0>(),
            stakes            : 0x2::balance::zero<T0>(),
            points            : 0x2::table::new<0x1::type_name::TypeName, SpoolAccountPoint>(arg1),
            points_list       : 0x1::vector::empty<0x1::type_name::TypeName>(),
            binded_ve_sca_key : 0x1::option::none<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>>(),
        };
        let v1 = SpoolAccountKey{
            id               : 0x2::object::new(arg1),
            spool_account_id : 0x2::object::id<SpoolAccount<T0>>(&v0),
            spool_stake_type : 0x1::type_name::get<T0>(),
        };
        (v0, v1)
    }

    fun is_points_up_to_date<T0>(arg0: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg1: &SpoolAccount<T0>) : bool {
        let v0 = true;
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1.points_list)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.points_list, v1);
            if (0x2::table::borrow<0x1::type_name::TypeName, SpoolAccountPoint>(&arg1.points, v2).index != 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::index(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::spool_point(arg0, v2))) {
                v0 = false;
                break
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun stake<T0>(arg0: &mut SpoolAccount<T0>, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg2: 0x2::balance::Balance<T0>) {
        assert!(is_points_up_to_date<T0>(arg1, arg0), 17);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::stake(arg1, 0x2::balance::value<T0>(&arg2));
        0x2::balance::join<T0>(&mut arg0.stakes, arg2);
    }

    public(friend) fun unstake<T0>(arg0: &mut SpoolAccount<T0>, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg2: u64) : 0x2::balance::Balance<T0> {
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::unstake(arg1, arg2);
        0x2::balance::split<T0>(&mut arg0.stakes, arg2)
    }

    public(friend) fun accrue_points<T0>(arg0: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg1: &mut SpoolAccount<T0>, arg2: &0x2::clock::Clock) {
        assert!(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::is_points_up_to_date(arg0, arg2), 18);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1.points_list)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.points_list, v0);
            let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolAccountPoint>(&mut arg1.points, v1);
            let v3 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::index(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::spool_point(arg0, v1));
            if (v2.index >= v3) {
                v0 = v0 + 1;
                continue
            };
            if (v2.weighted_amount == 0) {
                v2.index = v3;
                v0 = v0 + 1;
                continue
            };
            let v4 = 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::utils::mul_div(v2.weighted_amount, v3 - v2.index, 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::base_index_rate());
            v2.index = v3;
            v2.points = v2.points + v4;
            v2.total_points = v2.total_points + v4;
            v0 = v0 + 1;
        };
    }

    public fun assert_ownership<T0>(arg0: &SpoolAccount<T0>, arg1: &SpoolAccountKey) {
        assert!(0x2::object::id<SpoolAccount<T0>>(arg0) == arg1.spool_account_id, 20);
    }

    public fun assert_pool_id<T0>(arg0: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg1: &SpoolAccount<T0>) {
        assert!(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::to_id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg1.spool_id) == 0x2::object::id<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool>(arg0), 19);
    }

    public(friend) fun bind_ve_sca<T0>(arg0: &mut SpoolAccount<T0>, arg1: 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>) {
        arg0.binded_ve_sca_key = 0x1::option::some<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>>(arg1);
    }

    public fun earning_weight_list<T0>(arg0: &SpoolAccount<T0>) : vector<EarningWeight> {
        let v0 = 0x1::vector::empty<EarningWeight>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v1);
            let v3 = EarningWeight{
                coin_type       : v2,
                weighted_amount : 0x2::table::borrow<0x1::type_name::TypeName, SpoolAccountPoint>(&arg0.points, v2).weighted_amount,
            };
            0x1::vector::push_back<EarningWeight>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_binded_ve_sca<T0>(arg0: &SpoolAccount<T0>) : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey> {
        *0x1::option::borrow<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>>(&arg0.binded_ve_sca_key)
    }

    public fun is_spool_account_point_exist<T0>(arg0: &SpoolAccount<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, SpoolAccountPoint>(&arg0.points, arg1)
    }

    public fun is_ve_sca_key_binded<T0>(arg0: &SpoolAccount<T0>) : bool {
        0x1::option::is_some<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>>(&arg0.binded_ve_sca_key)
    }

    public(friend) fun new_spool_account_point<T0>(arg0: &mut SpoolAccount<T0>, arg1: &0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg2: 0x1::type_name::TypeName) {
        let v0 = SpoolAccountPoint{
            weighted_amount : 0,
            points          : 0,
            total_points    : 0,
            index           : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::index(0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::spool_point(arg1, arg2)),
        };
        0x2::table::add<0x1::type_name::TypeName, SpoolAccountPoint>(&mut arg0.points, arg2, v0);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.points_list, arg2);
    }

    public fun points(arg0: &SpoolAccountPoint) : u64 {
        arg0.points
    }

    public(friend) fun redeem_rewards<T0, T1>(arg0: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg1: &mut SpoolAccount<T0>, arg2: u64) : 0x2::balance::Balance<T1> {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolAccountPoint>(&mut arg1.points, 0x1::type_name::get<T1>());
        v0.points = v0.points - arg2;
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::take_reward<T1>(arg0, arg2)
    }

    public(friend) fun share_spool_account<T0>(arg0: SpoolAccount<T0>) {
        0x2::transfer::share_object<SpoolAccount<T0>>(arg0);
    }

    public fun spool_account_point<T0>(arg0: &SpoolAccount<T0>, arg1: 0x1::type_name::TypeName) : &SpoolAccountPoint {
        0x2::table::borrow<0x1::type_name::TypeName, SpoolAccountPoint>(&arg0.points, arg1)
    }

    public fun spool_id<T0>(arg0: &SpoolAccount<T0>) : 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool> {
        arg0.spool_id
    }

    public fun stake_amount<T0>(arg0: &SpoolAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stakes)
    }

    public fun stake_type<T0>(arg0: &SpoolAccount<T0>) : 0x1::type_name::TypeName {
        arg0.stake_type
    }

    public fun total_points(arg0: &SpoolAccountPoint) : u64 {
        arg0.total_points
    }

    public(friend) fun unbind_ve_sca<T0>(arg0: &mut SpoolAccount<T0>) {
        arg0.binded_ve_sca_key = 0x1::option::none<0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::typed_id::TypedID<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>>();
    }

    public(friend) fun update_weighted_amount<T0>(arg0: &mut SpoolAccount<T0>, arg1: &mut 0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::Spool, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, SpoolAccountPoint>(&mut arg0.points, arg2);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::deduct_weighted_amount(arg1, arg2, v0.weighted_amount);
        0x98ca993b250e36d99530f9500fff481c39d64e70a8f79260bfbe642a8c69bb54::spool::add_weighted_amount(arg1, arg2, arg3);
        v0.weighted_amount = arg3;
    }

    public fun weighted_amount(arg0: &SpoolAccountPoint) : u64 {
        arg0.weighted_amount
    }

    // decompiled from Move bytecode v6
}

