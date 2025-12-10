module 0x800b67150f6ec9ef4349355089febb60dc5f08989ebc2c91a8974e3219c2724f::keys {
    struct AccountCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerLockedLpCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerFeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WithdrawRequestKey has copy, drop, store {
        sender: address,
    }

    struct StopOrderTicketKey has copy, drop, store {
        id: 0x2::object::ID,
    }

    public(friend) fun account_cap_key() : AccountCapKey {
        AccountCapKey{dummy_field: false}
    }

    public(friend) fun owner_fees_key() : OwnerFeesKey {
        OwnerFeesKey{dummy_field: false}
    }

    public(friend) fun owner_user_lp_coin_key() : OwnerLockedLpCoinKey {
        OwnerLockedLpCoinKey{dummy_field: false}
    }

    public(friend) fun stop_order_ticket(arg0: 0x2::object::ID) : StopOrderTicketKey {
        StopOrderTicketKey{id: arg0}
    }

    public(friend) fun withdraw_request(arg0: address) : WithdrawRequestKey {
        WithdrawRequestKey{sender: arg0}
    }

    // decompiled from Move bytecode v6
}

