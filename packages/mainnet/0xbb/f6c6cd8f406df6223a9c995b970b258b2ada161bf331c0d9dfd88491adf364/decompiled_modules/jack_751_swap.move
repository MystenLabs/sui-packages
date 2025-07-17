module 0xbbf6c6cd8f406df6223a9c995b970b258b2ada161bf331c0d9dfd88491adf364::jack_751_swap {
    struct SwapPool has key {
        id: 0x2::object::UID,
        jack_751_balance: 0x2::balance::Balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>,
        faucet_coin_balance: 0x2::balance::Balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>,
        swap_ratio: u64,
    }

    struct SwapEvent has copy, drop {
        user: address,
        jack_751_in: u64,
        faucet_coin_in: u64,
        jack_751_out: u64,
        faucet_coin_out: u64,
    }

    struct LiquidityEvent has copy, drop {
        user: address,
        jack_751_amount: u64,
        faucet_coin_amount: u64,
        action: vector<u8>,
    }

    public entry fun add_liquidity(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>, arg2: 0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&arg1);
        let v1 = 0x2::coin::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg2);
        assert!(v0 > 0 && v1 > 0, 2);
        0x2::balance::join<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&mut arg0.jack_751_balance, 0x2::coin::into_balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(arg1));
        0x2::balance::join<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&mut arg0.faucet_coin_balance, 0x2::coin::into_balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(arg2));
        let v2 = LiquidityEvent{
            user               : 0x2::tx_context::sender(arg3),
            jack_751_amount    : v0,
            faucet_coin_amount : v1,
            action             : b"add",
        };
        0x2::event::emit<LiquidityEvent>(v2);
    }

    public fun calculate_swap_output(arg0: &SwapPool, arg1: u64, arg2: bool) : u64 {
        if (arg2) {
            arg1 * arg0.swap_ratio / 1000
        } else {
            arg1 * 1000 / arg0.swap_ratio
        }
    }

    public fun get_pool_info(arg0: &SwapPool) : (u64, u64, u64) {
        (0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&arg0.jack_751_balance), 0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg0.faucet_coin_balance), arg0.swap_ratio)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapPool{
            id                  : 0x2::object::new(arg0),
            jack_751_balance    : 0x2::balance::zero<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(),
            faucet_coin_balance : 0x2::balance::zero<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(),
            swap_ratio          : 1000,
        };
        0x2::transfer::share_object<SwapPool>(v0);
    }

    public entry fun swap_faucet_to_jack_751(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = v0 * 1000 / arg0.swap_ratio;
        assert!(0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&arg0.jack_751_balance) >= v1, 1);
        0x2::balance::join<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&mut arg0.faucet_coin_balance, 0x2::coin::into_balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>>(0x2::coin::from_balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(0x2::balance::split<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&mut arg0.jack_751_balance, v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = SwapEvent{
            user            : 0x2::tx_context::sender(arg2),
            jack_751_in     : 0,
            faucet_coin_in  : v0,
            jack_751_out    : v1,
            faucet_coin_out : 0,
        };
        0x2::event::emit<SwapEvent>(v2);
    }

    public entry fun swap_jack_751_to_faucet(arg0: &mut SwapPool, arg1: 0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&arg1);
        assert!(v0 > 0, 2);
        let v1 = v0 * arg0.swap_ratio / 1000;
        assert!(0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg0.faucet_coin_balance) >= v1, 1);
        0x2::balance::join<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(&mut arg0.jack_751_balance, 0x2::coin::into_balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751::JACK_751>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>>(0x2::coin::from_balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(0x2::balance::split<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&mut arg0.faucet_coin_balance, v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = SwapEvent{
            user            : 0x2::tx_context::sender(arg2),
            jack_751_in     : v0,
            faucet_coin_in  : 0,
            jack_751_out    : 0,
            faucet_coin_out : v1,
        };
        0x2::event::emit<SwapEvent>(v2);
    }

    public entry fun update_swap_ratio(arg0: &mut SwapPool, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 3);
        arg0.swap_ratio = arg1;
    }

    // decompiled from Move bytecode v6
}

