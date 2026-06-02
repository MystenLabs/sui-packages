module 0x7c28438735d3314fe1c48ce74e3131eb2025fa21694bd1c58b0fd12753974c2f::events {
    struct NFTWithdrawal has copy, drop, store {
        amount: u64,
        nft_id: 0x2::object::ID,
    }

    struct AdminWithdrawal has copy, drop, store {
        amount: u64,
    }

    public(friend) fun emit_admin_withdrawal(arg0: u64) {
        let v0 = AdminWithdrawal{amount: arg0};
        0x2::event::emit<AdminWithdrawal>(v0);
    }

    public(friend) fun emit_nft_withdrawal(arg0: u64, arg1: 0x2::object::ID) {
        let v0 = NFTWithdrawal{
            amount : arg0,
            nft_id : arg1,
        };
        0x2::event::emit<NFTWithdrawal>(v0);
    }

    // decompiled from Move bytecode v6
}

