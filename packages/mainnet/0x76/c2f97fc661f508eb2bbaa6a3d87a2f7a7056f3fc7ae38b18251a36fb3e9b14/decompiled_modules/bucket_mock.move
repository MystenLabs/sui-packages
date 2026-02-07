module 0x76c2f97fc661f508eb2bbaa6a3d87a2f7a7056f3fc7ae38b18251a36fb3e9b14::bucket_mock {
    struct BUCKET_MOCK has drop {
        dummy_field: bool,
    }

    struct SUSDB has drop {
        dummy_field: bool,
    }

    struct BuckTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BUCKET_MOCK>,
    }

    struct SavingPool has key {
        id: 0x2::object::UID,
        buck_vault: 0x2::balance::Balance<BUCKET_MOCK>,
        sui_reward_vault: 0x2::balance::Balance<0x2::sui::SUI>,
        susdb_supply: 0x2::coin::TreasuryCap<SUSDB>,
    }

    struct Bottle has store, key {
        id: 0x2::object::UID,
        collateral_amount: u64,
        buck_amount: u64,
        stake_amount: u64,
        reward_coll_snapshot: u128,
        reward_debt_snapshot: u128,
    }

    public fun create_mock_bottle(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : Bottle {
        Bottle{
            id                   : 0x2::object::new(arg2),
            collateral_amount    : arg0,
            buck_amount          : arg1,
            stake_amount         : 0,
            reward_coll_snapshot : 0,
            reward_debt_snapshot : 0,
        }
    }

    public fun create_saving_pool(arg0: SUSDB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSDB>(arg0, 9, b"sUSDB", b"Staked USDB", b"Bucket Saving Receipt", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUSDB>>(v1);
        let v2 = SavingPool{
            id               : 0x2::object::new(arg1),
            buck_vault       : 0x2::balance::zero<BUCKET_MOCK>(),
            sui_reward_vault : 0x2::balance::zero<0x2::sui::SUI>(),
            susdb_supply     : v0,
        };
        0x2::transfer::share_object<SavingPool>(v2);
    }

    public fun get_bottle_info(arg0: &Bottle) : (u64, u64) {
        (arg0.collateral_amount, arg0.buck_amount)
    }

    fun init(arg0: BUCKET_MOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUCKET_MOCK>(arg0, 9, b"BUCK", b"Bucket USD", b"Mock BUCK Token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUCKET_MOCK>>(v1);
        let v2 = BuckTreasury{
            id  : 0x2::object::new(arg1),
            cap : v0,
        };
        0x2::transfer::share_object<BuckTreasury>(v2);
    }

    public fun is_legit_bottle(arg0: &Bottle) : bool {
        true
    }

    public fun mint_mock(arg0: &mut BuckTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BUCKET_MOCK> {
        0x2::coin::mint<BUCKET_MOCK>(&mut arg0.cap, arg1, arg2)
    }

    public fun stake(arg0: &mut SavingPool, arg1: 0x2::coin::Coin<BUCKET_MOCK>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<SUSDB> {
        0x2::balance::join<BUCKET_MOCK>(&mut arg0.buck_vault, 0x2::coin::into_balance<BUCKET_MOCK>(arg1));
        0x2::coin::mint<SUSDB>(&mut arg0.susdb_supply, 0x2::coin::value<BUCKET_MOCK>(&arg1), arg2)
    }

    public fun unstake(arg0: &mut SavingPool, arg1: 0x2::coin::Coin<SUSDB>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BUCKET_MOCK> {
        0x2::coin::burn<SUSDB>(&mut arg0.susdb_supply, arg1);
        0x2::coin::take<BUCKET_MOCK>(&mut arg0.buck_vault, 0x2::coin::value<SUSDB>(&arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

