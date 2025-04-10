module 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::staking {
    struct AdminCapMysten has store, key {
        id: 0x2::object::UID,
        fee_id: 0x2::object::ID,
    }

    struct StakePoolAdminCap has store, key {
        id: 0x2::object::UID,
        stake_pool_id: 0x2::object::ID,
    }

    struct FeesMysten has store, key {
        id: 0x2::object::UID,
        fee_collector_1: address,
        fee_collector_2: address,
        creation_fee_1: u64,
        creation_fee_2: u64,
        unstake_claim_fee_1: u64,
        unstake_claim_fee_2: u64,
    }

    struct StakeEntry<T0: store + key> has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        nft: T0,
        nft_owner: address,
        staked_at_epoch: u64,
        last_claimed_epoch: u64,
        stake_pool_id: 0x2::object::ID,
        url: 0x2::url::Url,
    }

    public entry fun create_stake_pool<T0, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &FeesMysten, arg2: 0x2::coin::TreasuryCap<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::create_stake_pool<T0>(arg2, 0x1::type_name::get<T1>(), v0, arg3, arg4, arg5, arg6, arg7, 1, arg8);
        let v2 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, arg1.creation_fee_1, arg8), arg1.fee_collector_1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, arg1.creation_fee_2, arg8), arg1.fee_collector_2);
        let v3 = StakePoolAdminCap{
            id            : 0x2::object::new(arg8),
            stake_pool_id : 0x2::object::id<0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T0>>(&v1),
        };
        0x2::transfer::public_transfer<StakePoolAdminCap>(v3, v0);
        0x2::transfer::public_share_object<0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T0>>(v1);
    }

    public entry fun deactivate_stake_pool<T0>(arg0: &StakePoolAdminCap, arg1: &mut 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::version<T0>(arg1) == 1, 4);
        assert!(arg0.stake_pool_id == 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::id<T0>(arg1), 2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::deactivate_stake_pool<T0>(arg1), 0x2::tx_context::sender(arg2));
    }

    public entry fun edit_stake_pool<T0>(arg0: &StakePoolAdminCap, arg1: &mut 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64) {
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::version<T0>(arg1) == 1, 4);
        assert!(arg0.stake_pool_id == 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::id<T0>(arg1), 2);
        0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::edit_stake_pool<T0>(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun claim<T0: store + key, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &FeesMysten, arg2: &mut StakeEntry<T0>, arg3: &mut 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::version<T1>(arg3) == 1, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg2.nft_owner, 1);
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::id<T1>(arg3) == arg2.stake_pool_id, 2);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        arg2.last_claimed_epoch = v1;
        let v2 = 0x2::coin::balance_mut<0x2::sui::SUI>(arg0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, arg1.unstake_claim_fee_1, arg5), arg1.fee_collector_1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v2, arg1.unstake_claim_fee_2, arg5), arg1.fee_collector_2);
        0x2::coin::mint_and_transfer<T1>(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::treasury_cap_<T1>(arg3), rewards_since_last_claim(v1, arg2.last_claimed_epoch, 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::reward_rate<T1>(arg3)), v0, arg5);
    }

    fun create_stake_entry<T0: store + key>(arg0: T0, arg1: address, arg2: u64, arg3: u64, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) : StakeEntry<T0> {
        let v0 = 0x1::string::utf8(b"A stake receipt for pool ");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(&arg4)));
        0x1::string::append_utf8(&mut v0, b" on Arcadia ");
        let v1 = 0x1::string::utf8(b"Your nft with id: ");
        0x1::string::append(&mut v1, 0x2::address::to_string(0x2::object::id_address<T0>(&arg0)));
        0x1::string::append_utf8(&mut v1, b" has been staked in pool: ");
        0x1::string::append(&mut v1, 0x2::address::to_string(0x2::object::id_to_address(&arg4)));
        0x1::string::append_utf8(&mut v1, b" on Arcadia ");
        StakeEntry<T0>{
            id                 : 0x2::object::new(arg5),
            name               : v0,
            description        : v1,
            nft                : arg0,
            nft_owner          : arg1,
            staked_at_epoch    : arg2,
            last_claimed_epoch : arg3,
            stake_pool_id      : arg4,
            url                : 0x2::url::new_unsafe(0x1::ascii::string(b"https://ipfs.io/ipfs/bafybeigveqfbmasoqnv5xe4ixu6phno5xker4mq2uwn5bfxulkiiewv7lm/stakereceiptArcadia.png")),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FeesMysten{
            id                  : 0x2::object::new(arg0),
            fee_collector_1     : @0xd75475d736fef445ad485f7ca499b1e736ca2c209f03b539e389c42b4825a32f,
            fee_collector_2     : @0xd75475d736fef445ad485f7ca499b1e736ca2c209f03b539e389c42b4825a32f,
            creation_fee_1      : 150000000,
            creation_fee_2      : 150000000,
            unstake_claim_fee_1 : 40000000,
            unstake_claim_fee_2 : 40000000,
        };
        let v1 = AdminCapMysten{
            id     : 0x2::object::new(arg0),
            fee_id : 0x2::object::id<FeesMysten>(&v0),
        };
        0x2::transfer::public_share_object<FeesMysten>(v0);
        0x2::transfer::transfer<AdminCapMysten>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun mint_from_treasurycap<T0>(arg0: &StakePoolAdminCap, arg1: &mut 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::version<T0>(arg1) == 1, 4);
        assert!(arg0.stake_pool_id == 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::id<T0>(arg1), 2);
        0x2::coin::mint_and_transfer<T0>(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::treasury_cap_<T0>(arg1), arg2, 0x2::tx_context::sender(arg3), arg3);
    }

    fun redeem_and_destroy_stake_entry<T0: store + key>(arg0: StakeEntry<T0>) : T0 {
        let StakeEntry {
            id                 : v0,
            name               : _,
            description        : _,
            nft                : v3,
            nft_owner          : _,
            staked_at_epoch    : _,
            last_claimed_epoch : _,
            stake_pool_id      : _,
            url                : _,
        } = arg0;
        0x2::object::delete(v0);
        v3
    }

    fun rewards_since_last_claim(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (arg0 - arg1) / 60000 * arg2
    }

    public entry fun set_fees(arg0: &AdminCapMysten, arg1: &mut FeesMysten, arg2: address, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        arg1.fee_collector_1 = arg2;
        arg1.fee_collector_2 = arg3;
        arg1.creation_fee_1 = arg4;
        arg1.creation_fee_2 = arg5;
        arg1.unstake_claim_fee_1 = arg6;
        arg1.unstake_claim_fee_2 = arg7;
    }

    public entry fun stake<T0: store + key, T1>(arg0: T0, arg1: &mut 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::version<T1>(arg1) == 1, 4);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::nft_type<T1>(arg1) == 0x1::type_name::get<T0>(), 3);
        0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::increment_staked_nfts_<T1>(arg1);
        0x2::transfer::transfer<StakeEntry<T0>>(create_stake_entry<T0>(arg0, v0, 0x2::clock::timestamp_ms(arg2), 0x2::clock::timestamp_ms(arg2), 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::id<T1>(arg1), arg3), v0);
    }

    public entry fun unstake<T0: store + key, T1>(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: &FeesMysten, arg2: StakeEntry<T0>, arg3: &mut 0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::StakePool<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::version<T1>(arg3) == 1, 4);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(v0 == arg2.nft_owner, 1);
        assert!(0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::id<T1>(arg3) == arg2.stake_pool_id, 2);
        let v1 = &mut arg2;
        claim<T0, T1>(arg0, arg1, v1, arg3, arg4, arg5);
        0x2::transfer::public_transfer<T0>(redeem_and_destroy_stake_entry<T0>(arg2), v0);
        0x5b99c52956c1ea83749d3da059418493681b4ceb8e0f0d17ac0ca3f530f6c087::stake_pool::decrement_staked_nfts_<T1>(arg3);
    }

    // decompiled from Move bytecode v6
}

