module 0xfe019c8a95959f64140c81ad40f208039f83574b5e3a50efb96dad7c4047bffb::campaigns {
    struct PoolToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        total_token_distribute: 0x2::balance::Balance<T0>,
        creator: address,
    }

    struct Campaigns has store, key {
        id: 0x2::object::UID,
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

    public entry fun add_campaigns(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: u64, arg6: vector<0x1::string::String>, arg7: u8, arg8: u64, arg9: u64, arg10: 0x1::string::String, arg11: u64, arg12: 0x1::string::String, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = Campaigns{
            id            : 0x2::object::new(arg14),
            name          : 0x1::string::utf8(arg0),
            banner        : 0x1::string::utf8(arg1),
            description   : 0x1::string::utf8(arg2),
            snapshot_time : arg3,
            start_time    : arg4,
            end_time      : arg5,
            list_mission  : arg6,
            type          : arg7,
            num_winners   : arg8,
            num_token     : arg9,
            token_address : arg10,
            num_nfts      : arg11,
            nft_address   : arg12,
            num_wl        : arg13,
            creator       : 0x2::tx_context::sender(arg14),
            status        : 0,
            create_date   : 0x2::tx_context::epoch_timestamp_ms(arg14),
        };
        let v1 = CampaignsCreatedEvent{campaigns_id: 0x2::object::id<Campaigns>(&v0)};
        0x2::event::emit<CampaignsCreatedEvent>(v1);
        0x2::transfer::share_object<Campaigns>(v0);
    }

    public entry fun add_mission_for_campaigns(arg0: &mut Campaigns, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.list_mission = arg1;
    }

    public entry fun add_wl_by_campaigns(arg0: &mut Campaigns, arg1: vector<0x1::string::String>, arg2: &mut 0x2::tx_context::TxContext) {
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

