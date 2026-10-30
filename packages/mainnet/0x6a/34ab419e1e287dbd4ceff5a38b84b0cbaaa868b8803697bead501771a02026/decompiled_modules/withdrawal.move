module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::withdrawal {
    struct RequestKey has copy, drop, store {
        pos0: address,
        pos1: u64,
    }

    struct WithdrawalRequest<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        owner: address,
        request_id: u64,
        shares: 0x2::balance::Balance<T0>,
        payout: address,
        finalizer: 0x1::option::Option<address>,
        requested_at_ms: u64,
        eligible_at_ms: u64,
        expires_at_ms: 0x1::option::Option<u64>,
    }

    public fun derive_address(arg0: 0x2::object::ID, arg1: address, arg2: u64) : address {
        let v0 = RequestKey{
            pos0 : arg1,
            pos1 : arg2,
        };
        0x2::derived_object::derive_address<RequestKey>(arg0, v0)
    }

    public(friend) fun destroy<T0>(arg0: WithdrawalRequest<T0>) : 0x2::balance::Balance<T0> {
        let WithdrawalRequest {
            id              : v0,
            vault_id        : _,
            owner           : _,
            request_id      : _,
            shares          : v4,
            payout          : _,
            finalizer       : _,
            requested_at_ms : _,
            eligible_at_ms  : _,
            expires_at_ms   : _,
        } = arg0;
        0x2::object::delete(v0);
        v4
    }

    public fun eligible_at_ms<T0>(arg0: &WithdrawalRequest<T0>) : u64 {
        arg0.eligible_at_ms
    }

    public(friend) fun expedite<T0>(arg0: &mut WithdrawalRequest<T0>, arg1: u64) : 0x1::option::Option<u64> {
        if (arg1 >= arg0.eligible_at_ms) {
            return 0x1::option::none<u64>()
        };
        arg0.eligible_at_ms = arg1;
        0x1::option::some<u64>(arg0.eligible_at_ms)
    }

    public fun expires_at_ms<T0>(arg0: &WithdrawalRequest<T0>) : 0x1::option::Option<u64> {
        arg0.expires_at_ms
    }

    public fun finalizer<T0>(arg0: &WithdrawalRequest<T0>) : 0x1::option::Option<address> {
        arg0.finalizer
    }

    public(friend) fun new<T0>(arg0: &mut 0x2::object::UID, arg1: 0x2::balance::Balance<T0>, arg2: address, arg3: u64, arg4: address, arg5: 0x1::option::Option<address>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock) : WithdrawalRequest<T0> {
        let v0 = 0x2::clock::timestamp_ms(arg8);
        let v1 = 0x1::u64::checked_add(v0, arg6);
        if (0x1::option::is_some<u64>(&v1)) {
            let v2 = 0x1::option::destroy_some<u64>(v1);
            let v3 = if (arg7 == 0) {
                0x1::option::none<u64>()
            } else {
                let v4 = 0x1::u64::checked_add(v2, arg7);
                if (0x1::option::is_some<u64>(&v4)) {
                    0x1::option::some<u64>(0x1::option::destroy_some<u64>(v4))
                } else {
                    0x1::option::destroy_none<u64>(v4);
                    abort 13835058351634907137
                }
            };
            let v5 = RequestKey{
                pos0 : arg2,
                pos1 : arg3,
            };
            return WithdrawalRequest<T0>{
                id              : 0x2::derived_object::claim<RequestKey>(arg0, v5),
                vault_id        : 0x2::object::uid_to_inner(arg0),
                owner           : arg2,
                request_id      : arg3,
                shares          : arg1,
                payout          : arg4,
                finalizer       : arg5,
                requested_at_ms : v0,
                eligible_at_ms  : v2,
                expires_at_ms   : v3,
            }
        } else {
            0x1::option::destroy_none<u64>(v1);
            abort 13835058325865103361
        };
    }

    public fun owner<T0>(arg0: &WithdrawalRequest<T0>) : address {
        arg0.owner
    }

    public fun payout<T0>(arg0: &WithdrawalRequest<T0>) : address {
        arg0.payout
    }

    public fun request_id<T0>(arg0: &WithdrawalRequest<T0>) : u64 {
        arg0.request_id
    }

    public fun requested_at_ms<T0>(arg0: &WithdrawalRequest<T0>) : u64 {
        arg0.requested_at_ms
    }

    public fun share<T0>(arg0: WithdrawalRequest<T0>) {
        0x2::transfer::share_object<WithdrawalRequest<T0>>(arg0);
    }

    public fun shares<T0>(arg0: &WithdrawalRequest<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.shares)
    }

    public fun vault_id<T0>(arg0: &WithdrawalRequest<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v7
}

