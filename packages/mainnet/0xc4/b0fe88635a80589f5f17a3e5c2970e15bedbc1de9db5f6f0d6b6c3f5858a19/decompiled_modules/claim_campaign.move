module 0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::claim_campaign {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ClaimCampaign has key {
        id: 0x2::object::UID,
        label: 0x1::string::String,
        merkle_root: vector<u8>,
        amount_per_claim: u64,
        expires_at_epoch: u64,
        pool: 0x2::balance::Balance<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>,
        claimed: 0x2::table::Table<address, bool>,
        is_active: bool,
        is_closed: bool,
    }

    struct CampaignCreated has copy, drop {
        campaign_id: 0x2::object::ID,
        amount_per_claim: u64,
        expires_at_epoch: u64,
    }

    struct CampaignFunded has copy, drop {
        campaign_id: 0x2::object::ID,
        added_amount: u64,
        pool_total: u64,
    }

    struct CampaignActivated has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct MerkleRootUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct Claimed has copy, drop {
        campaign_id: 0x2::object::ID,
        claimer: address,
        amount: u64,
    }

    struct CampaignPaused has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct CampaignUnpaused has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    struct CampaignClosed has copy, drop {
        campaign_id: 0x2::object::ID,
        returned_to_admin: u64,
    }

    struct AdminCapDestroyed has copy, drop {
        dummy_field: bool,
    }

    struct AdminCapTransferred has copy, drop {
        new_owner: address,
    }

    public entry fun activate(arg0: &mut ClaimCampaign, arg1: &AdminCap) {
        arg0.is_active = true;
        let v0 = CampaignActivated{campaign_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<CampaignActivated>(v0);
    }

    public entry fun claim(arg0: &mut ClaimCampaign, arg1: vector<vector<u8>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.is_active, 1);
        if (arg0.expires_at_epoch > 0) {
            assert!(0x2::tx_context::epoch(arg2) <= arg0.expires_at_epoch, 2);
        };
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, bool>(&arg0.claimed, v0), 3);
        assert!(0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::merkle::verify_proof(&arg1, &arg0.merkle_root, 0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::merkle::compute_leaf(v0, arg0.amount_per_claim)), 4);
        assert!(0x2::balance::value<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&arg0.pool) >= arg0.amount_per_claim, 5);
        0x2::table::add<address, bool>(&mut arg0.claimed, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>>(0x2::coin::from_balance<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(0x2::balance::split<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&mut arg0.pool, arg0.amount_per_claim), arg2), v0);
        let v1 = Claimed{
            campaign_id : 0x2::object::uid_to_inner(&arg0.id),
            claimer     : v0,
            amount      : arg0.amount_per_claim,
        };
        0x2::event::emit<Claimed>(v1);
    }

    public entry fun close_campaign(arg0: &mut ClaimCampaign, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.is_active = false;
        arg0.is_closed = true;
        let v0 = 0x2::balance::value<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&arg0.pool);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>>(0x2::coin::from_balance<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(0x2::balance::split<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&mut arg0.pool, v0), arg2), 0x2::tx_context::sender(arg2));
        };
        let v1 = CampaignClosed{
            campaign_id       : 0x2::object::uid_to_inner(&arg0.id),
            returned_to_admin : v0,
        };
        0x2::event::emit<CampaignClosed>(v1);
    }

    public fun create_campaign(arg0: 0x1::string::String, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = 0x2::object::new(arg4);
        let v1 = ClaimCampaign{
            id               : v0,
            label            : arg0,
            merkle_root      : arg1,
            amount_per_claim : arg2,
            expires_at_epoch : arg3,
            pool             : 0x2::balance::zero<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(),
            claimed          : 0x2::table::new<address, bool>(arg4),
            is_active        : false,
            is_closed        : false,
        };
        0x2::transfer::share_object<ClaimCampaign>(v1);
        let v2 = CampaignCreated{
            campaign_id      : 0x2::object::uid_to_inner(&v0),
            amount_per_claim : arg2,
            expires_at_epoch : arg3,
        };
        0x2::event::emit<CampaignCreated>(v2);
        AdminCap{id: 0x2::object::new(arg4)}
    }

    public entry fun create_campaign_entry(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = create_campaign(0x1::string::utf8(arg0), arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun destroy_admin_cap(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let v1 = AdminCapDestroyed{dummy_field: false};
        0x2::event::emit<AdminCapDestroyed>(v1);
    }

    public entry fun fund_campaign(arg0: &mut ClaimCampaign, arg1: 0x2::coin::Coin<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>, arg2: &AdminCap) {
        0x2::balance::join<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&mut arg0.pool, 0x2::coin::into_balance<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(arg1));
        let v0 = CampaignFunded{
            campaign_id  : 0x2::object::uid_to_inner(&arg0.id),
            added_amount : 0x2::coin::value<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&arg1),
            pool_total   : 0x2::balance::value<0xc4b0fe88635a80589f5f17a3e5c2970e15bedbc1de9db5f6f0d6b6c3f5858a19::axiom_mainnet_claim::AXIOM_MAINNET_CLAIM>(&arg0.pool),
        };
        0x2::event::emit<CampaignFunded>(v0);
    }

    public entry fun pause(arg0: &mut ClaimCampaign, arg1: &AdminCap) {
        arg0.is_active = false;
        let v0 = CampaignPaused{campaign_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<CampaignPaused>(v0);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        let v0 = AdminCapTransferred{new_owner: arg1};
        0x2::event::emit<AdminCapTransferred>(v0);
        0x2::transfer::public_transfer<AdminCap>(arg0, arg1);
    }

    public entry fun unpause(arg0: &mut ClaimCampaign, arg1: &AdminCap) {
        assert!(!arg0.is_closed, 8);
        arg0.is_active = true;
        let v0 = CampaignUnpaused{campaign_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<CampaignUnpaused>(v0);
    }

    public entry fun update_merkle_root(arg0: &mut ClaimCampaign, arg1: vector<u8>, arg2: &AdminCap) {
        assert!(!arg0.is_active, 6);
        arg0.merkle_root = arg1;
        let v0 = MerkleRootUpdated{campaign_id: 0x2::object::uid_to_inner(&arg0.id)};
        0x2::event::emit<MerkleRootUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

