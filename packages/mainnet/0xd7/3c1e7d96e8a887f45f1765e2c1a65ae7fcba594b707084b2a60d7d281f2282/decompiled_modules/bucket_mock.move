module 0xd73c1e7d96e8a887f45f1765e2c1a65ae7fcba594b707084b2a60d7d281f2282::bucket_mock {
    struct BUCKET_MOCK has drop {
        dummy_field: bool,
    }

    struct BuckTreasury has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<BUCKET_MOCK>,
    }

    struct Bottle has store, key {
        id: 0x2::object::UID,
        collateral_amount: u64,
        buck_amount: u64,
        stake_amount: u64,
        reward_coll_snapshot: u128,
        reward_debt_snapshot: u128,
    }

    struct Bucket<phantom T0> has store, key {
        id: 0x2::object::UID,
        min_collateral_ratio: u64,
        collateral_vault: 0x2::balance::Balance<T0>,
        minted_buck_amount: u64,
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

    // decompiled from Move bytecode v6
}

