module 0xfd1514c12d7e0db3234d69407da2e4bc1d553e44e7b71770e5db873e7978948::shadow_send_pool {
    struct Config has key {
        id: 0x2::object::UID,
        total_deposits: u64,
        total_claims: u64,
        total_volume: u64,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        commitments: 0x2::table::Table<vector<u8>, CommitmentInfo>,
        balance: 0x2::balance::Balance<T0>,
        active_commitments: u64,
        total_deposited: u64,
        total_claimed: u64,
    }

    struct CommitmentInfo has store {
        amount: u64,
        created_at: u64,
        recipient_hint: address,
    }

    struct DepositAdded has copy, drop {
        pool_id: 0x2::object::ID,
        commitment_hash: vector<u8>,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        created_at: u64,
    }

    struct DepositClaimed has copy, drop {
        pool_id: 0x2::object::ID,
        commitment_hash: vector<u8>,
        amount: u64,
        recipient: address,
        coin_type: 0x1::type_name::TypeName,
    }

    struct PoolCreated has copy, drop {
        pool_id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
    }

    public entry fun claim<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::hash::blake2b256(&arg2);
        assert!(0x2::table::contains<vector<u8>, CommitmentInfo>(&arg1.commitments, v0), 101);
        let CommitmentInfo {
            amount         : v1,
            created_at     : _,
            recipient_hint : _,
        } = 0x2::table::remove<vector<u8>, CommitmentInfo>(&mut arg1.commitments, v0);
        let v4 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, v1), arg3), v4);
        arg1.active_commitments = arg1.active_commitments - 1;
        arg1.total_claimed = arg1.total_claimed + v1;
        arg0.total_claims = arg0.total_claims + 1;
        let v5 = DepositClaimed{
            pool_id         : 0x2::object::uid_to_inner(&arg1.id),
            commitment_hash : v0,
            amount          : v1,
            recipient       : v4,
            coin_type       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<DepositClaimed>(v5);
    }

    public entry fun create_pool<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id                 : 0x2::object::new(arg0),
            commitments        : 0x2::table::new<vector<u8>, CommitmentInfo>(arg0),
            balance            : 0x2::balance::zero<T0>(),
            active_commitments : 0,
            total_deposited    : 0,
            total_claimed      : 0,
        };
        let v1 = PoolCreated{
            pool_id   : 0x2::object::uid_to_inner(&v0.id),
            coin_type : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<PoolCreated>(v1);
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    public entry fun deposit<T0>(arg0: &mut Config, arg1: &mut Pool<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) == 32, 102);
        assert!(!0x2::table::contains<vector<u8>, CommitmentInfo>(&arg1.commitments, arg3), 100);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= 10000, 105);
        let v1 = v0 * 1 / 100;
        let v2 = v1;
        if (v1 < 100) {
            v2 = 100;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v2, arg6), @0x71d783069c9f6545418cf23259dd791d5ed48ae22218d8d1539de31dec48e67a);
        let v3 = 0x2::coin::value<T0>(&arg2);
        let v4 = 0x2::clock::timestamp_ms(arg5);
        let v5 = CommitmentInfo{
            amount         : v3,
            created_at     : v4,
            recipient_hint : arg4,
        };
        0x2::table::add<vector<u8>, CommitmentInfo>(&mut arg1.commitments, arg3, v5);
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
        arg1.active_commitments = arg1.active_commitments + 1;
        arg1.total_deposited = arg1.total_deposited + v3;
        arg0.total_deposits = arg0.total_deposits + 1;
        arg0.total_volume = arg0.total_volume + v3;
        let v6 = DepositAdded{
            pool_id         : 0x2::object::uid_to_inner(&arg1.id),
            commitment_hash : arg3,
            amount          : v3,
            coin_type       : 0x1::type_name::get<T0>(),
            created_at      : v4,
        };
        0x2::event::emit<DepositAdded>(v6);
    }

    public fun get_commitment_info<T0>(arg0: &Pool<T0>, arg1: vector<u8>) : (u64, u64, address) {
        let v0 = 0x2::table::borrow<vector<u8>, CommitmentInfo>(&arg0.commitments, arg1);
        (v0.amount, v0.created_at, v0.recipient_hint)
    }

    public fun get_config_stats(arg0: &Config) : (u64, u64, u64) {
        (arg0.total_deposits, arg0.total_claims, arg0.total_volume)
    }

    public fun get_pool_stats<T0>(arg0: &Pool<T0>) : (u64, u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance), arg0.active_commitments, arg0.total_deposited, arg0.total_claimed)
    }

    public fun has_commitment<T0>(arg0: &Pool<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, CommitmentInfo>(&arg0.commitments, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id             : 0x2::object::new(arg0),
            total_deposits : 0,
            total_claims   : 0,
            total_volume   : 0,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    // decompiled from Move bytecode v6
}

