module 0x487c1e99b5b299f65348bedf24e558b7cde23846d363894e386ec2f0e79dfd0f::jin {
    struct JIN has drop {
        dummy_field: bool,
    }

    struct Bus has store, key {
        id: 0x2::object::UID,
        rewards: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ResetEvent has copy, drop, store {
        reward_rate: u64,
    }

    struct RegisterEvent has copy, drop, store {
        miner: address,
    }

    struct MiningEvent has copy, drop, store {
        miner: address,
        claimable_rewards: u64,
        total_hashes: u64,
        total_rewards: u64,
        reward_rate: u64,
        new_hash: vector<u8>,
    }

    struct ClaimEvent has copy, drop, store {
        miner: address,
        amount: u64,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        total_miner: u64,
        difficulty: vector<u8>,
        last_reset_at: u64,
        reward_rate: u64,
        total_claimed_rewards: u64,
        treasury_cap: 0x2::coin::TreasuryCap<JIN>,
        jin_rewards: 0x2::balance::Balance<JIN>,
    }

    struct Proof has key {
        id: 0x2::object::UID,
        claimable_rewards: u64,
        hash: vector<u8>,
        total_hashes: u64,
        total_rewards: u64,
    }

    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        price: u64,
    }

    fun calculate_new_reward_rate(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            arg0
        } else {
            0x2::math::min(0x2::math::max(0x2::math::max(arg0 / 2, 0x2::math::min(arg0 * 2, arg0 * 1000000000 / arg1)), 1), 250000000)
        }
    }

    public fun claim(arg0: u64, arg1: &mut Treasury, arg2: &mut Proof, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<JIN> {
        assert!(arg2.claimable_rewards >= arg0, 7);
        arg2.claimable_rewards = arg2.claimable_rewards - arg0;
        arg1.total_claimed_rewards = arg1.total_claimed_rewards + arg0;
        let v0 = ClaimEvent{
            miner  : 0x2::tx_context::sender(arg3),
            amount : arg0,
        };
        0x2::event::emit<ClaimEvent>(v0);
        0x2::coin::from_balance<JIN>(0x2::balance::split<JIN>(&mut arg1.jin_rewards, arg0), arg3)
    }

    fun init(arg0: JIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 8) {
            let v1 = Bus{
                id      : 0x2::object::new(arg1),
                rewards : 1000,
            };
            0x2::transfer::share_object<Bus>(v1);
            v0 = v0 + 1;
        };
        let (v2, v3) = 0x2::coin::create_currency<JIN>(arg0, 9, b"2042DA", b"2042DA", b"2042DA", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JIN>>(v3);
        let v4 = Treasury{
            id                    : 0x2::object::new(arg1),
            total_miner           : 0,
            difficulty            : x"000000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffff",
            last_reset_at         : 0,
            reward_rate           : 1000,
            total_claimed_rewards : 0,
            treasury_cap          : v2,
            jin_rewards           : 0x2::balance::zero<JIN>(),
        };
        0x2::transfer::share_object<Treasury>(v4);
        let v5 = Vault{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
            price   : 100000000,
        };
        0x2::transfer::share_object<Vault>(v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mine(arg0: &0x2::clock::Clock, arg1: &mut Bus, arg2: &Treasury, arg3: &mut Proof, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg0) / 1000;
        assert!(v0 > 1712679987, 1);
        assert!(v0 < arg2.last_reset_at + 60, 3);
        let v1 = 0x2::tx_context::sender(arg6);
        validate_hash(arg5, arg3.hash, v1, arg4, arg2.difficulty);
        assert!(arg1.rewards >= arg2.reward_rate, 6);
        arg1.rewards = arg1.rewards - arg2.reward_rate;
        arg3.claimable_rewards = arg3.claimable_rewards + arg2.reward_rate;
        0x1::vector::append<u8>(&mut arg5, 0x1::bcs::to_bytes<u64>(&v0));
        0x1::vector::append<u8>(&mut arg5, arg3.hash);
        let v2 = 0x2::hash::keccak256(&arg5);
        arg3.hash = v2;
        arg3.total_hashes = arg3.total_hashes + 1;
        arg3.total_rewards = arg3.total_rewards + arg2.reward_rate;
        let v3 = MiningEvent{
            miner             : v1,
            claimable_rewards : arg3.claimable_rewards,
            total_hashes      : arg3.total_hashes,
            total_rewards     : arg3.total_rewards,
            reward_rate       : arg2.reward_rate,
            new_hash          : v2,
        };
        0x2::event::emit<MiningEvent>(v3);
    }

    public fun register(arg0: &mut Vault, arg1: &mut Treasury, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) : 0x487c1e99b5b299f65348bedf24e558b7cde23846d363894e386ec2f0e79dfd0f::jin_token::JinGenesisMinerNFT {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x1::bcs::to_bytes<address>(&v0);
        let v2 = Proof{
            id                : 0x2::object::new(arg3),
            claimable_rewards : 0,
            hash              : 0x2::hash::keccak256(&v1),
            total_hashes      : 0,
            total_rewards     : 0,
        };
        0x2::transfer::transfer<Proof>(v2, v0);
        arg1.total_miner = arg1.total_miner + 1;
        let v3 = RegisterEvent{miner: v0};
        0x2::event::emit<RegisterEvent>(v3);
        0x487c1e99b5b299f65348bedf24e558b7cde23846d363894e386ec2f0e79dfd0f::jin_token::mint(arg3)
    }

    public fun reset(arg0: &mut Bus, arg1: &mut Bus, arg2: &mut Bus, arg3: &mut Bus, arg4: &mut Bus, arg5: &mut Bus, arg6: &mut Bus, arg7: &mut Bus, arg8: &0x2::clock::Clock, arg9: &mut Treasury) {
        let v0 = 0x2::clock::timestamp_ms(arg8) / 1000;
        assert!(v0 > 1712679987, 1);
        assert!(v0 > arg9.last_reset_at + 60, 2);
        arg9.last_reset_at = v0;
        arg0.rewards = 250000000;
        arg1.rewards = 250000000;
        arg2.rewards = 250000000;
        arg3.rewards = 250000000;
        arg4.rewards = 250000000;
        arg5.rewards = 250000000;
        arg6.rewards = 250000000;
        arg7.rewards = 250000000;
        let v1 = 2000000000 - 0 + arg0.rewards + arg1.rewards + arg2.rewards + arg3.rewards + arg4.rewards + arg5.rewards + arg6.rewards + arg7.rewards;
        arg9.reward_rate = calculate_new_reward_rate(arg9.reward_rate, v1);
        0x2::balance::join<JIN>(&mut arg9.jin_rewards, 0x2::coin::mint_balance<JIN>(&mut arg9.treasury_cap, v1));
        let v2 = ResetEvent{reward_rate: arg9.reward_rate};
        0x2::event::emit<ResetEvent>(v2);
    }

    public fun update_difficulty(arg0: &AdminCap, arg1: vector<u8>, arg2: &mut Treasury) {
        arg2.difficulty = arg1;
    }

    public entry fun update_price(arg0: &AdminCap, arg1: u64, arg2: &mut Vault) {
        arg2.price = arg1;
    }

    fun validate_hash(arg0: vector<u8>, arg1: vector<u8>, arg2: address, arg3: u64, arg4: vector<u8>) {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        let v1 = 0x2::hash::keccak256(&v0);
        assert!(0x487c1e99b5b299f65348bedf24e558b7cde23846d363894e386ec2f0e79dfd0f::compare::cmp_bcs_bytes(&arg0, &v1) == 0, 4);
        assert!(0x487c1e99b5b299f65348bedf24e558b7cde23846d363894e386ec2f0e79dfd0f::compare::cmp_bcs_bytes(&arg0, &arg4) != 2, 5);
    }

    // decompiled from Move bytecode v6
}

