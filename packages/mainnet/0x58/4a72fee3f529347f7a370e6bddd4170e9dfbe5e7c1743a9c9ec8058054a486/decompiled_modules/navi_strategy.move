module 0x584a72fee3f529347f7a370e6bddd4170e9dfbe5e7c1743a9c9ec8058054a486::navi_strategy {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Strategy has key {
        id: 0x2::object::UID,
        version: u64,
        navi_cap: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
        borrowed_ratio: u64,
        vault_access: 0x1::option::Option<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>,
        underlying_nominal_value_usdt: u64,
        st_sbuck_reserve: 0x2::balance::Balance<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>,
        collected_profits: 0x2::bag::Bag,
    }

    public entry fun new(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Strategy{
            id                            : 0x2::object::new(arg1),
            version                       : 1,
            navi_cap                      : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg1),
            borrowed_ratio                : 6800,
            vault_access                  : 0x1::option::none<0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::vault::VaultAccess>(),
            underlying_nominal_value_usdt : 0,
            st_sbuck_reserve              : 0x2::balance::zero<0xd01d27939064d79e4ae1179cd11cfeeff23943f32b1a842ea1a1e15a0045d77d::st_sbuck::ST_SBUCK>(),
            collected_profits             : 0x2::bag::new(arg1),
        };
        0x2::transfer::share_object<Strategy>(v0);
    }

    public fun collected_profit<T0>(arg0: &Strategy) : &0x2::balance::Balance<T0> {
        0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.collected_profits, 0x1::type_name::get<T0>())
    }

    public fun collected_profit_mut<T0>(arg0: &mut Strategy) : &mut 0x2::balance::Balance<T0> {
        0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.collected_profits, 0x1::type_name::get<T0>())
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

