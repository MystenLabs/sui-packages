module 0x9added62ef3a869653ef13e754d51fb62adc9f93e2717d2e23ba1214c4ef8d15::errors {
    public fun action_not_allowed() : u64 {
        1025
    }

    public fun already_claimed() : u64 {
        1008
    }

    public fun amount_can_not_be_zero() : u64 {
        1021
    }

    public fun bluefin_bank_mismatch() : u64 {
        1016
    }

    public fun claim_paused() : u64 {
        1004
    }

    public fun claiming_more_than_requested() : u64 {
        1013
    }

    public fun deposit_paused() : u64 {
        1002
    }

    public fun deprecated_method() : u64 {
        1026
    }

    public fun final_rewards_for_claim_not_set() : u64 {
        1028
    }

    public fun holding_account_mismatch() : u64 {
        1019
    }

    public fun insufficient_funds() : u64 {
        1005
    }

    public fun invalid_signature() : u64 {
        1009
    }

    public fun invalid_size() : u64 {
        1015
    }

    public fun invalid_vault_type() : u64 {
        1020
    }

    public fun no_rewards_for_user_to_claim() : u64 {
        1029
    }

    public fun not_valid_signer() : u64 {
        1011
    }

    public fun payload_type_do_not_match() : u64 {
        1006
    }

    public fun rewards_expired() : u64 {
        1027
    }

    public fun signature_expired() : u64 {
        1022
    }

    public fun target_address_do_not_match() : u64 {
        1012
    }

    public fun unauthorized() : u64 {
        1024
    }

    public fun unsupported_wallet_scheme() : u64 {
        1010
    }

    public fun user_doest_not_exist() : u64 {
        1023
    }

    public fun vault_max_cap_reached() : u64 {
        1017
    }

    public fun version_mismatch() : u64 {
        1001
    }

    public fun withdraw_paused() : u64 {
        1003
    }

    public fun zero_address() : u64 {
        1007
    }

    // decompiled from Move bytecode v6
}

