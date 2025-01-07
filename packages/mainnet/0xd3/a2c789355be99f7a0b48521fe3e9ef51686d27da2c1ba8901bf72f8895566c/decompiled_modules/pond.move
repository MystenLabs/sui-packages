module 0xf0f1ae3923595785268512d304bf7dc45eb6aa3a577bbbbeaa5018c781ec4328::pond {
    struct POND has drop {
        dummy_field: bool,
    }

    struct BUCK_POND has drop {
        dummy_field: bool,
    }

    struct BuckPond has key {
        id: 0x2::object::UID,
        position: 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun claim_reward(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_valid_manager<BUCK_POND>(arg1, 0x2::tx_context::sender(arg4));
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.treasury);
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(position(arg0))) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::claim<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg3, arg2, 0x1::option::borrow_mut<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.position)));
        };
        0x2::coin::from_balance<0x2::sui::SUI>(v0, arg4)
    }

    public fun deposit_all_by_manager<T0>(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::house::pool_balance<T0>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::borrow_house<T0>(arg1));
        deposit_by_manager<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    public fun deposit_all_from_lottery<T0>(arg0: &mut BuckPond, arg1: &0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStoreAdminCap, arg2: &mut 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStore, arg3: 0x2::object::ID, arg4: &mut 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::Pipe<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>, arg5: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg6: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg7: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::lottery_prize_pool<T0>(arg2, arg3);
        deposit_from_lottery<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, arg9);
    }

    public fun deposit_by_manager<T0>(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_valid_manager<BUCK_POND>(arg1, 0x2::tx_context::sender(arg7));
        deposit_internal<T0>(arg0, arg2, arg3, arg4, arg5, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::destroy_output_carrier<T0, BUCK_POND>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::output<T0, BUCK_POND>(arg1, arg6), witness()), arg7);
    }

    public fun deposit_by_witness<T0, T1: drop>(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: u64, arg7: T1, arg8: &mut 0x2::tx_context::TxContext) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_game_supported<T0, T1>(arg1);
        deposit_internal<T0>(arg0, arg2, arg3, arg4, arg5, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::destroy_output_carrier<T0, BUCK_POND>(0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::output<T0, BUCK_POND>(arg1, arg6), witness()), arg8);
    }

    public fun deposit_from_lottery<T0>(arg0: &mut BuckPond, arg1: &0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStoreAdminCap, arg2: &mut 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStore, arg3: 0x2::object::ID, arg4: &mut 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::Pipe<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>, arg5: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg6: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg7: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        deposit_internal<T0>(arg0, arg5, arg6, arg7, arg8, 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::unwrap<T0, BUCK_POND>(0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::output<T0, BUCK_POND>(arg2, arg3, arg4, arg9), witness()), arg10);
    }

    fun deposit_internal<T0>(arg0: &mut BuckPond, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::buck_to_sbuck(arg1, arg3, arg4, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::charge_reservoir_by_partner<T0, BUCK_POND>(arg1, arg5, witness()));
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&arg0.position)) {
            let (v1, v2) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.position));
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v2);
            0x2::balance::join<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v0, v1);
        };
        let (_, v4) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2);
        0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.position, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, v0, v4, arg6));
    }

    fun err_sbuck_balance_not_enough() {
        abort 0
    }

    fun init(arg0: POND, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POND>(arg0, arg1);
        let v0 = BuckPond{
            id       : 0x2::object::new(arg1),
            position : 0x1::option::none<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(),
            treasury : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<BuckPond>(v0);
    }

    public fun position(arg0: &BuckPond) : &0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>> {
        &arg0.position
    }

    public fun sbuck_balance(arg0: &mut BuckPond) : u64 {
        if (0x1::option::is_some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(position(arg0))) {
            0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_proof_stake_amount<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(0x1::option::borrow<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(position(arg0)))
        } else {
            0
        }
    }

    public fun withdraw_all_by_manager<T0>(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = sbuck_balance(arg0);
        withdraw_by_manager<T0>(arg0, arg1, arg2, arg3, arg4, arg5, v0, arg6);
    }

    public fun withdraw_all_to_lottery<T0>(arg0: &mut BuckPond, arg1: &0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStoreAdminCap, arg2: &mut 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStore, arg3: 0x2::object::ID, arg4: &mut 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::Pipe<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>, arg5: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg6: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg7: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::volume<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>(arg4);
        withdraw_to_lottery<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, arg9);
    }

    public fun withdraw_by_manager<T0>(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_valid_manager<BUCK_POND>(arg1, 0x2::tx_context::sender(arg7));
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::input<T0, BUCK_POND>(arg1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::input<T0, BUCK_POND>(withdraw_internal<T0>(arg0, arg2, arg3, arg4, arg5, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::pool_debt_value<T0, BUCK_POND>(arg1), arg6, arg7), witness()));
    }

    public fun withdraw_by_witness<T0, T1: drop>(arg0: &mut BuckPond, arg1: &mut 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::Unihouse, arg2: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg3: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg4: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x2::clock::Clock, arg6: u64, arg7: T1, arg8: &mut 0x2::tx_context::TxContext) {
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::assert_game_supported<T0, T1>(arg1);
        0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::input<T0, BUCK_POND>(arg1, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::pipe::input<T0, BUCK_POND>(withdraw_internal<T0>(arg0, arg2, arg3, arg4, arg5, 0x2f2226a22ebeb7a0e63ea39551829b238589d981d1c6dd454f01fcc513035593::unihouse::pool_debt_value<T0, BUCK_POND>(arg1), arg6, arg8), witness()));
    }

    fun withdraw_internal<T0>(arg0: &mut BuckPond, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = sbuck_balance(arg0);
        if (arg6 > v0) {
            err_sbuck_balance_not_enough();
        };
        let (v1, v2) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.position));
        let v3 = v1;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, v2);
        if (0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v3) > 0) {
            let (_, v5) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2);
            0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(&mut arg0.position, 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, v3, v5, arg7));
        } else {
            0x2::balance::destroy_zero<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(v3);
        };
        let v6 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::discharge_reservoir_by_partner<T0, BUCK_POND>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::sbuck_to_buck(arg1, arg3, arg4, 0x2::balance::split<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v3, arg6)), witness());
        let v7 = 0x2::balance::value<T0>(&v6);
        if (v7 > arg5) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T0>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T0>(arg1), 0x2::balance::split<T0>(&mut v6, v7 - arg5));
        };
        v6
    }

    public fun withdraw_to_lottery<T0>(arg0: &mut BuckPond, arg1: &0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStoreAdminCap, arg2: &mut 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::LotteryStore, arg3: 0x2::object::ID, arg4: &mut 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::Pipe<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>, arg5: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg6: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg7: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg8: &0x2::clock::Clock, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::input<T0>(arg2, arg3, 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::input<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>(arg4, witness(), withdraw_internal<T0>(arg0, arg5, arg6, arg7, arg8, 0x588dbdc0613c62f4fc670f841006796bcd5184f7545c7c8a99241af2f694f5ac::pipe::volume<T0, 0x8c3ff5236a06b915562dc855e8169b8ffd073d21fc53355c8780abbe30fd20da::lottery::DoubleUpLottery, BUCK_POND>(arg4), arg9, arg10)));
    }

    fun witness() : BUCK_POND {
        BUCK_POND{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

