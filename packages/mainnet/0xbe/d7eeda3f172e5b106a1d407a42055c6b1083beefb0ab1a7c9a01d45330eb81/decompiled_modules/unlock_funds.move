module 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::unlock_funds {
    struct UnlockFunds<T0: store> {
        owner: address,
        account_id: 0x2::object::ID,
        funds: T0,
    }

    public(friend) fun new<T0: store>(arg0: address, arg1: 0x2::object::ID, arg2: T0) : 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::Request<UnlockFunds<T0>> {
        let v0 = UnlockFunds<T0>{
            owner      : arg0,
            account_id : arg1,
            funds      : arg2,
        };
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::new<UnlockFunds<T0>>(v0)
    }

    public fun resolve<T0: store>(arg0: 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::Request<UnlockFunds<T0>>, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::Policy<T0>) : T0 {
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::versioning<T0>(arg1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::versioning::assert_is_valid_version(&v0);
        let UnlockFunds {
            owner      : _,
            account_id : _,
            funds      : v3,
        } = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::resolve<UnlockFunds<T0>>(arg0, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::policy::required_approvals<T0>(arg1, 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::keys::unlock_funds_action()));
        v3
    }

    public fun account_id<T0: store>(arg0: &UnlockFunds<T0>) : 0x2::object::ID {
        arg0.account_id
    }

    public fun funds<T0: store>(arg0: &UnlockFunds<T0>) : &T0 {
        &arg0.funds
    }

    public fun owner<T0: store>(arg0: &UnlockFunds<T0>) : address {
        arg0.owner
    }

    public fun resolve_unrestricted_balance<T0>(arg0: 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::Request<UnlockFunds<0x2::balance::Balance<T0>>>, arg1: &0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::namespace::Namespace) : 0x2::balance::Balance<T0> {
        assert!(!0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::namespace::policy_exists<0x2::balance::Balance<T0>>(arg1), 13835058248555692033);
        let v0 = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::namespace::versioning(arg1);
        0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::versioning::assert_is_valid_version(&v0);
        let UnlockFunds {
            owner      : _,
            account_id : _,
            funds      : v3,
        } = 0xbed7eeda3f172e5b106a1d407a42055c6b1083beefb0ab1a7c9a01d45330eb81::request::resolve<UnlockFunds<0x2::balance::Balance<T0>>>(arg0, 0x2::vec_set::empty<0x1::type_name::TypeName>());
        v3
    }

    // decompiled from Move bytecode v7
}

