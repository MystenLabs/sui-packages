module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::clawback_funds {
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

    public(friend) fun new<T0: store>(arg0: address, arg1: 0x2::object::ID, arg2: T0) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<ClawbackFunds<T0>> {
        let v0 = ClawbackFunds<T0>{
            owner      : arg0,
            account_id : arg1,
            funds      : arg2,
        };
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::new<ClawbackFunds<T0>>(v0)
    }

    public fun owner<T0: store>(arg0: &ClawbackFunds<T0>) : address {
        arg0.owner
    }

    public fun resolve<T0: store>(arg0: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<ClawbackFunds<T0>>, arg1: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<T0>) : T0 {
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::versioning<T0>(arg1);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&v0);
        assert!(0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::is_clawback_allowed<T0>(arg1), 13835058184131182593);
        let ClawbackFunds {
            owner      : _,
            account_id : _,
            funds      : v3,
        } = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::resolve<ClawbackFunds<T0>>(arg0, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::required_approvals<T0>(arg1, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::clawback_funds_action()));
        v3
    }

    // decompiled from Move bytecode v7
}

