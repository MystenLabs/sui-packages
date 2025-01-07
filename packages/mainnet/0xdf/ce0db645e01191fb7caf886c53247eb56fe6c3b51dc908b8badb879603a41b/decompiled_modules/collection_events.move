module 0xe8e44efa7d34c6abd845c368a7998ae01feb4378019135adf8f143aa77111530::collection_events {
    struct CollectionSupportScheduledForRemoval has copy, drop {
        nft_id: 0x2::object::ID,
        supporter: address,
    }

    struct AccountBalanceWithdrawn has copy, drop {
        account: address,
        amount: u64,
    }

    struct CollectionElectionEnded has copy, drop {
        elected_nft_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        creator: address,
        total_support: u64,
        supporter_count: u64,
        index: u64,
        timestamp_ms: u64,
    }

    struct CollectionEntrySubmitted has copy, drop {
        nft_id: 0x2::object::ID,
        creator: address,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        index: u64,
        maintainer_balance_change: u64,
        timestamp_ms: u64,
    }

    struct CollectionEntryRemoved has copy, drop {
        nft_id: 0x2::object::ID,
    }

    struct CollectionEntrySupported has copy, drop {
        nft_id: 0x2::object::ID,
        image_url: 0x2::url::Url,
        title: 0x1::string::String,
        supporter: address,
        support_amount: u64,
        index: u64,
        maintainer_balance_change: u64,
        timestamp_ms: u64,
    }

    struct CollectionEntrySupportRemoved has copy, drop {
        nft_id: 0x2::object::ID,
        supporter: address,
        support_amount: u64,
    }

    public(friend) fun emit_account_balance_withdrawn(arg0: address, arg1: u64) {
        let v0 = AccountBalanceWithdrawn{
            account : arg0,
            amount  : arg1,
        };
        0x2::event::emit<AccountBalanceWithdrawn>(v0);
    }

    public(friend) fun emit_collection_election_ended(arg0: 0x2::object::ID, arg1: 0x2::url::Url, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = CollectionElectionEnded{
            elected_nft_id  : arg0,
            image_url       : arg1,
            title           : arg2,
            creator         : arg3,
            total_support   : arg4,
            supporter_count : arg5,
            index           : arg6,
            timestamp_ms    : arg7,
        };
        0x2::event::emit<CollectionElectionEnded>(v0);
    }

    public(friend) fun emit_collection_entry_removed(arg0: 0x2::object::ID) {
        let v0 = CollectionEntryRemoved{nft_id: arg0};
        0x2::event::emit<CollectionEntryRemoved>(v0);
    }

    public(friend) fun emit_collection_entry_submitted(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::url::Url, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = CollectionEntrySubmitted{
            nft_id                    : arg0,
            creator                   : arg1,
            image_url                 : arg2,
            title                     : arg3,
            index                     : arg4,
            maintainer_balance_change : arg5,
            timestamp_ms              : arg6,
        };
        0x2::event::emit<CollectionEntrySubmitted>(v0);
    }

    public(friend) fun emit_collection_entry_support_removed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = CollectionEntrySupportRemoved{
            nft_id         : arg0,
            supporter      : arg1,
            support_amount : arg2,
        };
        0x2::event::emit<CollectionEntrySupportRemoved>(v0);
    }

    public(friend) fun emit_collection_entry_supported(arg0: 0x2::object::ID, arg1: 0x2::url::Url, arg2: 0x1::string::String, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = CollectionEntrySupported{
            nft_id                    : arg0,
            image_url                 : arg1,
            title                     : arg2,
            supporter                 : arg3,
            support_amount            : arg4,
            index                     : arg5,
            maintainer_balance_change : arg6,
            timestamp_ms              : arg7,
        };
        0x2::event::emit<CollectionEntrySupported>(v0);
    }

    public(friend) fun emit_collection_support_scheduled_for_removal(arg0: 0x2::object::ID, arg1: address) {
        let v0 = CollectionSupportScheduledForRemoval{
            nft_id    : arg0,
            supporter : arg1,
        };
        0x2::event::emit<CollectionSupportScheduledForRemoval>(v0);
    }

    // decompiled from Move bytecode v6
}

