module 0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::super_account {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance_bag: 0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::balance_bag::BalanceBag,
    }

    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_whitelist_address(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: address) {
        0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::whitelist::add_whitelist_address(&mut arg0.id, arg2);
    }

    public fun allow_all(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::whitelist::allow_all(&mut arg0.id);
    }

    public fun deposit<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) {
        let v0 = &mut arg0.balance_bag;
        if (0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::balance_bag::contains<T0>(v0) == false) {
            0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::balance_bag::init_balance<T0>(v0);
        };
        0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::balance_bag::join<T0>(&mut arg0.balance_bag, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id          : 0x2::object::new(arg0),
            balance_bag : 0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::balance_bag::new(arg0),
        };
        let v1 = TreasuryCap{id: 0x2::object::new(arg0)};
        0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::whitelist::allow_all(&mut v0.id);
        0x2::transfer::share_object<Treasury>(v0);
        0x2::transfer::transfer<TreasuryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun reject_all(arg0: &mut Treasury, arg1: &TreasuryCap) {
        0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::whitelist::reject_all(&mut arg0.id);
    }

    public fun remove_whitelist_address(arg0: &mut Treasury, arg1: &TreasuryCap, arg2: address) {
        0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::whitelist::remove_whitelist_address(&mut arg0.id, arg2);
    }

    public fun withdraw<T0>(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::whitelist::is_address_allowed(&arg0.id, 0x2::tx_context::sender(arg2)) == true, 272);
        0x2::coin::from_balance<T0>(0x85dedadf5464d79116a11adff1bcca2afeb52c9623d407f6076233dac518c899::balance_bag::split<T0>(&mut arg0.balance_bag, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

