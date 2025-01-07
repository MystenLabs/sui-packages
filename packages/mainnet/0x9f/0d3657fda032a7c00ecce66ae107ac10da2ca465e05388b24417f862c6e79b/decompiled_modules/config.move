module 0x9f0d3657fda032a7c00ecce66ae107ac10da2ca465e05388b24417f862c6e79b::config {
    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        admin_whitelist: 0x2::vec_set::VecSet<address>,
        reserve_claim_address: address,
    }

    struct GlobalReserve has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<0x2::sui::SUI>,
        min_reserve_taken: u64,
    }

    public entry fun add_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        0x2::vec_set::insert<address>(&mut arg0.admin_whitelist, arg1);
    }

    public fun add_reserve(arg0: &mut GlobalReserve, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg0.min_reserve_taken, 1);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.reserve, arg1);
    }

    public fun change_min_reserve_taken(arg0: &GlobalConfig, arg1: &mut GlobalReserve, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_reserve_claim_address(arg0, 0x2::tx_context::sender(arg3)), 2);
        arg1.min_reserve_taken = arg2;
    }

    public fun change_reserve_claim_address(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_reserve_claim_address(arg0, 0x2::tx_context::sender(arg2)), 2);
        arg0.reserve_claim_address = arg1;
    }

    public entry fun claim_reserve(arg0: &GlobalConfig, arg1: &mut GlobalReserve, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(is_reserve_claim_address(arg0, v0), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.reserve), arg2), v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::vec_set::empty<address>();
        let v1 = 0x2::tx_context::sender(arg0);
        0x2::vec_set::insert<address>(&mut v0, v1);
        let v2 = GlobalConfig{
            id                    : 0x2::object::new(arg0),
            admin_whitelist       : v0,
            reserve_claim_address : v1,
        };
        let v3 = GlobalReserve{
            id                : 0x2::object::new(arg0),
            reserve           : 0x2::balance::zero<0x2::sui::SUI>(),
            min_reserve_taken : 100000000,
        };
        0x2::transfer::share_object<GlobalReserve>(v3);
        0x2::transfer::share_object<GlobalConfig>(v2);
    }

    public fun is_admin(arg0: &GlobalConfig, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.admin_whitelist, &arg1)
    }

    public fun is_reserve_claim_address(arg0: &GlobalConfig, arg1: address) : bool {
        arg0.reserve_claim_address == arg1
    }

    public entry fun remove_admin(arg0: &mut GlobalConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_admin(arg0, 0x2::tx_context::sender(arg2)), 0);
        0x2::vec_set::remove<address>(&mut arg0.admin_whitelist, &arg1);
    }

    // decompiled from Move bytecode v6
}

