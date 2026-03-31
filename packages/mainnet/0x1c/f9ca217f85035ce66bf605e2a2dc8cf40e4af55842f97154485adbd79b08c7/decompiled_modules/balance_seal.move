module 0x1cf9ca217f85035ce66bf605e2a2dc8cf40e4af55842f97154485adbd79b08c7::balance_seal {
    struct BalanceSealed has copy, drop {
        name_hash: vector<u8>,
        timestamp_ms: u64,
    }

    struct BalanceDecrypted has copy, drop {
        name_hash: vector<u8>,
        accessor: address,
    }

    struct BalancePolicy has key {
        id: 0x2::object::UID,
        admin: address,
    }

    struct SealedBalance has drop, store {
        encrypted_blob: vector<u8>,
        updated_ms: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BalancePolicy{
            id    : 0x2::object::new(arg0),
            admin : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<BalancePolicy>(v0);
    }

    entry fun remove_sealed_balance(arg0: &mut BalancePolicy, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<vector<u8>, SealedBalance>(&mut arg0.id, arg1);
        };
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &BalancePolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg0) >= 69, 1);
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 32;
        while (v1 < 64) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&arg0, v1));
            v1 = v1 + 1;
        };
        assert!(0x2::dynamic_field::exists_<vector<u8>>(&arg1.id, v0), 0);
        let v2 = BalanceDecrypted{
            name_hash : v0,
            accessor  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BalanceDecrypted>(v2);
    }

    entry fun set_admin(arg0: &mut BalancePolicy, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    entry fun store_sealed_balance(arg0: &mut BalancePolicy, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 0);
        let v0 = SealedBalance{
            encrypted_blob : arg2,
            updated_ms     : 0x2::clock::timestamp_ms(arg3),
        };
        if (0x2::dynamic_field::exists_<vector<u8>>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<vector<u8>, SealedBalance>(&mut arg0.id, arg1);
        };
        0x2::dynamic_field::add<vector<u8>, SealedBalance>(&mut arg0.id, arg1, v0);
        let v1 = BalanceSealed{
            name_hash    : arg1,
            timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BalanceSealed>(v1);
    }

    // decompiled from Move bytecode v6
}

