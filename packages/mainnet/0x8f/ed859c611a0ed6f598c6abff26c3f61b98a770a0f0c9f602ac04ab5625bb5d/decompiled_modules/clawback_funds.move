module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::clawback_funds {
    struct ClawbackFunds<T0: store> {
        owner: address,
        account_id: 0x2::object::ID,
        funds: T0,
    }

    public fun account_id<T0: store>(arg0: &ClawbackFunds<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun funds<T0: store>(arg0: &ClawbackFunds<T0>) : &T0 {
        &arg0.funds
    }

    public(friend) fun new<T0: store>(arg0: address, arg1: 0x2::object::ID, arg2: T0) : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::Request<ClawbackFunds<T0>> {
        let v0 = ClawbackFunds<T0>{
            owner      : arg0,
            account_id : arg1,
            funds      : arg2,
        };
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::new<ClawbackFunds<T0>>(v0)
    }

    public fun owner<T0: store>(arg0: &ClawbackFunds<T0>) : address {
        arg0.owner
    }

    public fun resolve<T0: store>(arg0: 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::Request<ClawbackFunds<T0>>, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<T0>) : T0 {
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::versioning<T0>(arg1);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::assert_is_valid_version(&v0);
        assert!(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::is_clawback_allowed<T0>(arg1), 13835058184131182593);
        let ClawbackFunds {
            owner      : _,
            account_id : _,
            funds      : v3,
        } = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::resolve<ClawbackFunds<T0>>(arg0, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::required_approvals<T0>(arg1, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::clawback_funds_action()));
        v3
    }

    // decompiled from Move bytecode v7
}

