module 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::dca {
    struct DCACap has store, key {
        id: 0x2::object::UID,
    }

    struct DCAReg has key {
        id: 0x2::object::UID,
        treasury: 0x2::bag::Bag,
        fee_rate: u64,
        escrows_of: 0x2::table::Table<address, 0x2::vec_set::VecSet<0x2::object::ID>>,
    }

    struct Escrow<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        owner: address,
        extensions: 0x2::vec_set::VecSet<0x1::ascii::String>,
        orders: u64,
        frequency: u64,
        divided_amount: u64,
        last_claimed: u64,
        filled_orders: u64,
        balance_x: 0x2::balance::Balance<T0>,
        balance_y: 0x2::balance::Balance<T1>,
        decimals_x: u8,
        decimals_y: u8,
        price_enabled: bool,
        min_price: u128,
        max_price: u128,
        deposit_time: u64,
        end_time: u64,
        total_spent: u64,
        total_withdrawn_amount: u64,
    }

    struct SwapReceipt<phantom T0, phantom T1> {
        escrow_id: 0x2::object::ID,
        ts: u64,
        spent: u64,
        amount: u64,
    }

    public fun id<T0, T1>(arg0: &Escrow<T0, T1>) : 0x2::object::ID {
        0x2::object::id<Escrow<T0, T1>>(arg0)
    }

    public(friend) fun add_extension<T0, T1, T2>(arg0: &mut Escrow<T0, T1>, arg1: &T2) {
        0x2::vec_set::insert<0x1::ascii::String>(&mut arg0.extensions, 0x1::type_name::into_string(0x1::type_name::get<T2>()));
    }

    public(friend) fun add_filled_orders<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: u64) {
        arg0.filled_orders = arg0.filled_orders + arg1;
    }

    fun add_new_escrow_to_owner(arg0: &mut DCAReg, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.escrows_of, arg1)) {
            0x2::table::add<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.escrows_of, arg1, 0x2::vec_set::singleton<0x2::object::ID>(arg2));
        } else {
            0x2::vec_set::insert<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.escrows_of, arg1), arg2);
        };
    }

    public(friend) fun add_total_spent<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: u64) {
        arg0.total_spent = arg0.total_spent + arg1;
    }

    public(friend) fun add_total_withdrawn_amount<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: u64) {
        arg0.total_withdrawn_amount = arg0.total_withdrawn_amount + arg1;
    }

    public(friend) fun apply_fee<T0>(arg0: &mut DCAReg, arg1: &mut 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(arg1) * arg0.fee_rate / 10000 + 1;
        0x2::balance::join<T0>(treasury_mut<T0>(arg0), 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(arg1), v0));
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::charge_fee<T0>(v0);
    }

    public fun assert_not_expired<T0, T1>(arg0: &Escrow<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg1) <= arg0.end_time + 10 * 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::minute(), 111);
    }

    public fun assert_time_window<T0, T1>(arg0: &Escrow<T0, T1>, arg1: &0x2::clock::Clock) {
        assert!(0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg1) <= get_current_epoch<T0, T1>(arg0, arg1) * arg0.frequency + arg0.deposit_time + 10 * 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::minute(), 114);
    }

    public fun balance_x<T0, T1>(arg0: &Escrow<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.balance_x
    }

    public(friend) fun balance_x_mut<T0, T1>(arg0: &mut Escrow<T0, T1>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.balance_x
    }

    public fun balance_x_value<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance_x)
    }

    public fun balance_y<T0, T1>(arg0: &Escrow<T0, T1>) : &0x2::balance::Balance<T1> {
        &arg0.balance_y
    }

    public(friend) fun balance_y_mut<T0, T1>(arg0: &mut Escrow<T0, T1>) : &mut 0x2::balance::Balance<T1> {
        &mut arg0.balance_y
    }

    public fun balance_y_value<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance_y)
    }

    public fun borrow_uid<T0, T1>(arg0: &Escrow<T0, T1>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_uid_mut<T0, T1>(arg0: &mut Escrow<T0, T1>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun claim_fee<T0>(arg0: &mut DCAReg, arg1: &DCACap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(treasury_mut<T0>(arg0), arg2, arg3), 0x2::tx_context::sender(arg3));
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::claim_fee<T0>(0x2::tx_context::sender(arg3), arg2);
    }

    public fun close_escrow<T0, T1>(arg0: &mut DCAReg, arg1: Escrow<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(extensions_length<T0, T1>(&arg1) == 0, 107);
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 103);
        remove_escrow_from_owner<T0, T1>(arg0, &arg1);
        let Escrow {
            id                     : v0,
            owner                  : v1,
            extensions             : _,
            orders                 : _,
            frequency              : _,
            divided_amount         : _,
            last_claimed           : _,
            filled_orders          : _,
            balance_x              : v8,
            balance_y              : v9,
            decimals_x             : _,
            decimals_y             : _,
            price_enabled          : _,
            min_price              : _,
            max_price              : _,
            deposit_time           : _,
            end_time               : _,
            total_spent            : _,
            total_withdrawn_amount : _,
        } = arg1;
        let v19 = v9;
        let v20 = v8;
        let v21 = v0;
        0x2::object::delete(v21);
        let v22 = 0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut v20), arg2);
        let v23 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut v19), arg2);
        0x2::balance::destroy_zero<T0>(v20);
        0x2::balance::destroy_zero<T1>(v19);
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::order_closed<T0, T1>(0x2::object::uid_to_inner(&v21), v1, 0x2::coin::value<T0>(&v22), 0x2::coin::value<T1>(&v23));
        (v22, v23)
    }

    public fun decimals_x<T0, T1>(arg0: &Escrow<T0, T1>) : u8 {
        arg0.decimals_x
    }

    public fun decimals_y<T0, T1>(arg0: &Escrow<T0, T1>) : u8 {
        arg0.decimals_y
    }

    public fun deposit_time<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.deposit_time
    }

    public fun divided_amount<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.divided_amount
    }

    public fun end_time<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.end_time
    }

    public fun escrow_info<T0, T1>(arg0: &Escrow<T0, T1>) : (address, u64, u64, u64, u64, u64, u64, bool, u128, u128, u64, u64, u64, u64) {
        (arg0.owner, arg0.frequency, arg0.divided_amount, arg0.last_claimed, arg0.filled_orders, 0x2::balance::value<T0>(&arg0.balance_x), 0x2::balance::value<T1>(&arg0.balance_y), arg0.price_enabled, arg0.min_price, arg0.max_price, arg0.deposit_time, arg0.end_time, arg0.total_spent, arg0.total_withdrawn_amount)
    }

    public fun escrows_of(arg0: &DCAReg, arg1: address) : vector<0x2::object::ID> {
        if (!0x2::table::contains<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.escrows_of, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        0x2::vec_set::into_keys<0x2::object::ID>(*0x2::table::borrow<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&arg0.escrows_of, arg1))
    }

    public fun escrows_of_length(arg0: &DCAReg, arg1: address) : u64 {
        let v0 = escrows_of(arg0, arg1);
        0x1::vector::length<0x2::object::ID>(&v0)
    }

    public fun execute_order<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SwapReceipt<T0, T1>) {
        assert!(get_last_claimed_epoch<T0, T1>(arg0) <= get_current_epoch<T0, T1>(arg0, arg2), 104);
        assert!(arg0.filled_orders < arg0.orders, 110);
        assert!(balance_x_value<T0, T1>(arg0) > 0, 112);
        assert_time_window<T0, T1>(arg0, arg2);
        assert_not_expired<T0, T1>(arg0, arg2);
        roll_epoch<T0, T1>(arg0, arg2);
        let (v0, v1) = get_escrow_required_amount<T0, T1>(arg0, arg1, arg2);
        let v2 = SwapReceipt<T0, T1>{
            escrow_id : 0x2::object::id<Escrow<T0, T1>>(arg0),
            ts        : 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg2),
            spent     : v0,
            amount    : v1,
        };
        (0x2::coin::take<T0>(&mut arg0.balance_x, v0, arg3), v2)
    }

    public fun extensions<T0, T1>(arg0: &Escrow<T0, T1>) : vector<0x1::ascii::String> {
        *0x2::vec_set::keys<0x1::ascii::String>(&arg0.extensions)
    }

    public fun extensions_length<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        0x1::vector::length<0x1::ascii::String>(0x2::vec_set::keys<0x1::ascii::String>(&arg0.extensions))
    }

    public fun fee_balance<T0>(arg0: &DCAReg) : u64 {
        0x2::balance::value<T0>(treasury<T0>(arg0))
    }

    fun fill_order<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: &0x2::coin::Coin<T1>, arg2: u64) {
        arg0.filled_orders = arg0.filled_orders + 1;
        arg0.total_spent = arg0.total_spent + arg2;
        arg0.total_withdrawn_amount = arg0.total_withdrawn_amount + 0x2::coin::value<T1>(arg1);
    }

    public fun filled_orders<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.filled_orders
    }

    public fun frequency<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.frequency
    }

    public fun get_current_epoch<T0, T1>(arg0: &Escrow<T0, T1>, arg1: &0x2::clock::Clock) : u64 {
        get_epoch<T0, T1>(arg0, 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg1))
    }

    public fun get_epoch<T0, T1>(arg0: &Escrow<T0, T1>, arg1: u64) : u64 {
        (arg1 - arg0.deposit_time) / arg0.frequency
    }

    public fun get_escrow_required_amount<T0, T1>(arg0: &Escrow<T0, T1>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: &0x2::clock::Clock) : (u64, u64) {
        let v0 = if (arg0.price_enabled) {
            (((arg0.divided_amount as u128) * arg0.min_price * (0x2::math::pow(10, arg0.decimals_y) as u128) / (1000000000 as u128) * (0x2::math::pow(10, arg0.decimals_x) as u128)) as u64)
        } else {
            0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::mul_div(get_output_y<T0, T1>(arg0, arg1, arg0.divided_amount, arg2), 10000 - 50, 10000)
        };
        (arg0.divided_amount, v0)
    }

    public fun get_last_claimed_epoch<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        get_epoch<T0, T1>(arg0, arg0.last_claimed)
    }

    public fun get_output_x<T0, T1>(arg0: &Escrow<T0, T1>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg3);
        let (v2, v3) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T1>(arg1, arg3);
        (((arg2 as u128) * (v2 as u128) * (v1 as u128) * (1000000000 as u128) / (v0 as u128) * (v3 as u128) * (0x2::math::pow(10, arg0.decimals_x) as u128) / (1000000000 as u128) / (0x2::math::pow(10, arg0.decimals_y) as u128)) as u64)
    }

    public fun get_output_y<T0, T1>(arg0: &Escrow<T0, T1>, arg1: &0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::BucketOracle, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        let (v0, v1) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T0>(arg1, arg3);
        let (v2, v3) = 0xf145ee6d09aae034924f80672bc76db2415dfd1b1bed863ac289af9d94e2c4fc::bucket_oracle::get_price<T1>(arg1, arg3);
        (((arg2 as u128) * (v0 as u128) * (v3 as u128) * (1000000000 as u128) / (v2 as u128) * (v1 as u128) * (0x2::math::pow(10, arg0.decimals_y) as u128) / (1000000000 as u128) / (0x2::math::pow(10, arg0.decimals_x) as u128)) as u64)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DCACap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DCACap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = DCAReg{
            id         : 0x2::object::new(arg0),
            treasury   : 0x2::bag::new(arg0),
            fee_rate   : 10,
            escrows_of : 0x2::table::new<address, 0x2::vec_set::VecSet<0x2::object::ID>>(arg0),
        };
        0x2::transfer::share_object<DCAReg>(v1);
    }

    public fun last_claimed<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.last_claimed
    }

    public fun max_price<T0, T1>(arg0: &Escrow<T0, T1>) : u128 {
        arg0.max_price
    }

    public fun min_price<T0, T1>(arg0: &Escrow<T0, T1>) : u128 {
        arg0.min_price
    }

    public fun orders<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.orders
    }

    public fun owned_escrow_at(arg0: &DCAReg, arg1: address, arg2: u64) : 0x2::object::ID {
        let v0 = escrows_of(arg0, arg1);
        *0x1::vector::borrow<0x2::object::ID>(&v0, arg2)
    }

    public fun owner<T0, T1>(arg0: &Escrow<T0, T1>) : address {
        arg0.owner
    }

    public fun place_order<T0, T1>(arg0: &mut DCAReg, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::coin::CoinMetadata<T0>, arg4: &0x2::coin::CoinMetadata<T1>, arg5: u64, arg6: u64, arg7: bool, arg8: u128, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::coin::value<T0>(&arg2) != 0, 106);
        assert!(arg5 >= 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::hour(), 105);
        if (arg7) {
            assert!(arg8 != 0 && arg9 != 0, 102);
            assert!(arg8 <= arg9, 102);
        };
        let v0 = &mut arg2;
        let v1 = round_down_amount<T0>(v0, arg6, arg11);
        let v2 = 0x2::balance::zero<T0>();
        0x2::coin::put<T0>(&mut v2, arg2);
        let v3 = 0x2::object::new(arg11);
        add_new_escrow_to_owner(arg0, arg1, 0x2::object::uid_to_inner(&v3));
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.treasury, 0x1::type_name::get<T0>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.treasury, 0x1::type_name::get<T0>(), 0x2::balance::zero<T0>());
        };
        if (!0x2::bag::contains<0x1::type_name::TypeName>(&arg0.treasury, 0x1::type_name::get<T1>())) {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.treasury, 0x1::type_name::get<T1>(), 0x2::balance::zero<T1>());
        };
        let v4 = if (arg7) {
            arg8
        } else {
            0
        };
        let v5 = if (arg7) {
            arg9
        } else {
            0
        };
        let v6 = Escrow<T0, T1>{
            id                     : v3,
            owner                  : arg1,
            extensions             : 0x2::vec_set::empty<0x1::ascii::String>(),
            orders                 : arg6,
            frequency              : arg5,
            divided_amount         : v1,
            last_claimed           : 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg10),
            filled_orders          : 0,
            balance_x              : v2,
            balance_y              : 0x2::balance::zero<T1>(),
            decimals_x             : 0x2::coin::get_decimals<T0>(arg3),
            decimals_y             : 0x2::coin::get_decimals<T1>(arg4),
            price_enabled          : arg7,
            min_price              : v4,
            max_price              : v5,
            deposit_time           : 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg10),
            end_time               : 0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::utils::get_sec(arg10) + arg6 * arg5,
            total_spent            : 0,
            total_withdrawn_amount : 0,
        };
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::order_created<T0, T1>(0x2::object::id<Escrow<T0, T1>>(&v6), arg1, 0x2::coin::value<T0>(&arg2), arg6, arg5, arg8, arg9);
        0x2::transfer::share_object<Escrow<T0, T1>>(v6);
        0x2::object::id<Escrow<T0, T1>>(&v6)
    }

    public fun price_enabled<T0, T1>(arg0: &Escrow<T0, T1>) : bool {
        arg0.price_enabled
    }

    fun remove_escrow_from_owner<T0, T1>(arg0: &mut DCAReg, arg1: &Escrow<T0, T1>) {
        let v0 = 0x2::object::id<Escrow<T0, T1>>(arg1);
        0x2::vec_set::remove<0x2::object::ID>(0x2::table::borrow_mut<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.escrows_of, arg1.owner), &v0);
        if (escrows_of_length(arg0, arg1.owner) == 0) {
            0x2::table::remove<address, 0x2::vec_set::VecSet<0x2::object::ID>>(&mut arg0.escrows_of, arg1.owner);
        };
    }

    public(friend) fun remove_extension<T0, T1, T2>(arg0: &mut Escrow<T0, T1>, arg1: &T2) {
        let v0 = 0x1::type_name::get<T2>();
        0x2::vec_set::remove<0x1::ascii::String>(&mut arg0.extensions, 0x1::type_name::borrow_string(&v0));
    }

    public(friend) fun remove_total_spent<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: u64) {
        arg0.total_spent = arg0.total_spent - arg1;
    }

    public fun repay_order<T0, T1>(arg0: &mut DCAReg, arg1: &mut Escrow<T0, T1>, arg2: SwapReceipt<T0, T1>, arg3: 0x2::coin::Coin<T1>) {
        assert!(0x2::object::id<Escrow<T0, T1>>(arg1) == arg2.escrow_id, 108);
        assert!(0x2::coin::value<T1>(&arg3) >= arg2.amount, 101);
        if (arg1.price_enabled) {
            assert!(0x2::coin::value<T1>(&arg3) <= (((arg1.divided_amount as u128) * arg1.max_price / (1000000000 as u128) * (0x2::math::pow(10, arg1.decimals_y) as u128) / (0x2::math::pow(10, arg1.decimals_x) as u128)) as u64), 109);
        };
        let SwapReceipt {
            escrow_id : _,
            ts        : v1,
            spent     : v2,
            amount    : v3,
        } = arg2;
        fill_order<T0, T1>(arg1, &arg3, v2);
        let v4 = &mut arg3;
        apply_fee<T1>(arg0, v4);
        0x2::coin::put<T1>(&mut arg1.balance_y, arg3);
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::order_executed<T0, T1>(0x2::object::id<Escrow<T0, T1>>(arg1), arg1.owner, v1, v2, v3, balance_x_value<T0, T1>(arg1), balance_y_value<T0, T1>(arg1), arg1.filled_orders);
    }

    public(friend) fun roll_epoch<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: &0x2::clock::Clock) {
        arg0.last_claimed = (get_current_epoch<T0, T1>(arg0, arg1) + 1) * arg0.frequency + arg0.deposit_time;
    }

    fun round_down_amount<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = v0 / arg1 * arg1;
        if (v0 != v1) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0 - v1, arg2), 0x2::tx_context::sender(arg2));
        };
        v1 / arg1
    }

    public fun total_spent<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.total_spent
    }

    public fun total_withdrawn_amount<T0, T1>(arg0: &Escrow<T0, T1>) : u64 {
        arg0.total_withdrawn_amount
    }

    public fun treasury<T0>(arg0: &DCAReg) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.treasury, 0x1::type_name::get<T0>())
    }

    fun treasury_mut<T0>(arg0: &mut DCAReg) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.treasury, 0x1::type_name::get<T0>())
    }

    public entry fun update_fee_rate(arg0: &mut DCAReg, arg1: &DCACap, arg2: u64) {
        assert!(arg2 <= 20, 113);
        arg0.fee_rate = arg2;
    }

    public entry fun update_price<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: bool, arg2: u128, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 103);
        if (!arg1) {
            arg2 = 0;
            arg3 = 0;
        };
        arg0.min_price = arg2;
        arg0.max_price = arg3;
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::price_updated<T0, T1>(0x2::object::id<Escrow<T0, T1>>(arg0), arg0.owner, arg0.price_enabled, arg0.min_price, arg0.max_price);
    }

    public fun withdraw<T0, T1>(arg0: &mut Escrow<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 103);
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::withdraw_all<T1>(&mut arg0.balance_y), arg1);
        0x739f40e2905aa38f1aa8c89ab87f37f45b7d574d628901a5b16d60d4e068296e::event::order_withdrew<T0, T1>(0x2::object::id<Escrow<T0, T1>>(arg0), arg0.owner, 0x2::coin::value<T1>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

