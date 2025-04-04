module 0xb3fedcdf9251f215788c8e6e15806fa4d07449b4bf4614bba9930204b43198da::sports {
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

    struct SportsBank has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
        max_risk: u64,
        signer_address: address,
    }

    struct Sportsbook has copy, drop, store {
        dummy_field: bool,
    }

    struct DepositEvent<phantom T0> has copy, drop, store {
        player_address: address,
        amount: u64,
    }

    public fun add_manager(arg0: &mut SportsBank, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_player_balance<T0>(arg0: &mut SportsBank, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg3);
        let v0 = borrow_player_balance_mut<T0>(arg0, arg1);
        v0.amount = v0.amount + arg2;
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut SportsBank, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    fun assert_gas_fee(arg0: &0x2::coin::Coin<0x2::sui::SUI>) {
        if (0x2::coin::value<0x2::sui::SUI>(arg0) < 3000000) {
            err_insufficient_gas_fee();
        };
    }

    fun assert_sender_is_manager(arg0: &SportsBank, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(managers(arg0), &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version(arg0: &SportsBank) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(versions(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    fun borrow_house_pool_mut<T0>(arg0: &mut SportsBank) : &mut HousePoolValue<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    fun borrow_player_balance_mut<T0>(arg0: &mut SportsBank, arg1: address) : &mut PlayerBalanceValue<T0> {
        let v0 = PlayerBalanceKey<T0>{player_address: arg1};
        0x2::dynamic_object_field::borrow_mut<PlayerBalanceKey<T0>, PlayerBalanceValue<T0>>(&mut arg0.id, v0)
    }

    public fun deposit<T0>(arg0: &mut SportsBank, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        let v0 = arg0.signer_address;
        if (!house_pool_exists<T0>(arg0)) {
            let v1 = HousePoolValue<T0>{
                id      : 0x2::object::new(arg4),
                balance : 0x2::balance::zero<T0>(),
            };
            0x2::dynamic_object_field::add<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v1);
        };
        if (!player_balance_exists<T0>(arg0, arg1)) {
            let v2 = PlayerBalanceKey<T0>{player_address: arg1};
            let v3 = PlayerBalanceValue<T0>{
                id     : 0x2::object::new(arg4),
                amount : 0,
            };
            0x2::dynamic_object_field::add<PlayerBalanceKey<T0>, PlayerBalanceValue<T0>>(&mut arg0.id, v2, v3);
        };
        let v4 = borrow_player_balance_mut<T0>(arg0, arg1);
        assert_gas_fee(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v0);
        let v5 = 0x2::coin::value<T0>(&arg2);
        v4.amount = v4.amount + v5;
        0x2::balance::join<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg2));
        let v6 = DepositEvent<T0>{
            player_address : arg1,
            amount         : v5,
        };
        0x2::event::emit<DepositEvent<T0>>(v6);
    }

    fun err_insufficient_gas_fee() {
        abort 3
    }

    fun err_invalid_package_version() {
        abort 1
    }

    fun err_loss_amount_exceeds_balance() {
        abort 5
    }

    fun err_sender_is_not_manager() {
        abort 2
    }

    fun err_user_balance_does_not_exist() {
        abort 4
    }

    fun house_pool_exists<T0>(arg0: &SportsBank) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SportsBank{
            id             : 0x2::object::new(arg0),
            version_set    : 0x2::vec_set::singleton<u64>(1),
            managers       : 0x2::vec_set::empty<address>(),
            max_risk       : 0,
            signer_address : @0x56a9032cf70bbff65f6ba100d6ded84230e1089c79a23f9ee19fe08f704ec6ee,
        };
        0x2::transfer::share_object<SportsBank>(v1);
    }

    public fun managers(arg0: &SportsBank) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun package_version() : u64 {
        1
    }

    fun player_balance_exists<T0>(arg0: &SportsBank, arg1: address) : bool {
        let v0 = PlayerBalanceKey<T0>{player_address: arg1};
        0x2::dynamic_object_field::exists_<PlayerBalanceKey<T0>>(&arg0.id, v0)
    }

    public fun remove_manager(arg0: &mut SportsBank, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut SportsBank, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun sub_player_balance<T0>(arg0: &mut SportsBank, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg3);
        let v0 = borrow_player_balance_mut<T0>(arg0, arg1);
        v0.amount = v0.amount - arg2;
    }

    public fun transfer_player_loss_to_unihouse<T0>(arg0: &mut SportsBank, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        if (!player_balance_exists<T0>(arg0, arg2)) {
            err_user_balance_does_not_exist();
        };
        let v0 = borrow_player_balance_mut<T0>(arg0, arg2);
        if (v0.amount < arg3) {
            err_loss_amount_exceeds_balance();
        };
        v0.amount = v0.amount - arg3;
        let v1 = Sportsbook{dummy_field: false};
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::join_with_fee<T0, Sportsbook>(arg1, v1, 0x2::balance::split<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, arg3));
    }

    public fun versions(arg0: &SportsBank) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    public fun withdraw<T0>(arg0: &mut SportsBank, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        if (!player_balance_exists<T0>(arg0, arg2)) {
            err_user_balance_does_not_exist();
        };
        let v0 = borrow_player_balance_mut<T0>(arg0, arg2);
        let v1 = 0x2::balance::zero<T0>();
        if (v0.amount < arg3) {
            let v2 = Sportsbook{dummy_field: false};
            0x2::balance::join<T0>(&mut v1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::split_with_reimbursement<T0, Sportsbook>(arg1, v2, arg3 - v0.amount));
            v0.amount = 0;
        } else {
            v0.amount = v0.amount - arg3;
        };
        0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, arg3));
        0x2::coin::from_balance<T0>(v1, arg4)
    }

    public fun withdraw_from_pool<T0>(arg0: &mut SportsBank, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg2);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

