module 0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::campaigns {
    struct PoolToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
        total_token_distribute: 0x2::balance::Balance<T0>,
        creator: address,
    }

    struct Campaigns has store, key {
        id: 0x2::object::UID,
        community_id: 0x2::object::ID,
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

    public entry fun add_campaigns(arg0: &mut 0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::community::Community, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: vector<0x1::string::String>, arg8: u8, arg9: u64, arg10: u64, arg11: 0x1::string::String, arg12: u64, arg13: 0x1::string::String, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaigns{
            id            : 0x2::object::new(arg15),
            community_id  : 0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::community::get_id(arg0),
            name          : 0x1::string::utf8(arg1),
            banner        : 0x1::string::utf8(arg2),
            description   : 0x1::string::utf8(arg3),
            snapshot_time : arg4,
            start_time    : arg5,
            end_time      : arg6,
            list_mission  : arg7,
            type          : arg8,
            num_winners   : arg9,
            num_token     : arg10,
            token_address : arg11,
            num_nfts      : arg12,
            nft_address   : arg13,
            num_wl        : arg14,
            creator       : 0x2::tx_context::sender(arg15),
            status        : 0,
            create_date   : 0x2::tx_context::epoch_timestamp_ms(arg15),
        };
        let v1 = CampaignsCreatedEvent{campaigns_id: 0x2::object::id<Campaigns>(&v0)};
        0x2::event::emit<CampaignsCreatedEvent>(v1);
        0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::community::update_total_campaigns(arg0);
        0x2::transfer::share_object<Campaigns>(v0);
    }

    public entry fun add_mission_for_campaigns(arg0: &mut Campaigns, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.list_mission = arg1;
    }

    public entry fun add_wl_by_campaigns(arg0: &mut Campaigns, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun deposit_token<T0>(arg0: &mut 0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::community::Community, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::community::validate_owner_community(arg0, arg3);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = maybe_split_and_transfer_rest<T0>(arg1, arg2, v1, arg3);
        let v3 = PoolToken<T0>{
            id                     : 0x2::object::new(arg3),
            community_id           : 0x465023558fee3d81c034ffd5e07d0baaf2257cd1e8b231c68e0c9ac170ed10fa::community::get_id(arg0),
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

