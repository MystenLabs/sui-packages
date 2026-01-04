module 0x380c440f0518a9c076e76312a3563b1eb645180ab1f86c1d2a7fbd5325c91080::presale {
    struct PresaleStore has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun buy_cloak(arg0: &mut PresaleStore, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>>(0x2::coin::mint<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>(&mut arg0.treasury_cap, v0 * 2000, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_pool(arg0: 0x2::coin::TreasuryCap<0x92c9bf9da640be4ff697ac0daf129914b89da20ae1d52d1eb4ba10c38080c56f::cloak_coin::CLOAK_COIN>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = PresaleStore{
            id           : 0x2::object::new(arg1),
            treasury_cap : arg0,
            sui_balance  : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PresaleStore>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun withdraw_sui(arg0: &AdminCap, arg1: &mut PresaleStore, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.sui_balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.sui_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

