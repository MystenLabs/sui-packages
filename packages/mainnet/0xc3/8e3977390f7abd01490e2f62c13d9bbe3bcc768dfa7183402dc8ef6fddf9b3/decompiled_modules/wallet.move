module 0xb28fba02c9a3fcb8098a1fd5b9f1a9faaf5ccfe41d6f86847c07e6af873c34be::wallet {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PlayerBalanceKey<phantom T0> has copy, drop, store {
        player_address: address,
    }

    struct PlayerBalanceValue<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct HousePoolValue<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct HouseBank has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
    }

    struct DepositEvent<phantom T0> has copy, drop, store {
        player_address: address,
        amount: u64,
    }

    public fun add_player_balance<T0>(arg0: &AdminCap, arg1: &mut HouseBank, arg2: address, arg3: u64) {
        assert_valid_version(arg1);
        let v0 = borrow_player_balance_mut<T0>(arg1, arg2);
        v0.amount = v0.amount + arg3;
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut HouseBank, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_valid_version(arg0: &HouseBank) {
        let v0 = package_version();
        assert!(0x2::vec_set::contains<u64>(&arg0.version_set, &v0), 2);
    }

    fun borrow_house_pool_mut<T0>(arg0: &mut HouseBank) : &mut HousePoolValue<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    fun borrow_player_balance_mut<T0>(arg0: &mut HouseBank, arg1: address) : &mut PlayerBalanceValue<T0> {
        let v0 = PlayerBalanceKey<T0>{player_address: arg1};
        0x2::dynamic_object_field::borrow_mut<PlayerBalanceKey<T0>, PlayerBalanceValue<T0>>(&mut arg0.id, v0)
    }

    public fun burn_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun deposit<T0>(arg0: &mut HouseBank, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        if (!house_pool_exists<T0>(arg0)) {
            let v0 = HousePoolValue<T0>{
                id      : 0x2::object::new(arg3),
                balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v0);
        };
        if (!player_balance_exists<T0>(arg0, arg1)) {
            let v1 = PlayerBalanceKey<T0>{player_address: arg1};
            let v2 = PlayerBalanceValue<T0>{
                id     : 0x2::object::new(arg3),
                amount : 0,
            };
            0x2::dynamic_object_field::add<PlayerBalanceKey<T0>, PlayerBalanceValue<T0>>(&mut arg0.id, v1, v2);
        };
        let v3 = borrow_player_balance_mut<T0>(arg0, arg1);
        let v4 = 0x2::coin::value<T0>(&arg2);
        v3.amount = v3.amount + v4;
        0x2::balance::join<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg2));
        let v5 = DepositEvent<T0>{
            player_address : arg1,
            amount         : v4,
        };
        0x2::event::emit<DepositEvent<T0>>(v5);
    }

    public fun deposit_into_pool<T0>(arg0: &mut HouseBank, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        if (!house_pool_exists<T0>(arg0)) {
            let v0 = HousePoolValue<T0>{
                id      : 0x2::object::new(arg2),
                balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v0);
        };
        0x2::balance::join<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun house_pool_exists<T0>(arg0: &HouseBank) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = HouseBank{
            id          : 0x2::object::new(arg0),
            version_set : 0x2::vec_set::singleton<u64>(1),
        };
        0x2::transfer::share_object<HouseBank>(v1);
    }

    public fun mint_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    public fun package_version() : u64 {
        1
    }

    fun player_balance_exists<T0>(arg0: &HouseBank, arg1: address) : bool {
        let v0 = PlayerBalanceKey<T0>{player_address: arg1};
        0x2::dynamic_object_field::exists_<PlayerBalanceKey<T0>>(&arg0.id, v0)
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut HouseBank, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun sub_player_balance<T0>(arg0: &AdminCap, arg1: &mut HouseBank, arg2: address, arg3: u64) {
        assert_valid_version(arg1);
        let v0 = borrow_player_balance_mut<T0>(arg1, arg2);
        v0.amount = v0.amount - arg3;
    }

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut HouseBank, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg1);
        assert!(player_balance_exists<T0>(arg1, arg2), 1);
        let v0 = borrow_player_balance_mut<T0>(arg1, arg2);
        assert!(v0.amount >= arg3, 0);
        v0.amount = v0.amount - arg3;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut borrow_house_pool_mut<T0>(arg1).balance, arg3), arg4)
    }

    public fun withdraw_from_pool<T0>(arg0: &AdminCap, arg1: &mut HouseBank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_version(arg1);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut borrow_house_pool_mut<T0>(arg1).balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

