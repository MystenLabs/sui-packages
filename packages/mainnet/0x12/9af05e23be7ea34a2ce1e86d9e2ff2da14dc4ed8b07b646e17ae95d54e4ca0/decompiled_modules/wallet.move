module 0x129af05e23be7ea34a2ce1e86d9e2ff2da14dc4ed8b07b646e17ae95d54e4ca0::wallet {
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

    fun borrow_player_balance_mut<T0>(arg0: &mut HouseBank, arg1: address) : &mut PlayerBalanceValue<T0> {
        let v0 = PlayerBalanceKey<T0>{player_address: arg1};
        0x2::dynamic_object_field::borrow_mut<PlayerBalanceKey<T0>, PlayerBalanceValue<T0>>(&mut arg0.id, v0)
    }

    public fun deposit<T0>(arg0: &mut HouseBank, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_version(arg0);
        if (!player_balance_exists<T0>(arg0, arg1)) {
            let v0 = PlayerBalanceKey<T0>{player_address: arg1};
            let v1 = PlayerBalanceValue<T0>{
                id     : 0x2::object::new(arg3),
                amount : 0,
            };
            0x2::dynamic_object_field::add<PlayerBalanceKey<T0>, PlayerBalanceValue<T0>>(&mut arg0.id, v0, v1);
        };
        let v2 = borrow_player_balance_mut<T0>(arg0, arg1);
        v2.amount = v2.amount + arg2;
        let v3 = DepositEvent<T0>{
            player_address : arg1,
            amount         : arg2,
        };
        0x2::event::emit<DepositEvent<T0>>(v3);
    }

    public fun get_player_balance<T0>(arg0: &mut HouseBank, arg1: address) : u64 {
        borrow_player_balance_mut<T0>(arg0, arg1).amount
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

    public fun withdraw<T0>(arg0: &AdminCap, arg1: &mut HouseBank, arg2: address, arg3: u64) {
        assert_valid_version(arg1);
        assert!(player_balance_exists<T0>(arg1, arg2), 1);
        let v0 = borrow_player_balance_mut<T0>(arg1, arg2);
        assert!(v0.amount >= arg3, 0);
        v0.amount = v0.amount - arg3;
    }

    // decompiled from Move bytecode v6
}

