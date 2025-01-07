module 0xa9c1a62fcf73b95fce42bdf6985f41a688a31782b8c7ef9b3863a16faedcb92d::superfine_airdrop {
    struct AirdropPlatform has key {
        id: 0x2::object::UID,
        admin: address,
        operators: 0x2::vec_set::VecSet<address>,
        airdrop_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        campaign_ids: 0x2::vec_set::VecSet<vector<u8>>,
    }

    struct AirdropCampaign has store, key {
        id: 0x2::object::UID,
        campaign_id: vector<u8>,
        creator: address,
        num_assets: u64,
        charged_fee: u64,
        airdrop_started: bool,
        asset_count: u64,
    }

    struct EventCampaignCreated has copy, drop {
        id: 0x2::object::ID,
        campaign_id: vector<u8>,
        asset_ids: vector<0x2::object::ID>,
    }

    struct EventCampaignUpdated has copy, drop {
        campaign_id: 0x2::object::ID,
    }

    public entry fun airdrop_asset<T0: store + key>(arg0: &mut AirdropPlatform, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, AirdropCampaign>(&mut arg0.id, arg1);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v1), 135289670004);
        if (!v0.airdrop_started) {
            v0.airdrop_started = true;
        };
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v0.id, arg2), arg3);
    }

    public entry fun create_airdrop_campaign<T0: store + key>(arg0: &mut AirdropPlatform, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: vector<T0>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = pubkey_to_address(arg5);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v0), 135289670004);
        let v1 = 0x2::tx_context::sender(arg8);
        0x1::vector::append<u8>(&mut arg1, 0x1::bcs::to_bytes<address>(&v1));
        0x1::vector::append<u8>(&mut arg1, u64_to_bytes(arg2));
        0x1::vector::append<u8>(&mut arg1, u64_to_bytes(arg3));
        0x1::vector::append<u8>(&mut arg1, arg5);
        let v2 = 0x2::hash::blake2b256(&arg1);
        assert!(0x2::ed25519::ed25519_verify(&arg6, &arg5, &v2), 135289670002);
        assert!(!0x2::vec_set::contains<vector<u8>>(&arg0.campaign_ids, &arg1), 135289670005);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.airdrop_fee, 0x2::coin::split<0x2::sui::SUI>(arg7, arg3, arg8));
        let v3 = AirdropCampaign{
            id              : 0x2::object::new(arg8),
            campaign_id     : arg1,
            creator         : 0x2::tx_context::sender(arg8),
            num_assets      : arg2,
            charged_fee     : arg3,
            airdrop_started : false,
            asset_count     : 0,
        };
        0x2::vec_set::insert<vector<u8>>(&mut arg0.campaign_ids, arg1);
        let v4 = 0x2::object::id<AirdropCampaign>(&v3);
        0x2::dynamic_object_field::add<0x2::object::ID, AirdropCampaign>(&mut arg0.id, v4, v3);
        let v5 = EventCampaignCreated{
            id          : v4,
            campaign_id : arg1,
            asset_ids   : list_assets<T0>(arg0, v4, arg4, arg8),
        };
        0x2::event::emit<EventCampaignCreated>(v5);
        v4
    }

    public entry fun delist_asset<T0: store + key>(arg0: &mut AirdropPlatform, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, AirdropCampaign>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.creator, 135289670001);
        assert!(!v0.airdrop_started, 135289670000);
        v0.asset_count = v0.asset_count - 1;
        0x2::transfer::public_transfer<T0>(0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut v0.id, arg2), 0x2::tx_context::sender(arg3));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AirdropPlatform{
            id           : 0x2::object::new(arg0),
            admin        : 0x2::tx_context::sender(arg0),
            operators    : 0x2::vec_set::empty<address>(),
            airdrop_fee  : 0x2::balance::zero<0x2::sui::SUI>(),
            campaign_ids : 0x2::vec_set::empty<vector<u8>>(),
        };
        0x2::transfer::share_object<AirdropPlatform>(v0);
    }

    public entry fun list_assets<T0: store + key>(arg0: &mut AirdropPlatform, arg1: 0x2::object::ID, arg2: vector<T0>, arg3: &mut 0x2::tx_context::TxContext) : vector<0x2::object::ID> {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, AirdropCampaign>(&mut arg0.id, arg1);
        assert!(0x2::tx_context::sender(arg3) == v0.creator, 135289670001);
        assert!(!v0.airdrop_started, 135289670000);
        let v1 = v0.asset_count + 0x1::vector::length<T0>(&arg2);
        assert!(v1 <= v0.num_assets, 135289670006);
        v0.asset_count = v1;
        let v2 = 0x1::vector::empty<0x2::object::ID>();
        while (0x1::vector::length<T0>(&arg2) > 0) {
            let v3 = 0x1::vector::pop_back<T0>(&mut arg2);
            let v4 = 0x2::object::id<T0>(&v3);
            0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut v0.id, v4, v3);
            0x1::vector::push_back<0x2::object::ID>(&mut v2, v4);
        };
        0x1::vector::destroy_empty<T0>(arg2);
        v2
    }

    fun pubkey_to_address(arg0: vector<u8>) : address {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, 0);
        0x1::vector::append<u8>(v1, arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(v1))
    }

    public entry fun set_operator(arg0: &mut AirdropPlatform, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 135289670003);
        if (arg2) {
            if (!0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
                0x2::vec_set::insert<address>(&mut arg0.operators, arg1);
            };
        } else if (0x2::vec_set::contains<address>(&arg0.operators, &arg1)) {
            0x2::vec_set::remove<address>(&mut arg0.operators, &arg1);
        };
    }

    fun u64_to_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 8) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 - (arg0 >> 8 << 8)) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun update_campaign(arg0: &mut AirdropPlatform, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0x2::object::ID, AirdropCampaign>(&mut arg0.id, arg1);
        let v1 = pubkey_to_address(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.operators, &v1), 135289670004);
        let v2 = v0.campaign_id;
        let v3 = 0x2::tx_context::sender(arg7);
        0x1::vector::append<u8>(&mut v2, 0x1::bcs::to_bytes<address>(&v3));
        0x1::vector::append<u8>(&mut v2, u64_to_bytes(arg2));
        0x1::vector::append<u8>(&mut v2, u64_to_bytes(arg3));
        0x1::vector::append<u8>(&mut v2, arg4);
        let v4 = 0x2::hash::blake2b256(&v2);
        assert!(0x2::ed25519::ed25519_verify(&arg5, &arg4, &v4), 135289670002);
        assert!(!v0.airdrop_started, 135289670000);
        assert!(arg2 >= v0.asset_count, 135289670007);
        assert!(0x2::tx_context::sender(arg7) == v0.creator, 135289670001);
        if (arg3 > v0.charged_fee) {
            0x2::coin::put<0x2::sui::SUI>(&mut arg0.airdrop_fee, 0x2::coin::split<0x2::sui::SUI>(arg6, arg3 - v0.charged_fee, arg7));
        };
        v0.num_assets = arg2;
        if (arg3 > v0.charged_fee) {
            v0.charged_fee = arg3;
        };
        let v5 = 0x2::object::id<AirdropCampaign>(v0);
        let v6 = EventCampaignUpdated{campaign_id: v5};
        0x2::event::emit<EventCampaignUpdated>(v6);
        v5
    }

    public entry fun withdraw_airdropping_fee(arg0: &mut AirdropPlatform, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 135289670003);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.airdrop_fee, 0x2::balance::value<0x2::sui::SUI>(&arg0.airdrop_fee), arg2), arg1);
    }

    // decompiled from Move bytecode v6
}

