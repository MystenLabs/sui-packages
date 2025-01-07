module 0x1623123a6b6c0c3c4a6ea39f3374af38f0f73580144d5a7980458efa359db6f0::bucket_farm {
    struct Receive<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        current_debt: u64,
    }

    struct Repay<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        current_debt: u64,
    }

    struct BucketFarm has drop {
        dummy_field: bool,
    }

    struct StableFarm<phantom T0> has key {
        id: 0x2::object::UID,
        sheet: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Sheet<BucketFarm, T0>,
        conversion_rate: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::Float,
        positions: 0x2::vec_map::VecMap<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>,
        rewards: 0x2::vec_map::VecMap<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>,
        whitelisted_creditors: 0x2::vec_set::VecSet<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun claim_reward<T0: drop, T1>(arg0: &mut StableFarm<T1>, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>();
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, &v0)), arg2)
    }

    public fun create_stable<T0>(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = StableFarm<T0>{
            id                    : 0x2::object::new(arg2),
            sheet                 : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::new<BucketFarm, T0>(stamp()),
            conversion_rate       : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from_fraction(0x1::u64::pow(10, 9), 0x1::u64::pow(10, arg1)),
            positions             : 0x2::vec_map::empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(),
            rewards               : 0x2::vec_map::empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(),
            whitelisted_creditors : 0x2::vec_set::empty<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(),
        };
        0x2::transfer::share_object<StableFarm<T0>>(v0);
    }

    fun deposit_stable<T0, T1>(arg0: &mut StableFarm<T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: 0x2::balance::Balance<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>();
        let v1 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::buck_to_sbuck(arg1, arg3, arg4, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::charge_reservoir_by_partner<T1, BucketFarm>(arg1, arg5, stamp()));
        let (_, v3) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2);
        if (0x2::vec_map::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(&arg0.positions, &v0)) {
            let (v4, v5) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(&mut arg0.positions, &v0)));
            if (!0x2::vec_map::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.rewards, &v0)) {
                0x2::vec_map::insert<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, v0, 0x2::balance::zero<0x2::sui::SUI>());
            };
            0x2::balance::join<0x2::sui::SUI>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, &v0), v5);
            0x2::balance::join<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v1, v4);
            0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(&mut arg0.positions, &v0), 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, v1, v3, arg6));
        } else {
            0x2::vec_map::insert<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(&mut arg0.positions, v0, 0x1::option::some<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, v1, v3, arg6)));
        };
    }

    fun err_not_whitelisted() {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted_creditor<T0, T1>(arg0: &StableFarm<T1>) : bool {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>();
        0x2::vec_set::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(&arg0.whitelisted_creditors, &v0)
    }

    public fun receive_stable<T0, T1>(arg0: &mut StableFarm<T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Loan<T0, BucketFarm, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        if (!is_whitelisted_creditor<T0, T1>(arg0)) {
            err_not_whitelisted();
        };
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::receive<T0, BucketFarm, T1>(&mut arg0.sheet, arg5, stamp());
        let v1 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>();
        let v2 = Receive<T0, T1>{
            amount       : 0x2::balance::value<T1>(&v0),
            current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<BucketFarm, T1>(&arg0.sheet), &v1)),
        };
        0x2::event::emit<Receive<T0, T1>>(v2);
        deposit_stable<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg6);
    }

    public fun repay_stable<T0, T1>(arg0: &mut StableFarm<T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: &mut 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T0, BucketFarm, T1>, arg6: &mut 0x2::tx_context::TxContext) {
        if (!is_whitelisted_creditor<T0, T1>(arg0)) {
            err_not_whitelisted();
        };
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T0, BucketFarm, T1>(arg5);
        let v1 = withdraw_stable<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg6);
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T0, BucketFarm, T1>(&mut arg0.sheet, arg5, v1, stamp());
        let v2 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>();
        let v3 = Repay<T0, T1>{
            amount       : v0,
            current_debt : 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debt_value<T1>(0x2::vec_map::get<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Debt<T1>>(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::debts<BucketFarm, T1>(&arg0.sheet), &v2)),
        };
        0x2::event::emit<Repay<T0, T1>>(v3);
    }

    public fun repay_stable_v2<T0, T1>(arg0: &mut StableFarm<T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::coin::Coin<T1>, arg6: &mut 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Collector<T0, BucketFarm, T1>, arg7: &mut 0x2::tx_context::TxContext) {
        if (!is_whitelisted_creditor<T0, T1>(arg0)) {
            err_not_whitelisted();
        };
        let v0 = withdraw_stable<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T0, BucketFarm, T1>(arg6), arg7);
        if (0x2::balance::value<T1>(&v0) < 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T0, BucketFarm, T1>(arg6)) {
            0x2::balance::join<T1>(&mut v0, 0x2::balance::split<T1>(0x2::coin::balance_mut<T1>(arg5), 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::requirement<T0, BucketFarm, T1>(arg6) - 0x2::balance::value<T1>(&v0)));
        };
        0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::repay<T0, BucketFarm, T1>(&mut arg0.sheet, arg6, v0, stamp());
    }

    fun stamp() : BucketFarm {
        BucketFarm{dummy_field: false}
    }

    public fun whitelist_creditor<T0, T1>(arg0: &mut StableFarm<T1>, arg1: &AdminCap) {
        0x2::vec_set::insert<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor>(&mut arg0.whitelisted_creditors, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>());
    }

    fun withdraw_stable<T0, T1>(arg0: &mut StableFarm<T1>, arg1: &mut 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BucketProtocol, arg2: &mut 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::Fountain<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>, arg3: &mut 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::Flask<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let v0 = 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::creditor<T0>();
        let (v1, v2) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::force_unstake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, 0x1::option::extract<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(&mut arg0.positions, &v0)));
        let v3 = v1;
        if (!0x2::vec_map::contains<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&arg0.rewards, &v0)) {
            0x2::vec_map::insert<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, v0, 0x2::balance::zero<0x2::sui::SUI>());
        };
        0x2::balance::join<0x2::sui::SUI>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x2::balance::Balance<0x2::sui::SUI>>(&mut arg0.rewards, &v0), v2);
        if (0x2::balance::value<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&v3) > 0) {
            let (_, v5) = 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::get_lock_time_range<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg2);
            0x1::option::fill<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>(0x2::vec_map::get_mut<0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::sheet::Creditor, 0x1::option::Option<0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::StakeProof<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>>>(&mut arg0.positions, &v0), 0x75b23bde4de9aca930d8c1f1780aa65ee777d8b33c3045b053a178b452222e82::fountain_core::stake<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK, 0x2::sui::SUI>(arg4, arg2, v3, v5, arg6));
        } else {
            0x2::balance::destroy_zero<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(v3);
        };
        let v6 = 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::discharge_reservoir_by_partner<T1, BucketFarm>(arg1, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::sbuck_to_buck(arg1, arg3, arg4, 0x2::balance::split<0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::SBUCK>(&mut v3, 0x1798f84ee72176114ddbf5525a6d964c5f8ea1b3738d08d50d0d3de4cf584884::sbuck::sbuck_out_amount<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg3, 0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::ceil(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::mul(0xa90218c8ec02c619b2b4db3e3d32cfeb5c1cf762879ef75bae9f27020751d0f8::float::from(arg5), arg0.conversion_rate))))), stamp());
        let v7 = 0x2::balance::value<T1>(&v6);
        if (v7 > arg5) {
            0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::well::collect_fee<T1>(0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::borrow_well_mut<T1>(arg1), 0x2::balance::split<T1>(&mut v6, v7 - arg5));
        };
        v6
    }

    // decompiled from Move bytecode v6
}

