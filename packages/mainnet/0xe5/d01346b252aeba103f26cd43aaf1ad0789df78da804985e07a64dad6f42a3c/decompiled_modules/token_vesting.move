module 0xe5d01346b252aeba103f26cd43aaf1ad0789df78da804985e07a64dad6f42a3c::token_vesting {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct State has key {
        id: 0x2::object::UID,
        clift: u64,
        epoch_duration: u64,
        num_epochs: u64,
        xflx_ratio: u64,
        released: 0x2::table::Table<address, u64>,
        balance: 0x2::balance::Balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>,
    }

    struct Release has copy, drop {
        state_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    public fun balance(arg0: &State) : u64 {
        0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg0.balance)
    }

    public entry fun create_state(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0 && arg3 > 0, 1);
        let v0 = State{
            id             : 0x2::object::new(arg5),
            clift          : arg1,
            epoch_duration : arg2,
            num_epochs     : arg3,
            xflx_ratio     : arg4,
            released       : 0x2::table::new<address, u64>(arg5),
            balance        : 0x2::balance::zero<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(),
        };
        0x2::transfer::share_object<State>(v0);
    }

    public entry fun deposit(arg0: &AdminCap, arg1: &mut State, arg2: 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>) {
        0x2::balance::join<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg1.balance, 0x2::coin::into_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(arg2));
    }

    public fun epoch(arg0: &State, arg1: &0x2::clock::Clock) : u64 {
        let v0 = (0x2::clock::timestamp_ms(arg1) - arg0.clift) / arg0.epoch_duration;
        let v1 = last_epoch(arg0);
        if (v0 >= v1) {
            v1
        } else {
            v0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun last_epoch(arg0: &State) : u64 {
        arg0.num_epochs - 1
    }

    public fun releasable_amount(arg0: &State, arg1: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: &0x2::clock::Clock) : u64 {
        vested_amount(arg0, arg1, arg2) - released_amount(arg0, arg1)
    }

    public entry fun release(arg0: &mut State, arg1: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: &mut 0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::TreasuryManagement, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = releasable_amount(arg0, arg1, arg3);
        assert!(v0 > 0, 0);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = withdraw_(arg0, v0, arg4);
        0x65ed6d4e666fcbc1afcd9d4b1d6d4af7def3eeeeaa663f5bebae8101112290f6::xflx::mint_and_transfer(arg2, 0x2::coin::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut v2, 0xe5d01346b252aeba103f26cd43aaf1ad0789df78da804985e07a64dad6f42a3c::u64::mul_div(0x2::coin::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&v2), arg0.xflx_ratio, 10000), arg4), v1, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(v2, v1);
        set_released_epoch(arg0, arg1, arg3);
        let v3 = Release{
            state_id : 0x2::object::id<State>(arg0),
            amount   : v0,
            sender   : v1,
        };
        0x2::event::emit<Release>(v3);
    }

    public fun released_amount(arg0: &State, arg1: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.released, 0x2::object::id_address<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(arg1))) {
            0
        } else {
            0xe5d01346b252aeba103f26cd43aaf1ad0789df78da804985e07a64dad6f42a3c::u64::mul_div(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pending_rewards(arg1), *0x2::table::borrow<address, u64>(&arg0.released, 0x2::object::id_address<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(arg1)), arg0.num_epochs)
        }
    }

    public fun released_epoch(arg0: &State, arg1: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position) : u64 {
        if (!0x2::table::contains<address, u64>(&arg0.released, 0x2::object::id_address<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(arg1))) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&arg0.released, 0x2::object::id_address<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(arg1))
        }
    }

    fun set_released_epoch(arg0: &mut State, arg1: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id_address<0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position>(arg1);
        if (!0x2::table::contains<address, u64>(&arg0.released, v0)) {
            0x2::table::add<address, u64>(&mut arg0.released, v0, epoch(arg0, arg2) + 1);
        } else {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.released, v0) = epoch(arg0, arg2) + 1;
        };
    }

    public fun vested_amount(arg0: &State, arg1: &0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::Position, arg2: &0x2::clock::Clock) : u64 {
        if (0x2::clock::timestamp_ms(arg2) < arg0.clift) {
            0
        } else {
            0xe5d01346b252aeba103f26cd43aaf1ad0789df78da804985e07a64dad6f42a3c::u64::mul_div(0x6be2e5847e91ca2f18de8cbd711367b87440e6a5ca99c63b1ea1d29d743c8212::position::pending_rewards(arg1), epoch(arg0, arg2) + 1, arg0.num_epochs)
        }
    }

    public entry fun withdraw(arg0: &AdminCap, arg1: &mut State, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw_(arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>>(v0, 0x2::tx_context::sender(arg3));
    }

    fun withdraw_(arg0: &mut State, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX> {
        assert!(0x2::balance::value<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&arg0.balance) >= arg1, 2);
        0x2::coin::from_balance<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(0x2::balance::split<0x6dae8ca14311574fdfe555524ea48558e3d1360d1607d1c7f98af867e3b7976c::flx::FLX>(&mut arg0.balance, arg1), arg2)
    }

    public entry fun withdraw_all(arg0: &AdminCap, arg1: &mut State, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = balance(arg1);
        withdraw(arg0, arg1, v0, arg2);
    }

    // decompiled from Move bytecode v6
}

