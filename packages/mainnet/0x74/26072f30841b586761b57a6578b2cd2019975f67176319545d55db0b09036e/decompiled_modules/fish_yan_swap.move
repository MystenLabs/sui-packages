module 0x7426072f30841b586761b57a6578b2cd2019975f67176319545d55db0b09036e::fish_yan_swap {
    struct Pool has key {
        id: 0x2::object::UID,
        balance_a: 0x2::balance::Balance<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>,
        balance_b: 0x2::balance::Balance<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>,
    }

    public entry fun a_swap_b(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&arg1);
        assert!(v0 <= 0x2::balance::value<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(&arg0.balance_b), 0);
        0x2::balance::join<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&mut arg0.balance_a, 0x2::coin::into_balance<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>>(0x2::coin::take<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(&mut arg0.balance_b, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun add_liquidity(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>, arg2: 0x2::coin::Coin<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&arg1) > 0 && 0x2::coin::value<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(&arg2) > 0, 1);
        0x2::balance::join<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&mut arg0.balance_a, 0x2::coin::into_balance<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(arg1));
        0x2::balance::join<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(&mut arg0.balance_b, 0x2::coin::into_balance<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(arg2));
    }

    public entry fun b_swap_a(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(&arg1);
        assert!(v0 <= 0x2::balance::value<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&arg0.balance_a), 0);
        0x2::balance::join<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(&mut arg0.balance_b, 0x2::coin::into_balance<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>>(0x2::coin::take<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(&mut arg0.balance_a, v0, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool{
            id        : 0x2::object::new(arg0),
            balance_a : 0x2::balance::zero<0x46a5b42763675e5032e2e89bcb8ed0944d1e7b2e39138e784813178ec1a18e51::fish_yan_faucet::FISH_YAN_FAUCET>(),
            balance_b : 0x2::balance::zero<0x8b356127915437d3a1f2b80e3209775e79aeb08d4a0c5bcfba36187913912726::fish_yan_coin::FISH_YAN_COIN>(),
        };
        0x2::transfer::share_object<Pool>(v0);
    }

    // decompiled from Move bytecode v6
}

