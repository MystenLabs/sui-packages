module 0xefb5dc861c296cfcceb7fb72c5533efddbc6cdc85395cd29b55119292b16b8cc::hybrid_seal_policy {
    struct HybridPolicy has key {
        id: 0x2::object::UID,
        version: u64,
        submission_id: 0x2::object::ID,
        seal_policy_id: 0x1::string::String,
        admin_whitelist: vector<address>,
        purchase_enabled: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        policy_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &mut HybridPolicy, arg1: &AdminCap, arg2: address) {
        assert!(arg1.policy_id == 0x2::object::id<HybridPolicy>(arg0), 1);
        if (!0x1::vector::contains<address>(&arg0.admin_whitelist, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.admin_whitelist, arg2);
        };
    }

    public fun admin_whitelist(arg0: &HybridPolicy) : &vector<address> {
        &arg0.admin_whitelist
    }

    fun check_purchase_policy(arg0: vector<u8>, arg1: &HybridPolicy, arg2: &0xefb5dc861c296cfcceb7fb72c5533efddbc6cdc85395cd29b55119292b16b8cc::purchase_policy::PurchaseReceipt) : bool {
        if (!arg1.purchase_enabled) {
            return false
        };
        if (arg0 != *0x1::string::as_bytes(&arg1.seal_policy_id)) {
            return false
        };
        0xefb5dc861c296cfcceb7fb72c5533efddbc6cdc85395cd29b55119292b16b8cc::purchase_policy::seal_policy_id(arg2) == &arg1.seal_policy_id
    }

    public fun create_policy(arg0: 0x2::object::ID, arg1: 0x1::string::String, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) : (HybridPolicy, AdminCap) {
        let v0 = HybridPolicy{
            id               : 0x2::object::new(arg3),
            version          : 1,
            submission_id    : arg0,
            seal_policy_id   : arg1,
            admin_whitelist  : arg2,
            purchase_enabled : true,
        };
        let v1 = AdminCap{
            id        : 0x2::object::new(arg3),
            policy_id : 0x2::object::id<HybridPolicy>(&v0),
        };
        (v0, v1)
    }

    fun is_admin(arg0: &HybridPolicy, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.admin_whitelist, &arg1)
    }

    public fun is_purchase_enabled(arg0: &HybridPolicy) : bool {
        arg0.purchase_enabled
    }

    public fun remove_admin(arg0: &mut HybridPolicy, arg1: &AdminCap, arg2: address) {
        assert!(arg1.policy_id == 0x2::object::id<HybridPolicy>(arg0), 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.admin_whitelist, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg0.admin_whitelist, v1);
        };
    }

    entry fun seal_approve_admin(arg0: vector<u8>, arg1: &HybridPolicy, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 3);
        assert!(is_admin(arg1, 0x2::tx_context::sender(arg2)), 2);
        assert!(arg0 == *0x1::string::as_bytes(&arg1.seal_policy_id), 1);
    }

    entry fun seal_approve_purchase(arg0: vector<u8>, arg1: &HybridPolicy, arg2: &0xefb5dc861c296cfcceb7fb72c5533efddbc6cdc85395cd29b55119292b16b8cc::purchase_policy::PurchaseReceipt) {
        assert!(arg1.version == 1, 3);
        assert!(check_purchase_policy(arg0, arg1, arg2), 1);
    }

    public fun seal_policy_id(arg0: &HybridPolicy) : &0x1::string::String {
        &arg0.seal_policy_id
    }

    public fun set_purchase_enabled(arg0: &mut HybridPolicy, arg1: &AdminCap, arg2: bool) {
        assert!(arg1.policy_id == 0x2::object::id<HybridPolicy>(arg0), 1);
        arg0.purchase_enabled = arg2;
    }

    public fun submission_id(arg0: &HybridPolicy) : 0x2::object::ID {
        arg0.submission_id
    }

    public fun version(arg0: &HybridPolicy) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

