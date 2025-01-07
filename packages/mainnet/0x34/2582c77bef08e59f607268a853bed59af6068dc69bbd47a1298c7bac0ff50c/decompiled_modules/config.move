module 0x342582c77bef08e59f607268a853bed59af6068dc69bbd47a1298c7bac0ff50c::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        admin_whitelist: 0x2::vec_set::VecSet<address>,
    }

    struct GlobalReserve has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun add_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!is_admin(arg0, 0x2::tx_context::sender(arg2))) {
            return
        };
        0x2::vec_set::insert<address>(&mut arg0.admin_whitelist, arg1);
    }

    public fun add_reserve(arg0: &mut GlobalReserve, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.reserve, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        0x2::vec_set::insert<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id              : 0x2::object::new(arg0),
            admin_whitelist : v0,
        };
        let v2 = GlobalReserve{
            id      : 0x2::object::new(arg0),
            reserve : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<GlobalReserve>(v2);
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_admin(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admin_whitelist, &arg1)
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (!is_admin(arg0, 0x2::tx_context::sender(arg2))) {
            return
        };
        0x2::vec_set::remove<address>(&mut arg0.admin_whitelist, &arg1);
    }

    // decompiled from Move bytecode v6
}

