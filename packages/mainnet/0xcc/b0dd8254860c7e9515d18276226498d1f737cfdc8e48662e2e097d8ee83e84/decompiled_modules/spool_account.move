module 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool_account {
    struct SpoolAccount<phantom T0> has store, key {
        id: 0x2::object::UID,
        spool_id: 0x2::object::ID,
        stake_type: 0x1::type_name::TypeName,
        stakes: 0x2::balance::Balance<T0>,
        points: u64,
        index: u64,
    }

    struct SpoolAccountKey has store, key {
        id: 0x2::object::UID,
        spool_account_id: 0x2::object::ID,
    }

    public(friend) fun new<T0>(arg0: &0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool, arg1: &mut 0x2::tx_context::TxContext) : (SpoolAccountKey, SpoolAccount<T0>) {
        let v0 = SpoolAccount<T0>{
            id         : 0x2::object::new(arg1),
            spool_id   : 0x2::object::id<0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool>(arg0),
            stake_type : 0x1::type_name::get<T0>(),
            stakes     : 0x2::balance::zero<T0>(),
            points     : 0,
            index      : 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::index(arg0),
        };
        let v1 = SpoolAccountKey{
            id               : 0x2::object::new(arg1),
            spool_account_id : 0x2::object::id<SpoolAccount<T0>>(&v0),
        };
        (v1, v0)
    }

    public(friend) fun accrue_points<T0>(arg0: &0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool, arg1: &mut SpoolAccount<T0>, arg2: &0x2::clock::Clock) {
        assert!(0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::is_points_up_to_date(arg0, arg2), 18);
        arg1.index = 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::index(arg0);
        arg1.points = arg1.points + 0x1::fixed_point32::multiply_u64(0x2::balance::value<T0>(&arg1.stakes), 0x1::fixed_point32::create_from_rational(0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::index(arg0) - arg1.index, 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::base_index_rate()));
    }

    public fun assert_key<T0>(arg0: &SpoolAccountKey, arg1: &SpoolAccount<T0>) {
        assert!(arg0.spool_account_id == 0x2::object::id<SpoolAccount<T0>>(arg1), 16);
    }

    public fun assert_pool_id<T0>(arg0: &0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool, arg1: &SpoolAccount<T0>) {
        assert!(arg1.spool_id == 0x2::object::id<0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool>(arg0), 19);
    }

    public fun points<T0>(arg0: &SpoolAccount<T0>) : u64 {
        arg0.points
    }

    public(friend) fun redeem_point<T0>(arg0: &mut SpoolAccount<T0>, arg1: u64) {
        arg0.points = arg0.points - arg1;
    }

    public fun spool_id<T0>(arg0: &SpoolAccount<T0>) : 0x2::object::ID {
        arg0.spool_id
    }

    public(friend) fun stake<T0>(arg0: &0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::Spool, arg1: &mut SpoolAccount<T0>, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg1.index == 0xccb0dd8254860c7e9515d18276226498d1f737cfdc8e48662e2e097d8ee83e84::spool::index(arg0), 17);
        0x2::balance::join<T0>(&mut arg1.stakes, arg2);
    }

    public fun stake_amount<T0>(arg0: &SpoolAccount<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.stakes)
    }

    public fun stake_type<T0>(arg0: &SpoolAccount<T0>) : 0x1::type_name::TypeName {
        arg0.stake_type
    }

    public(friend) fun unstake<T0>(arg0: &mut SpoolAccount<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.stakes, arg1)
    }

    // decompiled from Move bytecode v6
}

