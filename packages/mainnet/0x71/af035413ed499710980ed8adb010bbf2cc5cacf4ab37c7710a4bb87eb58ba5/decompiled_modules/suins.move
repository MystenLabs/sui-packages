module 0xd22b24490e0bae52676651b4f56660a5ff8022a2576e0089f79b3c88d44e08f0::suins {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SuiNS has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct SUINS has drop {
        dummy_field: bool,
    }

    struct ConfigKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct RegistryKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AppKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_config<T0: drop + store>(arg0: &AdminCap, arg1: &mut SuiNS, arg2: T0) {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<ConfigKey<T0>, T0>(&mut arg1.id, v0, arg2);
    }

    public fun add_registry<T0: store>(arg0: &AdminCap, arg1: &mut SuiNS, arg2: T0) {
        let v0 = RegistryKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<RegistryKey<T0>, T0>(&mut arg1.id, v0, arg2);
    }

    public fun app_add_balance<T0: drop>(arg0: T0, arg1: &mut SuiNS, arg2: 0x2::balance::Balance<0x2::sui::SUI>) {
        assert_app_is_authorized<T0>(arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, arg2);
    }

    public fun app_add_custom_balance<T0: drop, T1>(arg0: &mut SuiNS, arg1: T0, arg2: 0x2::balance::Balance<T1>) {
        assert_app_is_authorized<T0>(arg0);
        let v0 = BalanceKey<T1>{dummy_field: false};
        if (0x2::dynamic_field::exists_<BalanceKey<T1>>(&arg0.id, v0)) {
            0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0), arg2);
        } else {
            0x2::dynamic_field::add<BalanceKey<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, v0, arg2);
        };
    }

    public fun app_registry_mut<T0: drop, T1: store>(arg0: T0, arg1: &mut SuiNS) : &mut T1 {
        assert_app_is_authorized<T0>(arg1);
        pkg_registry_mut<T1>(arg1)
    }

    public fun assert_app_is_authorized<T0: drop>(arg0: &SuiNS) {
        assert!(is_app_authorized<T0>(arg0), 1);
    }

    public fun authorize_app<T0: drop>(arg0: &AdminCap, arg1: &mut SuiNS) {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<AppKey<T0>, bool>(&mut arg1.id, v0, true);
    }

    public fun deauthorize_app<T0: drop>(arg0: &AdminCap, arg1: &mut SuiNS) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<AppKey<T0>, bool>(&mut arg1.id, v0)
    }

    public fun get_config<T0: drop + store>(arg0: &SuiNS) : &T0 {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<ConfigKey<T0>, T0>(&arg0.id, v0)
    }

    fun init(arg0: SUINS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SUINS>(arg0, arg1);
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = SuiNS{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<SuiNS>(v1);
    }

    public fun is_app_authorized<T0: drop>(arg0: &SuiNS) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(&arg0.id, v0)
    }

    public(friend) fun pkg_registry_mut<T0: store>(arg0: &mut SuiNS) : &mut T0 {
        let v0 = RegistryKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<RegistryKey<T0>, T0>(&mut arg0.id, v0)
    }

    public fun registry<T0: store>(arg0: &SuiNS) : &T0 {
        let v0 = RegistryKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<RegistryKey<T0>, T0>(&arg0.id, v0)
    }

    public fun remove_config<T0: drop + store>(arg0: &AdminCap, arg1: &mut SuiNS) : T0 {
        let v0 = ConfigKey<T0>{dummy_field: false};
        0x2::dynamic_field::remove<ConfigKey<T0>, T0>(&mut arg1.id, v0)
    }

    public fun withdraw(arg0: &AdminCap, arg1: &mut SuiNS, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        assert!(v0 > 0, 0);
        0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, v0, arg2)
    }

    public fun withdraw_custom<T0>(arg0: &mut SuiNS, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = BalanceKey<T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<BalanceKey<T0>>(&arg0.id, v0), 2);
        0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0)), arg2)
    }

    // decompiled from Move bytecode v6
}

