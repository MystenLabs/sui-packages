module 0xbb85532797b81e0184d433cf4551623dc479b80b71bf558451b23d13f5cbaf04::keys {
    struct AccountCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerLockedLpCoinKey has copy, drop, store {
        dummy_field: bool,
    }

    struct OwnerFeesKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ActiveAssistantCountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultRecordKey has copy, drop, store {
        vault_id: 0x2::object::ID,
    }

    struct UserLpCoinRecordKey has copy, drop, store {
        user_lp_coin_id: 0x2::object::ID,
    }

    struct WithdrawRequestKey has copy, drop, store {
        sender: address,
    }

    struct VaultMetadataKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FrozenVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun account_cap_key() : AccountCapKey {
        AccountCapKey{dummy_field: false}
    }

    public(friend) fun active_assistant_count_key() : ActiveAssistantCountKey {
        ActiveAssistantCountKey{dummy_field: false}
    }

    public(friend) fun frozen_version_key() : FrozenVersionKey {
        FrozenVersionKey{dummy_field: false}
    }

    public(friend) fun owner_fees_key() : OwnerFeesKey {
        OwnerFeesKey{dummy_field: false}
    }

    public(friend) fun owner_user_lp_coin_key() : OwnerLockedLpCoinKey {
        OwnerLockedLpCoinKey{dummy_field: false}
    }

    public(friend) fun user_lp_coin_record_key(arg0: 0x2::object::ID) : UserLpCoinRecordKey {
        UserLpCoinRecordKey{user_lp_coin_id: arg0}
    }

    public(friend) fun vault_metadata_key() : VaultMetadataKey {
        VaultMetadataKey{dummy_field: false}
    }

    public(friend) fun vault_record_key(arg0: 0x2::object::ID) : VaultRecordKey {
        VaultRecordKey{vault_id: arg0}
    }

    public(friend) fun withdraw_request(arg0: address) : WithdrawRequestKey {
        WithdrawRequestKey{sender: arg0}
    }

    // decompiled from Move bytecode v7
}

