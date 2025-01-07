module 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::campaigns {
    struct PoolToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        community_id: address,
        total_token_distribute: 0x2::balance::Balance<T0>,
        creator: address,
    }

    struct Campaigns has store, key {
        id: 0x2::object::UID,
        community_id: address,
        name: 0x1::string::String,
        banner: 0x1::string::String,
        description: 0x1::string::String,
        snapshot_time: u64,
        start_time: u64,
        end_time: u64,
        list_mission: vector<0x1::string::String>,
        type: u8,
        num_winners: u64,
        num_token: u64,
        token_address: 0x1::string::String,
        num_nfts: u64,
        nft_address: 0x1::string::String,
        num_wl: u64,
        creator: address,
        status: u8,
        create_date: u64,
    }

    struct CampaignsCreatedEvent has copy, drop {
        campaigns_id: 0x2::object::ID,
    }

    public entry fun add_campaigns(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: vector<0x1::string::String>, arg9: u8, arg10: u64, arg11: u64, arg12: 0x1::string::String, arg13: u64, arg14: 0x1::string::String, arg15: u64, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaigns{
            id            : 0x2::object::new(arg16),
            community_id  : arg1,
            name          : 0x1::string::utf8(arg2),
            banner        : 0x1::string::utf8(arg3),
            description   : 0x1::string::utf8(arg4),
            snapshot_time : arg5,
            start_time    : arg6,
            end_time      : arg7,
            list_mission  : arg8,
            type          : arg9,
            num_winners   : arg10,
            num_token     : arg11,
            token_address : arg12,
            num_nfts      : arg13,
            nft_address   : arg14,
            num_wl        : arg15,
            creator       : 0x2::tx_context::sender(arg16),
            status        : 0,
            create_date   : 0x2::tx_context::epoch_timestamp_ms(arg16),
        };
        let v1 = CampaignsCreatedEvent{campaigns_id: 0x2::object::id<Campaigns>(&v0)};
        0x2::event::emit<CampaignsCreatedEvent>(v1);
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::update_total_campaigns(arg0);
        0x2::transfer::public_transfer<Campaigns>(v0, 0x2::tx_context::sender(arg16));
    }

    public entry fun add_mission_for_campaigns(arg0: &mut Campaigns, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.list_mission = arg1;
    }

    public entry fun add_wl_by_campaigns(arg0: &mut Campaigns, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun deposit_token<T0>(arg0: &mut 0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::Community, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x3f4b39cf61920bd0cd00d19a16907aec0099803434ee2df43dac236fc212500f::community::validate_owner_community(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = maybe_split_and_transfer_rest<T0>(arg2, arg3, v1, arg4);
        let v3 = PoolToken<T0>{
            id                     : 0x2::object::new(arg4),
            community_id           : arg1,
            total_token_distribute : 0x2::coin::into_balance<T0>(v2),
            creator                : v0,
        };
        0x2::transfer::share_object<PoolToken<T0>>(v3);
    }

    public entry fun lucky_drawn(arg0: &mut Campaigns, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public fun maybe_split_and_transfer_rest<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (0x2::coin::value<T0>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
        0x2::coin::split<T0>(&mut arg0, arg1, arg3)
    }

    public entry fun update_status_campaigns(arg0: &mut Campaigns, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 1);
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

