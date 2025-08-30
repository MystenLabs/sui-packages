module 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::privacy_pool {
    struct PrivacyPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        merkle_tree: 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::merkle_tree::MerkleTree,
        verifying_key: 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::groth16_verifier::VerifyingKey,
        total_deposits: u64,
        total_withdrawals: u64,
        fee_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        enabled: bool,
    }

    struct Commitment has store, key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        amount: u64,
        leaf_index: u64,
    }

    struct Nullifier has store, key {
        id: 0x2::object::UID,
        hash: vector<u8>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        commitment: vector<u8>,
        leaf_index: u64,
        amount: u64,
        timestamp: u64,
    }

    struct WithdrawEvent has copy, drop {
        nullifier: vector<u8>,
        recipient: address,
        amount: u64,
        fee: u64,
        timestamp: u64,
    }

    fun address_to_bytes(arg0: address) : vector<u8> {
        0x2::address::to_bytes(arg0)
    }

    fun amount_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public entry fun deposit(arg0: &mut PrivacyPool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 >= 100000000 && v0 <= 100000000000, 0);
        let (v1, _) = 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::merkle_tree::append(&mut arg0.merkle_tree, arg2);
        let v3 = Commitment{
            id         : 0x2::object::new(arg4),
            hash       : arg2,
            amount     : v0,
            leaf_index : v1,
        };
        0x2::transfer::share_object<Commitment>(v3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_deposits = arg0.total_deposits + v0;
        let v4 = DepositEvent{
            commitment : arg2,
            leaf_index : v1,
            amount     : v0,
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<DepositEvent>(v4);
    }

    public fun get_current_root(arg0: &PrivacyPool) : vector<u8> {
        0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::merkle_tree::get_root(&arg0.merkle_tree)
    }

    public fun get_pool_stats(arg0: &PrivacyPool) : (u64, u64, u64, bool) {
        (0x2::balance::value<0x2::sui::SUI>(&arg0.balance), arg0.total_deposits, arg0.total_withdrawals, arg0.enabled)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PrivacyPool{
            id                : 0x2::object::new(arg0),
            balance           : 0x2::balance::zero<0x2::sui::SUI>(),
            merkle_tree       : 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::merkle_tree::initialize(26, arg0),
            verifying_key     : 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::groth16_verifier::get_default_verifying_key(),
            total_deposits    : 0,
            total_withdrawals : 0,
            fee_balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            enabled           : true,
        };
        0x2::transfer::share_object<PrivacyPool>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun nullifier_exists(arg0: &PrivacyPool, arg1: vector<u8>) : bool {
        0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)
    }

    public entry fun set_pool_enabled(arg0: &AdminCap, arg1: &mut PrivacyPool, arg2: bool) {
        arg1.enabled = arg2;
    }

    public entry fun update_verifying_key(arg0: &AdminCap, arg1: &mut PrivacyPool, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<vector<u8>>) {
        arg1.verifying_key = 0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::groth16_verifier::new_verifying_key(arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun withdraw(arg0: &mut PrivacyPool, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: u64, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.enabled, 5);
        assert!(arg6 >= 100000000 && arg6 <= 100000000000, 0);
        assert!(0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::merkle_tree::is_valid_root(&arg0.merkle_tree, arg7), 3);
        assert!(!nullifier_exists(arg0, arg4), 2);
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, arg4);
        0x1::vector::push_back<vector<u8>>(&mut v0, arg7);
        0x1::vector::push_back<vector<u8>>(&mut v0, amount_to_bytes(arg6));
        0x1::vector::push_back<vector<u8>>(&mut v0, address_to_bytes(arg5));
        assert!(0xeba49af44d52ba917946acf3e0a5f907b6767317280639686529d01903e7f057::groth16_verifier::verify_proof(arg1, arg2, arg3, v0, &arg0.verifying_key), 1);
        let v1 = Nullifier{
            id   : 0x2::object::new(arg8),
            hash : arg4,
        };
        0x2::dynamic_field::add<vector<u8>, bool>(&mut arg0.id, arg4, true);
        0x2::transfer::share_object<Nullifier>(v1);
        let v2 = arg6 * 30 / 10000;
        let v3 = arg6 - v2;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) >= v3, 4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v3, arg8), arg5);
        if (v2 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.fee_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v2, arg8)));
        };
        arg0.total_withdrawals = arg0.total_withdrawals + arg6;
        let v4 = WithdrawEvent{
            nullifier : arg4,
            recipient : arg5,
            amount    : v3,
            fee       : v2,
            timestamp : 0x2::tx_context::epoch_timestamp_ms(arg8),
        };
        0x2::event::emit<WithdrawEvent>(v4);
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut PrivacyPool, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.fee_balance);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.fee_balance, v0), arg2), 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

