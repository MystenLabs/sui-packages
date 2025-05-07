module 0x7e95dc10fb96ffb2341f664926417b0fb261c9f3dc417344d2a3b11a2f5bb812::ve_sca_reward {
    struct RewardPool has key {
        id: 0x2::object::UID,
        user_rewards: 0x2::table::Table<0x2::object::ID, u64>,
        reserve_ve_sca_key: 0x1::option::Option<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>,
        enable_claim: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun borrow_reserve_ve_sca_key(arg0: &AdminCap, arg1: &RewardPool) : &0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey {
        0x1::option::borrow<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(&arg1.reserve_ve_sca_key)
    }

    public entry fun decrease_user_reward(arg0: &AdminCap, arg1: &mut RewardPool, arg2: 0x2::object::ID, arg3: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.user_rewards, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.user_rewards, arg2);
            if (*v0 > arg3) {
                *v0 = *v0 - arg3;
            } else {
                *v0 = 0;
            };
        };
    }

    public entry fun disable_claim(arg0: &AdminCap, arg1: &mut RewardPool) {
        arg1.enable_claim = false;
    }

    public entry fun enable_claim(arg0: &AdminCap, arg1: &mut RewardPool) {
        arg1.enable_claim = true;
    }

    public fun fill_reserve_ve_sca_key(arg0: &AdminCap, arg1: 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey, arg2: &mut RewardPool) {
        0x1::option::fill<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(&mut arg2.reserve_ve_sca_key, arg1);
    }

    public entry fun increase_user_reward(arg0: &AdminCap, arg1: &mut RewardPool, arg2: 0x2::object::ID, arg3: u64) {
        if (0x2::table::contains<0x2::object::ID, u64>(&arg1.user_rewards, arg2)) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg1.user_rewards, arg2);
            *v0 = *v0 + arg3;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg1.user_rewards, arg2, arg3);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardPool{
            id                 : 0x2::object::new(arg0),
            user_rewards       : 0x2::table::new<0x2::object::ID, u64>(arg0),
            reserve_ve_sca_key : 0x1::option::none<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(),
            enable_claim       : true,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<RewardPool>(v0);
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun redeem_reward(arg0: &mut RewardPool, arg1: &0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey, arg2: &0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::config::VeScaProtocolConfig, arg3: &mut 0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaTable, arg4: &0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca_subscriber::VeScaSubscriberTable, arg5: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey> {
        assert!(arg0.enable_claim, 1001);
        let v0 = 0x2::object::id<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(arg1);
        assert!(0x2::table::contains<0x2::object::ID, u64>(&arg0.user_rewards, v0), 1002);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.user_rewards, v0);
        if (*v1 > 0) {
            *v1 = 0;
            0x1::option::some<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::split(arg2, 0x1::option::borrow<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>(&arg0.reserve_ve_sca_key), arg3, arg4, *v1, arg5))
        } else {
            0x1::option::none<0xc7f5568dbd69488437ee95f2d9a028724e1de12432965ff8acca7c67310ba46::ve_sca::VeScaKey>()
        }
    }

    // decompiled from Move bytecode v6
}

