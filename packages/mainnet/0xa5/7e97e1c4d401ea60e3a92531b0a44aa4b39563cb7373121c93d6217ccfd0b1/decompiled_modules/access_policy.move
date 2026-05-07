module 0xa57e97e1c4d401ea60e3a92531b0a44aa4b39563cb7373121c93d6217ccfd0b1::access_policy {
    struct AccessPolicy has store, key {
        id: 0x2::object::UID,
        form_id: address,
        policy_type: u8,
        seal_policy_id: 0x1::string::String,
        creator: address,
    }

    struct AccessPolicyCreated has copy, drop {
        policy_id: address,
        form_id: address,
        policy_type: u8,
    }

    public fun can_submit(arg0: &AccessPolicy) : bool {
        arg0.policy_type == 0 || arg0.policy_type == 1
    }

    public fun create_public_policy(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPolicy{
            id             : 0x2::object::new(arg1),
            form_id        : arg0,
            policy_type    : 0,
            seal_policy_id : 0x1::string::utf8(b""),
            creator        : 0x2::tx_context::sender(arg1),
        };
        let v1 = AccessPolicyCreated{
            policy_id   : 0x2::object::uid_to_address(&v0.id),
            form_id     : v0.form_id,
            policy_type : v0.policy_type,
        };
        0x2::event::emit<AccessPolicyCreated>(v1);
        0x2::transfer::public_transfer<AccessPolicy>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun create_seal_policy(arg0: address, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessPolicy{
            id             : 0x2::object::new(arg2),
            form_id        : arg0,
            policy_type    : 1,
            seal_policy_id : 0x1::string::utf8(arg1),
            creator        : 0x2::tx_context::sender(arg2),
        };
        let v1 = AccessPolicyCreated{
            policy_id   : 0x2::object::uid_to_address(&v0.id),
            form_id     : v0.form_id,
            policy_type : v0.policy_type,
        };
        0x2::event::emit<AccessPolicyCreated>(v1);
        0x2::transfer::public_transfer<AccessPolicy>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun is_seal(arg0: &AccessPolicy) : bool {
        arg0.policy_type == 1
    }

    public fun policy_id(arg0: &AccessPolicy) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public fun policy_type(arg0: &AccessPolicy) : u8 {
        arg0.policy_type
    }

    // decompiled from Move bytecode v7
}

