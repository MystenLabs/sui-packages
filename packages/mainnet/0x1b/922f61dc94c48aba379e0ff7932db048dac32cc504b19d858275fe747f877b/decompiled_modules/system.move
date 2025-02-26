module 0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::system {
    struct SYSTEM has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TreasureCap has store, key {
        id: 0x2::object::UID,
    }

    struct RockeeArchieve has key {
        id: 0x2::object::UID,
        owner: address,
        last_time: u64,
        amount: u64,
        nonce_checkin: u128,
        nonce_claim_reward: u128,
    }

    struct RockeeReg has store, key {
        id: 0x2::object::UID,
        regs: 0x2::table::Table<address, bool>,
    }

    struct RockeeStore has store, key {
        id: 0x2::object::UID,
        validator: 0x1::option::Option<vector<u8>>,
    }

    struct RewardPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        active: bool,
        coins: 0x2::coin::Coin<T0>,
        reward_limit: u64,
    }

    struct RockeeCheckInEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct DepositEvent has copy, drop {
        from: address,
        amount: u64,
        to: address,
        type_token: 0x1::type_name::TypeName,
        timestamp: u64,
    }

    struct RewardDepositEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardEmergencyWithdrawEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
    }

    struct RewardClaimedEvent has copy, drop {
        owner: address,
        amount: u64,
        timestamp: u64,
        nonce: u128,
    }

    public fun checkInRockee(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut RockeeStore, arg3: &mut RockeeArchieve, arg4: &0x2::clock::Clock, arg5: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg5, 1);
        verifySignature(arg0, arg1, &arg2.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        assert!(v3 > arg3.nonce_checkin, 8002);
        assert!(v1 == 0x2::tx_context::sender(arg6), 8004);
        assert!(v2 > 0, 8006);
        let v4 = 0x2::clock::timestamp_ms(arg4);
        arg3.amount = arg3.amount + v2;
        verUpdateNonceCheckIn(v3, arg3);
        arg3.last_time = v4;
        let v5 = RockeeCheckInEvent{
            owner     : v1,
            amount    : v2,
            timestamp : v4,
        };
        0x2::event::emit<RockeeCheckInEvent>(v5);
    }

    public fun claimReward<T0>(arg0: vector<u8>, arg1: vector<u8>, arg2: &mut RewardPool<T0>, arg3: &mut RockeeStore, arg4: &mut RockeeArchieve, arg5: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg5, 1);
        assert!(arg2.active, 8008);
        verifySignature(arg0, arg1, &arg3.validator);
        let v0 = 0x2::bcs::new(arg1);
        let v1 = 0x2::bcs::peel_address(&mut v0);
        let v2 = 0x2::bcs::peel_u64(&mut v0);
        let v3 = 0x2::bcs::peel_u128(&mut v0);
        assert!(0x2::tx_context::sender(arg7) == v1, 8004);
        assert!(0x2::object::id_address<RewardPool<T0>>(arg2) == 0x2::bcs::peel_address(&mut v0), 8009);
        assert!(v3 > arg4.nonce_claim_reward, 8002);
        let v4 = 0x2::clock::timestamp_ms(arg6);
        assert!(arg2.reward_limit == 0 || arg2.reward_limit >= v2, 8010);
        verUpdateNonceClaimReward(v3, arg4);
        arg4.last_time = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.coins, v2, arg7), v1);
        let v5 = RewardClaimedEvent{
            owner     : v1,
            amount    : v2,
            timestamp : v4,
            nonce     : v3,
        };
        0x2::event::emit<RewardClaimedEvent>(v5);
    }

    public fun configRewardPool<T0>(arg0: &AdminCap, arg1: &mut RewardPool<T0>, arg2: bool, arg3: u64, arg4: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg4, 1);
        arg1.active = arg2;
        arg1.reward_limit = arg3;
    }

    public fun createRewardPool<T0>(arg0: &AdminCap, arg1: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg2: &mut 0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg1, 1);
        let v0 = RewardPool<T0>{
            id           : 0x2::object::new(arg2),
            active       : true,
            coins        : 0x2::coin::zero<T0>(arg2),
            reward_limit : 0,
        };
        0x2::transfer::share_object<RewardPool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: address, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg4: &mut 0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg3, 1);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 8006);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0);
        let v1 = DepositEvent{
            from       : 0x2::tx_context::sender(arg4),
            amount     : v0,
            to         : arg0,
            type_token : 0x1::type_name::get<T0>(),
            timestamp  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun depositReward<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut RewardPool<T0>, arg2: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg2, 1);
        0x2::coin::join<T0>(&mut arg1.coins, arg0);
        let v0 = RewardDepositEvent{
            owner     : 0x2::tx_context::sender(arg4),
            amount    : 0x2::coin::value<T0>(&arg0),
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardDepositEvent>(v0);
    }

    public fun emergencyRewardWithdraw<T0>(arg0: &TreasureCap, arg1: &mut RewardPool<T0>, arg2: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<T0>(&arg1.coins);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg1.coins, v1, arg4), v0);
        let v2 = RewardEmergencyWithdrawEvent{
            owner     : v0,
            amount    : v1,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<RewardEmergencyWithdrawEvent>(v2);
    }

    public fun infoRockeeArchieve(arg0: &RockeeArchieve) : (address, u64, u128, u128) {
        (arg0.owner, arg0.amount, arg0.nonce_checkin, arg0.nonce_claim_reward)
    }

    fun init(arg0: SYSTEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = TreasureCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<TreasureCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = RockeeStore{
            id        : 0x2::object::new(arg1),
            validator : 0x1::option::none<vector<u8>>(),
        };
        0x2::transfer::share_object<RockeeStore>(v2);
        let v3 = RockeeReg{
            id   : 0x2::object::new(arg1),
            regs : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<RockeeReg>(v3);
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::cap_vault::createVault<AdminCap>(arg1);
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::cap_vault::createVault<TreasureCap>(arg1);
    }

    public fun register(arg0: &mut RockeeReg, arg1: &0x2::clock::Clock, arg2: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version, arg3: &mut 0x2::tx_context::TxContext) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg2, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, bool>(&arg0.regs, v0), 8005);
        let v1 = RockeeArchieve{
            id                 : 0x2::object::new(arg3),
            owner              : v0,
            last_time          : 0x2::clock::timestamp_ms(arg1),
            amount             : 0,
            nonce_checkin      : 0,
            nonce_claim_reward : 0,
        };
        0x2::transfer::transfer<RockeeArchieve>(v1, v0);
        0x2::table::add<address, bool>(&mut arg0.regs, v0, true);
    }

    public fun setValidator(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut RockeeStore, arg3: &0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::Version) {
        0x1b922f61dc94c48aba379e0ff7932db048dac32cc504b19d858275fe747f877b::version::checkVersion(arg3, 1);
        0x1::option::swap_or_fill<vector<u8>>(&mut arg2.validator, arg1);
    }

    public fun verUpdateNonceCheckIn(arg0: u128, arg1: &mut RockeeArchieve) {
        assert!(arg1.nonce_checkin < arg0, 8002);
        arg1.nonce_checkin = arg0;
    }

    public fun verUpdateNonceClaimReward(arg0: u128, arg1: &mut RockeeArchieve) {
        assert!(arg1.nonce_claim_reward < arg0, 8002);
        arg1.nonce_claim_reward = arg0;
    }

    public fun verifySignature(arg0: vector<u8>, arg1: vector<u8>, arg2: &0x1::option::Option<vector<u8>>) {
        assert!(0x1::option::is_some<vector<u8>>(arg2), 8007);
        assert!(0x2::ed25519::ed25519_verify(&arg0, 0x1::option::borrow<vector<u8>>(arg2), &arg1), 8003);
    }

    // decompiled from Move bytecode v6
}

