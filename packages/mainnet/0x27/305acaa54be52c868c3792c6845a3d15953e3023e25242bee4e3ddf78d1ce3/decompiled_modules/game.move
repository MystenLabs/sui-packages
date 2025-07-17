module 0x27305acaa54be52c868c3792c6845a3d15953e3023e25242bee4e3ddf78d1ce3::game {
    struct FlipGame has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>,
    }

    struct Admin has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public entry fun deposit(arg0: &mut FlipGame, arg1: &mut 0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>, arg2: u64) {
        assert!(0x2::coin::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(arg1) >= arg2, 1000);
        0x2::balance::join<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&mut arg0.balance, 0x2::balance::split<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(0x2::coin::balance_mut<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(arg1), arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlipGame{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(),
        };
        let v1 = Admin{
            id   : 0x2::object::new(arg0),
            name : 0x1::string::utf8(b"Jack-751"),
        };
        0x2::transfer::transfer<Admin>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<FlipGame>(v0);
    }

    entry fun play(arg0: &mut FlipGame, arg1: &0x2::random::Random, arg2: bool, arg3: &mut 0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg0.balance) >= arg4, 1001);
        assert!(0x2::coin::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(arg3) >= arg4, 1000);
        assert!(arg4 * 10 <= 0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg0.balance), 1001);
        let v0 = 0x2::random::new_generator(arg1, arg5);
        if (0x2::random::generate_bool(&mut v0) == arg2) {
            0x2::coin::join<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(arg3, 0x2::coin::take<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&mut arg0.balance, arg4, arg5));
        } else {
            deposit(arg0, arg3, arg4);
        };
    }

    public entry fun withdraw(arg0: &mut FlipGame, arg1: &Admin, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&arg0.balance) >= arg2, 1001);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>>(0x2::coin::take<0xd324003f9bd2409e139a24ac0ec2329a6a27e1da847e1dda3927bc78343e940f::jack_751_faucet_coin::JACK_751_FAUCET_COIN>(&mut arg0.balance, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

