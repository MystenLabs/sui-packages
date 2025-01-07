module 0x77a54bb0a2a24fdfd20a32789b44253e8197c0753d925add53a8fd32e8e92d85::bot {
    struct KongBot<phantom T0> has key {
        id: 0x2::object::UID,
        bot_fee: u64,
        banana_fee: u64,
        balance: 0x2::balance::Balance<T0>,
        bananas_actives: 0x2::table::Table<address, Banana<T0>>,
    }

    struct BotOwnerCap has key {
        id: 0x2::object::UID,
    }

    struct Banana<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin: address,
        rewards: 0x2::balance::Balance<T0>,
    }

    public entry fun create_banana<T0>(arg0: &mut KongBot<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, Banana<T0>>(&arg0.bananas_actives, v0), 0);
        let v1 = Banana<0x2::sui::SUI>{
            id      : 0x2::object::new(arg1),
            admin   : v0,
            rewards : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Banana<0x2::sui::SUI>>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BotOwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<BotOwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = KongBot<0x2::sui::SUI>{
            id              : 0x2::object::new(arg0),
            bot_fee         : 1,
            banana_fee      : 30,
            balance         : 0x2::balance::zero<0x2::sui::SUI>(),
            bananas_actives : 0x2::table::new<address, Banana<0x2::sui::SUI>>(arg0),
        };
        0x2::transfer::share_object<KongBot<0x2::sui::SUI>>(v1);
    }

    public(friend) fun transfer_bananas<T0>(arg0: &mut KongBot<T0>, arg1: &mut Banana<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) : (u64, 0x2::coin::Coin<T0>) {
        let v0 = 0x2::coin::value<T0>(&arg2);
        let v1 = v0 * (1000 - arg0.bot_fee * 10) / 1000;
        let v2 = v0 - v1;
        let v3 = v2 * (1000 - arg0.banana_fee * 10) / 1000;
        let v4 = v2 - v3;
        let v5 = 0x2::coin::split<T0>(&mut arg2, v3, arg3);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v5), v3));
        let v6 = 0x2::coin::split<T0>(&mut arg2, v4, arg3);
        0x2::balance::join<T0>(&mut arg1.rewards, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut v6), v4));
        0x2::coin::destroy_zero<T0>(v6);
        0x2::coin::destroy_zero<T0>(v5);
        (v1, arg2)
    }

    public entry fun withdraw_bananas(arg0: &mut Banana<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.admin != v0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.rewards, 0x2::balance::value<0x2::sui::SUI>(&arg0.rewards), arg1), v0);
    }

    public fun withdraw_bananas_dev<T0>(arg0: &BotOwnerCap, arg1: &mut KongBot<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

