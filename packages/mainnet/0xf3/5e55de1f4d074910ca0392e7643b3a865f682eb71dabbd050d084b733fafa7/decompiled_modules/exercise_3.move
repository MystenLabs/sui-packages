module 0x2aa6a7655dcbb26ca3cde46585e93c5f0bb29557e50537a34a3cba7c08cf29c6::exercise_3 {
    struct SuiMoverExercise3 has drop {
        dummy_field: bool,
    }

    struct OrangeStore has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct Treasury<phantom T0> has store {
        normal_price: u64,
        balance: 0x2::balance::Balance<T0>,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct DiscountVoucher {
        discount: u64,
    }

    struct BuyEvent<phantom T0> has copy, drop {
        price: u64,
        buyer: address,
        orange_id: 0x2::object::ID,
    }

    fun borrow_treasury<T0>(arg0: &OrangeStore) : &Treasury<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, Treasury<T0>>(&arg0.id, v0)) {
            err_treasury_type_not_exists();
        };
        0x2::dynamic_field::borrow<0x1::type_name::TypeName, Treasury<T0>>(&arg0.id, v0)
    }

    fun borrow_treasury_mut<T0>(arg0: &mut OrangeStore) : &mut Treasury<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, Treasury<T0>>(&arg0.id, v0)) {
            err_treasury_type_not_exists();
        };
        0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, Treasury<T0>>(&mut arg0.id, v0)
    }

    public fun buy() : DiscountVoucher {
        DiscountVoucher{discount: 0}
    }

    public fun buy_with_kapy(arg0: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::Kapy) : DiscountVoucher {
        DiscountVoucher{discount: (0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::level(arg0) as u64)}
    }

    public fun buy_with_orange(arg0: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange) : DiscountVoucher {
        DiscountVoucher{discount: (0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::kind(arg0) as u64)}
    }

    fun check_package_version(arg0: &OrangeStore) {
        assert!(arg0.version == 2, 0);
    }

    public fun create_treasury<T0>(arg0: &mut OrangeStore, arg1: &KeeperCap, arg2: u64) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, Treasury<T0>>(&arg0.id, v0)) {
            err_treasury_type_already_exists();
        };
        let v1 = Treasury<T0>{
            normal_price : arg2,
            balance      : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_field::add<0x1::type_name::TypeName, Treasury<T0>>(&mut arg0.id, v0, v1);
    }

    public fun direct_buy<T0>(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange {
        if (0x2::coin::value<T0>(&arg2) < normal_price<T0>(arg0)) {
            err_payment_not_enough();
        };
        put_into_treasury<T0>(arg0, arg2);
        let v0 = SuiMoverExercise3{dummy_field: false};
        0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::mint<SuiMoverExercise3>(arg1, orange_kind(), v0, arg3)
    }

    public fun direct_buy_with_kapy<T0>(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::Kapy, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange {
        if (0x2::coin::value<T0>(&arg3) < normal_price<T0>(arg0) * (10 - (0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::kapy::level(arg2) as u64)) / 10) {
            err_payment_not_enough();
        };
        put_into_treasury<T0>(arg0, arg3);
        let v0 = SuiMoverExercise3{dummy_field: false};
        0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::mint<SuiMoverExercise3>(arg1, orange_kind(), v0, arg4)
    }

    public fun direct_buy_with_orange<T0>(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange {
        if (0x2::coin::value<T0>(&arg3) < normal_price<T0>(arg0) * (10 - (0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::kind(arg2) as u64)) / 10) {
            err_payment_not_enough();
        };
        put_into_treasury<T0>(arg0, arg3);
        let v0 = SuiMoverExercise3{dummy_field: false};
        0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::mint<SuiMoverExercise3>(arg1, orange_kind(), v0, arg4)
    }

    public fun discount(arg0: &DiscountVoucher) : u64 {
        arg0.discount
    }

    fun err_payment_not_enough() {
        abort 0
    }

    fun err_treasury_type_already_exists() {
        abort 1
    }

    fun err_treasury_type_not_exists() {
        abort 2
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OrangeStore{
            id      : 0x2::object::new(arg0),
            version : 2,
        };
        0x2::transfer::share_object<OrangeStore>(v0);
        let v1 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun normal_price<T0>(arg0: &OrangeStore) : u64 {
        borrow_treasury<T0>(arg0).normal_price
    }

    public fun orange_kind() : u8 {
        3
    }

    public fun pay<T0>(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: DiscountVoucher, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange {
        abort 5
    }

    public fun pay_v2<T0>(arg0: &mut OrangeStore, arg1: &0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::config::Config, arg2: DiscountVoucher, arg3: 0x2::coin::Coin<T0>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange {
        check_package_version(arg0);
        let DiscountVoucher { discount: v0 } = arg2;
        let v1 = normal_price<T0>(arg0) * (10 - v0) / 10;
        let v2 = 0x2::coin::value<T0>(&arg3);
        if (v2 < v1) {
            err_payment_not_enough();
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg3, v2 / 10, arg5), arg4);
        put_into_treasury<T0>(arg0, arg3);
        let v3 = SuiMoverExercise3{dummy_field: false};
        let v4 = 0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::mint<SuiMoverExercise3>(arg1, orange_kind(), v3, arg5);
        let v5 = BuyEvent<T0>{
            price     : v1,
            buyer     : 0x2::tx_context::sender(arg5),
            orange_id : 0x2::object::id<0xcbfbdaaa8e8a70556c0cf1a038ddb3d9cc86cdaeb1add61abf7ebd2becac7b9d::orange::Orange>(&v4),
        };
        0x2::event::emit<BuyEvent<T0>>(v5);
        v4
    }

    fun put_into_treasury<T0>(arg0: &mut OrangeStore, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(&mut borrow_treasury_mut<T0>(arg0).balance, arg1);
    }

    public fun remove_treasury<T0>(arg0: &mut OrangeStore, arg1: &KeeperCap) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::dynamic_field::exists_with_type<0x1::type_name::TypeName, Treasury<T0>>(&arg0.id, v0)) {
            err_treasury_type_not_exists();
        };
        let Treasury {
            normal_price : _,
            balance      : v2,
        } = 0x2::dynamic_field::remove<0x1::type_name::TypeName, Treasury<T0>>(&mut arg0.id, v0);
        v2
    }

    public fun treasury_balance<T0>(arg0: &OrangeStore) : u64 {
        0x2::balance::value<T0>(&borrow_treasury<T0>(arg0).balance)
    }

    public fun update_normal_price<T0>(arg0: &mut OrangeStore, arg1: &KeeperCap, arg2: u64) {
        borrow_treasury_mut<T0>(arg0).normal_price = arg2;
    }

    public fun update_store_version(arg0: &mut OrangeStore) {
        arg0.version = arg0.version + 1;
    }

    // decompiled from Move bytecode v6
}

