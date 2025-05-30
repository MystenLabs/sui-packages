module 0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        max_payout: u64,
        min_payout: u64,
        time_to_reveal: u64,
        min_time_to_execute_proposal: u64,
        max_time_vesting: u64,
        admin: address,
        minted_nfts: 0x2::table::Table<0x2::object::ID, u64>,
        minted_nfts_by_walrus_hash: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        blacklisted_nfts: 0x2::table::Table<0x2::object::ID, bool>,
        finalized_proposals: 0x2::table::Table<0x2::object::ID, bool>,
        balance: 0x2::balance::Balance<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>,
    }

    public(friend) fun add_minted_nft(arg0: &mut Config, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) {
        0x2::table::add<0x2::object::ID, u64>(&mut arg0.minted_nfts, arg1, arg3);
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.minted_nfts_by_walrus_hash, arg2, arg1);
    }

    public fun contribute_to_balance(arg0: &mut Config, arg1: 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>) {
        0x2::coin::put<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.balance, arg1);
    }

    public fun emergency_remove_from_balance(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW> {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        0x2::coin::take<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.balance, arg1, arg2)
    }

    public(friend) fun finalize_proposal(arg0: &mut Config, arg1: 0x2::object::ID, arg2: bool, arg3: u64) {
        assert!(!is_finalized_proposal(arg0, arg1), 0);
        assert!(arg3 >= get_minted_nft_timestamp(arg0, arg1) + arg0.min_time_to_execute_proposal, 1);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.finalized_proposals, arg1, true);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.blacklisted_nfts, arg1, arg2);
    }

    public fun get_admin(arg0: &Config) : address {
        arg0.admin
    }

    public fun get_max_payout(arg0: &Config) : u64 {
        arg0.max_payout
    }

    public fun get_max_time_vesting(arg0: &Config) : u64 {
        arg0.max_time_vesting
    }

    public fun get_min_payout(arg0: &Config) : u64 {
        arg0.min_payout
    }

    public fun get_min_time_to_execute_proposal(arg0: &Config) : u64 {
        arg0.min_time_to_execute_proposal
    }

    public fun get_minted_nft_timestamp(arg0: &Config, arg1: 0x2::object::ID) : u64 {
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.minted_nfts, arg1)
    }

    public fun get_time_to_reveal(arg0: &Config) : u64 {
        arg0.time_to_reveal
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                           : 0x2::object::new(arg0),
            max_payout                   : 1000,
            min_payout                   : 0,
            time_to_reveal               : 100,
            min_time_to_execute_proposal : 100,
            max_time_vesting             : 525600,
            admin                        : 0x2::tx_context::sender(arg0),
            minted_nfts                  : 0x2::table::new<0x2::object::ID, u64>(arg0),
            minted_nfts_by_walrus_hash   : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg0),
            blacklisted_nfts             : 0x2::table::new<0x2::object::ID, bool>(arg0),
            finalized_proposals          : 0x2::table::new<0x2::object::ID, bool>(arg0),
            balance                      : 0x2::balance::zero<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(),
        };
        0x2::transfer::public_transfer<Config>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_blacklisted_nft(arg0: &Config, arg1: 0x2::object::ID) : bool {
        !0x2::table::contains<0x2::object::ID, bool>(&arg0.finalized_proposals, arg1) && false || *0x2::table::borrow<0x2::object::ID, bool>(&arg0.blacklisted_nfts, arg1) == true
    }

    public fun is_finalized_proposal(arg0: &Config, arg1: 0x2::object::ID) : bool {
        !0x2::table::contains<0x2::object::ID, bool>(&arg0.finalized_proposals, arg1) && false || true
    }

    public fun is_minted_nft(arg0: &Config, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, u64>(&arg0.minted_nfts, arg1)
    }

    public fun is_minted_nft_by_walrus_hash(arg0: &Config, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x2::object::ID>(&arg0.minted_nfts_by_walrus_hash, arg1)
    }

    public(friend) fun payout(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW> {
        0x2::coin::take<0xbb1b4898180e6e993db80f38bab825cede5a2bdb2b51a09b831381ba742eb752::www::WWW>(&mut arg0.balance, arg1, arg2)
    }

    public fun update_max_payout(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.min_payout <= arg1, 0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.max_payout = arg1;
    }

    public fun update_max_time_vesting(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.max_time_vesting = arg1;
    }

    public fun update_min_payout(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 <= arg0.max_payout, 0);
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 1);
        arg0.min_payout = arg1;
    }

    public fun update_min_time_to_execute_proposal(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.min_time_to_execute_proposal = arg1;
    }

    public fun update_time_to_reveal(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg2), 0);
        arg0.time_to_reveal = arg1;
    }

    // decompiled from Move bytecode v6
}

