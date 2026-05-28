module 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::send_funds {
    struct SendFunds<T0: store> {
        sender: address,
        recipient: address,
        sender_account_id: 0x2::object::ID,
        recipient_account_id: 0x2::object::ID,
        funds: T0,
    }

    public(friend) fun new<T0: store>(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: T0) : 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<SendFunds<T0>> {
        let v0 = SendFunds<T0>{
            sender               : arg0,
            recipient            : arg1,
            sender_account_id    : arg2,
            recipient_account_id : arg3,
            funds                : arg4,
        };
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::new<SendFunds<T0>>(v0)
    }

    public fun funds<T0: store>(arg0: &SendFunds<T0>) : &T0 {
        &arg0.funds
    }

    public fun recipient<T0: store>(arg0: &SendFunds<T0>) : address {
        arg0.recipient
    }

    public fun recipient_account_id<T0: store>(arg0: &SendFunds<T0>) : 0x2::object::ID {
        arg0.recipient_account_id
    }

    public fun resolve_balance<T0>(arg0: 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::Request<SendFunds<0x2::balance::Balance<T0>>>, arg1: &0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::Policy<0x2::balance::Balance<T0>>) {
        let v0 = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::versioning<0x2::balance::Balance<T0>>(arg1);
        0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::versioning::assert_is_valid_version(&v0);
        let SendFunds {
            sender               : _,
            recipient            : _,
            sender_account_id    : _,
            recipient_account_id : v4,
            funds                : v5,
        } = 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::request::resolve<SendFunds<0x2::balance::Balance<T0>>>(arg0, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::policy::required_approvals<0x2::balance::Balance<T0>>(arg1, 0xe2f75f77648329be3eac31d8455c81df95003dcb5ed50964102b7e1d44f82ad5::keys::send_funds_action()));
        let v6 = v4;
        0x2::balance::send_funds<T0>(v5, 0x2::object::id_to_address(&v6));
    }

    public fun sender<T0: store>(arg0: &SendFunds<T0>) : address {
        arg0.sender
    }

    public fun sender_account_id<T0: store>(arg0: &SendFunds<T0>) : 0x2::object::ID {
        arg0.sender_account_id
    }

    // decompiled from Move bytecode v7
}

