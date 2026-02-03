module 0xe2c31b248b3495b9c41e2ed6080b23ea9cfa1b0c615e2a5e4984548e2a316972::keys {
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

    struct VaultMetadataKey has copy, drop, store {
        dummy_field: bool,
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

    public(friend) fun vault_metadata_key() : VaultMetadataKey {
        VaultMetadataKey{dummy_field: false}
    }

    public(friend) fun withdraw_request(arg0: address) : WithdrawRequestKey {
        WithdrawRequestKey{sender: arg0}
    }

    // decompiled from Move bytecode v6
}

