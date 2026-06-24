module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::send_funds {
    struct SendFunds<T0: store> {
        sender: address,
        recipient: address,
        sender_account_id: 0x2::object::ID,
        recipient_account_id: 0x2::object::ID,
        funds: T0,
    }

    public(friend) fun new<T0: store>(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: T0) : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::Request<SendFunds<T0>> {
        let v0 = SendFunds<T0>{
            sender               : arg0,
            recipient            : arg1,
            sender_account_id    : arg2,
            recipient_account_id : arg3,
            funds                : arg4,
        };
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::new<SendFunds<T0>>(v0)
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

    public fun resolve_balance<T0>(arg0: 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::Request<SendFunds<0x2::balance::Balance<T0>>>, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::Policy<0x2::balance::Balance<T0>>) {
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::versioning<0x2::balance::Balance<T0>>(arg1);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::assert_is_valid_version(&v0);
        let SendFunds {
            sender               : _,
            recipient            : _,
            sender_account_id    : _,
            recipient_account_id : v4,
            funds                : v5,
        } = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::request::resolve<SendFunds<0x2::balance::Balance<T0>>>(arg0, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy::required_approvals<0x2::balance::Balance<T0>>(arg1, 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::send_funds_action()));
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

