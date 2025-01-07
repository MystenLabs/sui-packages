module 0xb6a38e2a4e1e871f0ca98b1cc4527bd5695ce1ef43c5fd4a880725b2924ef33b::redeem {
    struct RedeemConfig has key {
        id: 0x2::object::UID,
        bronze_amount: u64,
        silver_amount: u64,
        gold_amount: u64,
        platinum_amount: u64,
        diamond_amount: u64,
        legendary_amount: u64,
        redeem_enabled: bool,
        reward: 0x2::balance::Balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun redeem(arg0: &mut RedeemConfig, arg1: 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::ScallopBox, arg2: &0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::version::Version, arg3: &mut 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::ScallopBoxStats, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA> {
        assert!(arg0.redeem_enabled, 101);
        let v0 = get_redeem_amount(arg0, &arg1);
        assert!(0x2::balance::value<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&arg0.reward) >= v0, 102);
        0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::user::burn_scallop_box(arg2, arg3, arg1, arg4);
        0x2::coin::from_balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(0x2::balance::split<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg0.reward, v0), arg4)
    }

    public fun deposit_reward(arg0: &mut RedeemConfig, arg1: 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>) {
        0x2::balance::join<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg0.reward, 0x2::coin::into_balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(arg1));
    }

    fun get_redeem_amount(arg0: &RedeemConfig, arg1: &0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::ScallopBox) : u64 {
        let v0 = 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::box_rarity(arg1);
        if (v0 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::bronze()) {
            arg0.bronze_amount
        } else if (v0 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::silver()) {
            arg0.silver_amount
        } else if (v0 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::gold()) {
            arg0.gold_amount
        } else if (v0 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::platinum()) {
            arg0.platinum_amount
        } else if (v0 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::diamond()) {
            arg0.diamond_amount
        } else {
            assert!(v0 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::legendary(), 0);
            arg0.legendary_amount
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RedeemConfig{
            id               : 0x2::object::new(arg0),
            bronze_amount    : 0,
            silver_amount    : 0,
            gold_amount      : 0,
            platinum_amount  : 0,
            diamond_amount   : 0,
            legendary_amount : 0,
            redeem_enabled   : false,
            reward           : 0x2::balance::zero<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RedeemConfig>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun set_redeem_amount(arg0: &AdminCap, arg1: &mut RedeemConfig, arg2: u64, arg3: u64) {
        if (arg2 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::bronze()) {
            arg1.bronze_amount = arg3;
        } else if (arg2 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::silver()) {
            arg1.silver_amount = arg3;
        } else if (arg2 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::gold()) {
            arg1.gold_amount = arg3;
        } else if (arg2 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::platinum()) {
            arg1.platinum_amount = arg3;
        } else if (arg2 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::diamond()) {
            arg1.diamond_amount = arg3;
        } else {
            assert!(arg2 == 0xa653f8b58d59c14596011927175185d9f3063aa02293e63e1650a93762446ca2::scallop_box::legendary(), 0);
            arg1.legendary_amount = arg3;
        };
    }

    public fun set_redeem_status(arg0: &AdminCap, arg1: &mut RedeemConfig, arg2: bool) {
        arg1.redeem_enabled = arg2;
    }

    public fun withdraw_reward(arg0: &AdminCap, arg1: &mut RedeemConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA> {
        0x2::coin::from_balance<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(0x2::balance::split<0x7016aae72cfc67f2fadf55769c0a7dd54291a583b63051a5ed71081cce836ac6::sca::SCA>(&mut arg1.reward, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

