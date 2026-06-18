module 0x2ad62ac22e74172cc2e33cbebd7471fb16403831b3bdd1143d51935cefd1bbde::edge_pass {
    struct EdgePass has store, key {
        id: 0x2::object::UID,
        owner: address,
        budget: u64,
        auto_threshold: u64,
        escalate_threshold: u64,
        approved_merchants: vector<0x1::string::String>,
        spent: u64,
        active: bool,
        created_at: u64,
        expires_at: u64,
    }

    struct PassCreated has copy, drop {
        pass_id: address,
        owner: address,
        budget: u64,
        expires_at: u64,
    }

    struct TransactionExecuted has copy, drop {
        pass_id: address,
        merchant: 0x1::string::String,
        amount: u64,
        spent_total: u64,
    }

    struct PassRevoked has copy, drop {
        pass_id: address,
        owner: address,
    }

    public entry fun add_merchant(arg0: &mut EdgePass, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.approved_merchants, arg1);
    }

    public entry fun create_pass(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: vector<0x1::string::String>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        let v2 = v1 + arg3;
        let v3 = EdgePass{
            id                 : 0x2::object::new(arg6),
            owner              : v0,
            budget             : arg0,
            auto_threshold     : arg1,
            escalate_threshold : arg2,
            approved_merchants : arg4,
            spent              : 0,
            active             : true,
            created_at         : v1,
            expires_at         : v2,
        };
        let v4 = PassCreated{
            pass_id    : 0x2::object::uid_to_address(&v3.id),
            owner      : v0,
            budget     : arg0,
            expires_at : v2,
        };
        0x2::event::emit<PassCreated>(v4);
        0x2::transfer::transfer<EdgePass>(v3, v0);
    }

    public entry fun execute_transaction(arg0: &mut EdgePass, arg1: u64, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 0);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.expires_at, 1);
        assert!(is_merchant_approved(arg0, &arg2), 2);
        assert!(arg0.spent + arg1 <= arg0.budget, 3);
        assert!(arg1 <= arg0.escalate_threshold, 5);
        arg0.spent = arg0.spent + arg1;
        let v0 = TransactionExecuted{
            pass_id     : 0x2::object::uid_to_address(&arg0.id),
            merchant    : arg2,
            amount      : arg1,
            spent_total : arg0.spent,
        };
        0x2::event::emit<TransactionExecuted>(v0);
    }

    public fun is_active(arg0: &EdgePass) : bool {
        arg0.active
    }

    public fun is_merchant_approved(arg0: &EdgePass, arg1: &0x1::string::String) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.approved_merchants)) {
            if (0x1::vector::borrow<0x1::string::String>(&arg0.approved_merchants, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun owner(arg0: &EdgePass) : address {
        arg0.owner
    }

    public fun remaining_budget(arg0: &EdgePass) : u64 {
        arg0.budget - arg0.spent
    }

    public entry fun remove_merchant(arg0: &mut EdgePass, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg0.approved_merchants)) {
            if (*0x1::vector::borrow<0x1::string::String>(&arg0.approved_merchants, v0) == arg1) {
                0x1::vector::remove<0x1::string::String>(&mut arg0.approved_merchants, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public entry fun revoke_pass(arg0: &mut EdgePass, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 4);
        arg0.active = false;
        let v0 = PassRevoked{
            pass_id : 0x2::object::uid_to_address(&arg0.id),
            owner   : arg0.owner,
        };
        0x2::event::emit<PassRevoked>(v0);
    }

    // decompiled from Move bytecode v7
}

