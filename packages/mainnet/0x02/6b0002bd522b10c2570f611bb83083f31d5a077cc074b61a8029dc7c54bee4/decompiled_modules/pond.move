module 0x26b0002bd522b10c2570f611bb83083f31d5a077cc074b61a8029dc7c54bee4::pond {
    struct MOLE_POND has drop {
        dummy_field: bool,
    }

    struct MolePondForBuck has key {
        id: 0x2::object::UID,
        pool: 0x2::balance::Balance<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>,
        manager: address,
    }

    fun accrue(arg0: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::destroy_zero<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::deposit_single_in<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0, 0x2::coin::zero<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg2), 0, arg1, arg2));
    }

    public fun assert_sender_is_manager(arg0: &MolePondForBuck, arg1: &0x2::tx_context::TxContext) {
        if (!is_manager(arg0, 0x2::tx_context::sender(arg1))) {
            err_sender_is_not_manager();
        };
    }

    public fun claim(arg0: &mut MolePondForBuck, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK> {
        assert_sender_is_manager(arg0, arg4);
        accrue(arg1, arg3, arg4);
        let v0 = 0x2::coin::take<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&mut arg0.pool, 0x2::balance::value<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&arg0.pool) - 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::token_amount_to_magic_share<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_shared<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::VaultInfo<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(arg1), 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::output_volume<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MOLE_POND>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_pipe<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MOLE_POND>(arg2))), arg4);
        0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::withdraw_single_out<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1, v0, 0x2::coin::value<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&v0), arg3, arg4)
    }

    public fun deposit(arg0: &mut MolePondForBuck, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg5);
        let v0 = MOLE_POND{dummy_field: false};
        0x2::coin::put<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&mut arg0.pool, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::deposit_single_in<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1, 0x2::coin::from_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::destroy_output_carrier<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MOLE_POND>(v0, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::output_buck<MOLE_POND>(arg2, arg4)), arg5), arg4, arg3, arg5));
    }

    fun err_not_enough_to_withdraw() {
        abort 1
    }

    fun err_sender_is_not_manager() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MolePondForBuck{
            id      : 0x2::object::new(arg0),
            pool    : 0x2::balance::zero<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(),
            manager : @0xbfd2e22f32d4bcaaf6f12f218fcc26488fdf63f338481e0d4f96e95160d61ba9,
        };
        0x2::transfer::share_object<MolePondForBuck>(v0);
    }

    public fun is_manager(arg0: &MolePondForBuck, arg1: address) : bool {
        manager(arg0) == arg1
    }

    public fun manager(arg0: &MolePondForBuck) : address {
        arg0.manager
    }

    public fun set_manager(arg0: &mut MolePondForBuck, arg1: &0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::AdminCap, arg2: address) {
        arg0.manager = arg2;
    }

    public fun withdraw(arg0: &mut MolePondForBuck, arg1: &mut 0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::GlobalStorage, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_sender_is_manager(arg0, arg5);
        if (arg4 > 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::output_volume<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MOLE_POND>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_pipe<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MOLE_POND>(arg2))) {
            err_not_enough_to_withdraw();
        };
        let v0 = 0x2::coin::take<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&mut arg0.pool, 0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::token_amount_to_magic_share<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x9ec6f17e19c5e64c8872779a635235497fd6c71f7b5c23b07f652b02a240c84a::global_storage::borrow_shared<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::VaultInfo<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(arg1), arg4), arg5);
        let v1 = MOLE_POND{dummy_field: false};
        0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::input_buck<MOLE_POND>(arg2, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::pipe::input<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK, MOLE_POND>(v1, 0x2::coin::into_balance<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::withdraw_single_out<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg1, v0, 0x2::coin::value<0x5ffa69ee4ee14d899dcc750df92de12bad4bacf81efa1ae12ee76406804dda7f::vault::MagicCoin<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>>(&v0), arg3, arg5))));
    }

    // decompiled from Move bytecode v6
}

