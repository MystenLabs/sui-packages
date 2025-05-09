module 0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::staking {
    struct StakedV has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>,
        unstake_time: u64,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        unstaking_period: u64,
        is_paused: bool,
    }

    struct TokensStaked has copy, drop {
        staker: address,
        amount: u64,
    }

    struct TokensClaimed has copy, drop {
        staker: address,
        amount: u64,
    }

    struct TokensUnstaked has copy, drop {
        staker: address,
    }

    public fun change_pause_status(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Config) {
        arg1.is_paused = !arg1.is_paused;
    }

    public entry fun claim_unstaked_tokens(arg0: StakedV, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg3, 1);
        assert!(!arg1.is_paused, 2);
        assert!(arg0.unstake_time != 0 && 0x2::clock::timestamp_ms(arg2) >= arg0.unstake_time, 0);
        let StakedV {
            id           : v0,
            amount       : v1,
            unstake_time : _,
        } = arg0;
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>>(0x2::coin::from_balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(v3, arg4), 0x2::tx_context::sender(arg4));
        0x2::object::delete(v0);
        let v4 = TokensClaimed{
            staker : 0x2::tx_context::sender(arg4),
            amount : 0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&v3),
        };
        0x2::event::emit<TokensClaimed>(v4);
    }

    public fun get_staked_amount(arg0: &StakedV) : u64 {
        0x2::balance::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg0.amount)
    }

    public fun get_unstake_time(arg0: &StakedV) : u64 {
        arg0.unstake_time
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id               : 0x2::object::new(arg0),
            unstaking_period : 1209600000,
            is_paused        : true,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.is_paused
    }

    public entry fun stake_tokens(arg0: 0x2::coin::Coin<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>, arg1: &Config, arg2: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg2, 1);
        assert!(!arg1.is_paused, 2);
        let v0 = StakedV{
            id           : 0x2::object::new(arg3),
            amount       : 0x2::coin::into_balance<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(arg0),
            unstake_time : 0,
        };
        0x2::transfer::transfer<StakedV>(v0, 0x2::tx_context::sender(arg3));
        let v1 = TokensStaked{
            staker : 0x2::tx_context::sender(arg3),
            amount : 0x2::coin::value<0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::vendetta::VENDETTA>(&arg0),
        };
        0x2::event::emit<TokensStaked>(v1);
    }

    public entry fun unstake_tokens(arg0: &mut StakedV, arg1: &Config, arg2: &0x2::clock::Clock, arg3: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::version::validate_version(arg3, 1);
        assert!(!arg1.is_paused, 2);
        assert!(arg0.unstake_time == 0, 1);
        arg0.unstake_time = 0x2::clock::timestamp_ms(arg2) + arg1.unstaking_period;
        let v0 = TokensUnstaked{staker: 0x2::tx_context::sender(arg4)};
        0x2::event::emit<TokensUnstaked>(v0);
    }

    public fun update_unstaking_period(arg0: &0xd832145d0211d4e3332881c742fc255e037139575d1359f3dea67d8886075394::role::AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.unstaking_period = arg2;
    }

    // decompiled from Move bytecode v6
}

