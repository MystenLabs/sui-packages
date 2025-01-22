module 0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        reward_balances: 0x2::bag::Bag,
        staked_balance: 0x2::balance::Balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>,
    }

    fun assert_coin_type_exist<T0>(arg0: &0x2::bag::Bag, arg1: 0x1::type_name::TypeName) {
        assert!(0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, arg1), 0);
    }

    public(friend) fun deposit_reward<T0>(arg0: &mut Vault, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains_with_type<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reward_balances, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_balances, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_balances, v0, arg1);
        };
    }

    public fun deposit_reward_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        deposit_reward<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public(friend) fun deposit_staked(arg0: &mut Vault, arg1: 0x2::balance::Balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>) {
        0x2::balance::join<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&mut arg0.staked_balance, arg1);
    }

    public entry fun entry_deposit_reward_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>) {
        deposit_reward<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun entry_withdraw_reward_coin<T0>(arg0: &mut Vault, arg1: &0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::config::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_reward_coin<T0>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun get_vault_reward_balance<T0>(arg0: &Vault) : u64 {
        let v0 = 0x1::type_name::get<T0>();
        assert_coin_type_exist<T0>(&arg0.reward_balances, v0);
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&arg0.reward_balances, v0))
    }

    public fun get_vault_staked_balance(arg0: &Vault) : u64 {
        0x2::balance::value<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&arg0.staked_balance)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id              : 0x2::object::new(arg0),
            reward_balances : 0x2::bag::new(arg0),
            staked_balance  : 0x2::balance::zero<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(),
        };
        0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::events::emit_init_vault(0x2::object::id<Vault>(&v0));
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public(friend) fun withdraw_reward<T0>(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert_coin_type_exist<T0>(&arg0.reward_balances, v0);
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.reward_balances, v0), arg1)
    }

    public fun withdraw_reward_coin<T0>(arg0: &mut Vault, arg1: &0xeb68669c1c6be6f50606b1525b736d83eec04a4ea2380642fc0ff12ca82276e9::config::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(withdraw_reward<T0>(arg0, arg2), arg3)
    }

    public(friend) fun withdraw_staked(arg0: &mut Vault, arg1: u64) : 0x2::balance::Balance<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB> {
        0x2::balance::split<0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::BLUB::BLUB>(&mut arg0.staked_balance, arg1)
    }

    // decompiled from Move bytecode v6
}

