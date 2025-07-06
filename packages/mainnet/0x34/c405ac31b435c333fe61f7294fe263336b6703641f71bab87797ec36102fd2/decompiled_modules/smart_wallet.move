module 0x483aa03ab4a959872b3d19e3261cea0b44137c92a7378cf164b2efc6c6583c2c::smart_wallet {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct HousePoolValue<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    struct SmartWallet has key {
        id: 0x2::object::UID,
        version_set: 0x2::vec_set::VecSet<u64>,
        managers: 0x2::vec_set::VecSet<address>,
        signer_address: address,
    }

    struct DepositEvent<phantom T0> has copy, drop, store {
        player_address: address,
        amount: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop, store {
        receiver: address,
        amount: u64,
        idempotency_key: 0x1::string::String,
    }

    public fun add_manager(arg0: &mut SmartWallet, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg0.managers, arg2);
    }

    public fun add_version(arg0: &AdminCap, arg1: &mut SmartWallet, arg2: u64) {
        0x2::vec_set::insert<u64>(&mut arg1.version_set, arg2);
    }

    public fun admin_withdraw_all_funds<T0>(arg0: &mut SmartWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg1);
        let v0 = borrow_house_pool_mut<T0>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0.balance, 0x2::balance::value<T0>(&v0.balance)), arg1), 0x2::tx_context::sender(arg1));
    }

    fun assert_gas_fee(arg0: &0x2::coin::Coin<0x2::sui::SUI>) {
        if (0x2::coin::value<0x2::sui::SUI>(arg0) < 3000000) {
            err_insufficient_gas_fee();
        };
    }

    fun assert_sender_is_manager(arg0: &SmartWallet, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!0x2::vec_set::contains<address>(managers(arg0), &v0)) {
            err_sender_is_not_manager();
        };
    }

    fun assert_valid_package_version(arg0: &SmartWallet) {
        let v0 = package_version();
        if (!0x2::vec_set::contains<u64>(versions(arg0), &v0)) {
            err_invalid_package_version();
        };
    }

    fun borrow_house_pool_mut<T0>(arg0: &mut SmartWallet) : &mut HousePoolValue<T0> {
        0x2::dynamic_object_field::borrow_mut<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>())
    }

    public fun create_house_pool<T0>(arg0: &mut SmartWallet, arg1: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg1);
        let v0 = HousePoolValue<T0>{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::dynamic_object_field::add<0x1::type_name::TypeName, HousePoolValue<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), v0);
    }

    public fun deposit<T0>(arg0: &mut SmartWallet, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_valid_package_version(arg0);
        if (!house_pool_exists<T0>(arg0)) {
            err_invalid_coin_type();
        };
        assert_gas_fee(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg0.signer_address);
        0x2::balance::join<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, 0x2::coin::into_balance<T0>(arg2));
        let v0 = DepositEvent<T0>{
            player_address : arg1,
            amount         : 0x2::coin::value<T0>(&arg2),
        };
        0x2::event::emit<DepositEvent<T0>>(v0);
    }

    fun err_insufficient_gas_fee() {
        abort 3
    }

    fun err_invalid_coin_type() {
        abort 4
    }

    fun err_invalid_package_version() {
        abort 1
    }

    fun err_sender_is_not_manager() {
        abort 2
    }

    fun house_pool_exists<T0>(arg0: &SmartWallet) : bool {
        0x2::dynamic_object_field::exists_<0x1::type_name::TypeName>(&arg0.id, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = SmartWallet{
            id             : 0x2::object::new(arg0),
            version_set    : 0x2::vec_set::singleton<u64>(1),
            managers       : 0x2::vec_set::empty<address>(),
            signer_address : @0x43084c0b57d82a09f9402242ae3014e39dbe466ea8a003aa1b93ba3c43da6d7d,
        };
        0x2::transfer::share_object<SmartWallet>(v1);
    }

    public fun managers(arg0: &SmartWallet) : &0x2::vec_set::VecSet<address> {
        &arg0.managers
    }

    public fun package_version() : u64 {
        1
    }

    public fun remove_manager(arg0: &mut SmartWallet, arg1: &AdminCap, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg0.managers, &arg2);
    }

    public fun remove_version(arg0: &AdminCap, arg1: &mut SmartWallet, arg2: u64) {
        0x2::vec_set::remove<u64>(&mut arg1.version_set, &arg2);
    }

    public fun versions(arg0: &SmartWallet) : &0x2::vec_set::VecSet<u64> {
        &arg0.version_set
    }

    public fun withdraw<T0>(arg0: &mut SmartWallet, arg1: address, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_valid_package_version(arg0);
        assert_sender_is_manager(arg0, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut borrow_house_pool_mut<T0>(arg0).balance, arg3), arg4), arg1);
        let v0 = WithdrawEvent<T0>{
            receiver        : arg1,
            amount          : arg3,
            idempotency_key : arg2,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

