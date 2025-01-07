module 0x302c31c249ba3c812342f5f72136e5708b390b739ff93d7ad3bf7814c2c3202b::zhbbll_swap {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Bank has key {
        id: 0x2::object::UID,
        zhbbll_coin: 0x2::balance::Balance<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>,
        zhbbll_faucet_coin: 0x2::balance::Balance<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>,
    }

    public entry fun deposit_zhbbll_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(&mut arg1.zhbbll_coin, 0x2::coin::into_balance<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(arg2));
    }

    public entry fun deposit_zhbbll_faucet_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: 0x2::coin::Coin<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg1.zhbbll_faucet_coin, 0x2::coin::into_balance<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Bank{
            id                 : 0x2::object::new(arg0),
            zhbbll_coin        : 0x2::balance::zero<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(),
            zhbbll_faucet_coin : 0x2::balance::zero<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(),
        };
        0x2::transfer::share_object<Bank>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun swap_zhbbll_coin_to_zhbbll_faucet_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(&mut arg0.zhbbll_coin, 0x2::coin::into_balance<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>>(0x2::coin::from_balance<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(0x2::balance::split<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg0.zhbbll_faucet_coin, 0x2::coin::value<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(&arg1) * 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun swap_zhbbll_faucet_coin_to_zhbbll_coin(arg0: &mut Bank, arg1: 0x2::coin::Coin<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg0.zhbbll_faucet_coin, 0x2::coin::into_balance<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>>(0x2::coin::from_balance<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(0x2::balance::split<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(&mut arg0.zhbbll_coin, 0x2::coin::value<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&arg1) / 2), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_zhbbll_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>>(0x2::coin::from_balance<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(0x2::balance::split<0x7e15b359c7fb72be1f6467c9c3db1f216b6e5b72eb7b4a259ff896ad4fcf508f::zhbbll_coin::ZHBBLL_COIN>(&mut arg1.zhbbll_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_zhbbll_faucet_coin(arg0: &AdminCap, arg1: &mut Bank, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>>(0x2::coin::from_balance<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(0x2::balance::split<0xe7366828123241f6ec15bbd77b03a02bbe308ab9d95781c6bb82d3f66ea5e444::zhbbll_faucet_coin::ZHBBLL_FAUCET_COIN>(&mut arg1.zhbbll_faucet_coin, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

