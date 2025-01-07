module 0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::super_account {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::BalanceBag,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun value<T0>(arg0: &Treasury) : u64 {
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::value<T0>(&arg0.balance_bag)
    }

    public fun add_whitelist_address(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: address) {
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::add_whitelist_address(&mut arg0.id, arg2);
    }

    public fun allow_all(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::allow_all(&mut arg0.id);
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balance_bag;
        if (0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::contains<T0>(v0) == false) {
            0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::init_balance<T0>(v0);
        };
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::new(arg0),
        };
        let v1 = TreasuryCap{id: 0x2::object::new(arg0)};
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::allow_all(&mut v0.id);
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun reject_all(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::reject_all(&mut arg0.id);
    }

    public fun remove_whitelist_address(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: address) {
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::remove_whitelist_address(&mut arg0.id, arg2);
    }

    public fun switch_to_whitelist_mode(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::switch_to_whitelist_mode(&mut arg0.id);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::whitelist::is_address_allowed(&arg0.id, 0x2::tx_context::sender(arg2)) == true, 272);
        0x2::coin::from_balance<T0>(0xa27827e2f631a7c27b97bf716b2d337d9ef75d6aae4ed642c637ac5c95823eae::balance_bag::split<T0>(&mut arg0.balance_bag, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

