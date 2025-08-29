module 0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::bridge_manager {
    struct DepositEvent has copy, drop {
        sender: address,
        permit_signer: vector<u8>,
        amount: u64,
    }

    struct PermitEvent has copy, drop {
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

    public fun deposit<T0>(arg0: &mut 0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::treasury::Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::treasury::deposit_balance<T0>(arg0, v0);
        let v1 = DepositEvent{
            sender        : 0x2::tx_context::sender(arg3),
            permit_signer : arg2,
            amount        : 0x2::balance::value<T0>(&v0),
        };
        0x2::event::emit<DepositEvent>(v1);
    }

    public fun permit(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PermitEvent{
            sender        : 0x2::tx_context::sender(arg6),
            permit_signer : arg0,
            amount        : arg1,
            deadline      : arg2,
            v             : arg3,
            r             : arg4,
            s             : arg5,
        };
        0x2::event::emit<PermitEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::admin_cap::AdminCap, arg1: &mut 0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::treasury::Treasury<T0>, arg2: &mut 0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::tx_status::TxStatus, arg3: address, arg4: u64, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        if (0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::tx_status::get_status(arg2, arg5)) {
            abort 0
        };
        let v0 = WithdrawEvent{
            bridge_hash : arg5,
            recipient   : arg3,
            amount      : arg4,
        };
        0x2::event::emit<WithdrawEvent>(v0);
        0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::tx_status::set_status(arg0, arg2, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x6102c662c190253751ba4a17fdac0e4dbaa5e42cd6f00f12d0876bcc29e15220::treasury::withdraw_balance<T0>(arg1, arg4), arg6), arg3);
    }

    // decompiled from Move bytecode v6
}

