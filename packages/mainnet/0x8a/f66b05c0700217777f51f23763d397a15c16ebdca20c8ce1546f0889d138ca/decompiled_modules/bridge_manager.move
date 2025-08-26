module 0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::bridge_manager {
    struct DepositEvent has copy, drop {
        sender: address,
        permit_signer: vector<u8>,
        amount: u64,
        deadline: u64,
        v: u64,
        r: vector<u8>,
        s: vector<u8>,
    }

    struct WithdrawEvent has copy, drop {
        bridge_hash: vector<u8>,
        recipient: address,
        amount: u64,
    }

    public fun deposit<T0>(arg0: &mut 0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::treasury::Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::treasury::deposit_balance<T0>(arg0, v0);
        let v1 = DepositEvent{
            sender        : 0x2::tx_context::sender(arg7),
            permit_signer : arg2,
            amount        : 0x2::balance::value<T0>(&v0),
            deadline      : arg3,
            v             : arg4,
            r             : arg5,
            s             : arg6,
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun withdraw<T0>(arg0: &0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::admin_cap::AdminCap, arg1: &mut 0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::treasury::Treasury<T0>, arg2: &mut 0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::tx_status::TxStatus, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::tx_status::get_status(arg2, arg5)) {
            abort 0
        };
        let v0 = WithdrawEvent{
            bridge_hash : arg5,
            recipient   : arg3,
            amount      : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::tx_status::set_status(arg0, arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x8af66b05c0700217777f51f23763d397a15c16ebdca20c8ce1546f0889d138ca::treasury::withdraw_balance<T0>(arg1, arg4), arg6), arg3);
    }

    // decompiled from Move bytecode v6
}

