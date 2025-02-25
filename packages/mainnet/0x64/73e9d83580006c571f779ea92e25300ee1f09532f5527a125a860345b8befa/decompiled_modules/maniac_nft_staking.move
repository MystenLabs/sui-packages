module 0x6473e9d83580006c571f779ea92e25300ee1f09532f5527a125a860345b8befa::maniac_nft_staking {
    struct MANIAC_NFT_STAKING has drop {
        dummy_field: bool,
    }

    struct StakingAdmin has store, key {
        id: 0x2::object::UID,
    }

    struct StakingControl has store, key {
        id: 0x2::object::UID,
        empty_transfer_policy: 0x2::transfer_policy::TransferPolicy<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>,
        empty_transfer_policy_cap: 0x2::transfer_policy::TransferPolicyCap<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>,
        unstake_time: u64,
    }

    struct ManiacNftStaked has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        nft: 0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft,
        staked_at: u64,
    }

    struct NftStaked has copy, drop {
        nft_id: 0x2::object::ID,
        staked_by: address,
        staked_at: u64,
    }

    fun init(arg0: MANIAC_NFT_STAKING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = StakingAdmin{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<StakingAdmin>(v1, v0);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://coinfever.app"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"CoinFever"));
        let v6 = 0x2::package::claim<MANIAC_NFT_STAKING>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<ManiacNftStaked>(&v6, v2, v4, arg1);
        0x2::display::update_version<ManiacNftStaked>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, v0);
        0x2::transfer::public_transfer<0x2::display::Display<ManiacNftStaked>>(v7, v0);
    }

    entry fun init_staking_control(arg0: &StakingAdmin, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>(arg1, arg2);
        let v2 = StakingControl{
            id                        : 0x2::object::new(arg2),
            empty_transfer_policy     : v0,
            empty_transfer_policy_cap : v1,
            unstake_time              : 1,
        };
        0x2::transfer::share_object<StakingControl>(v2);
    }

    entry fun set_unstake_time(arg0: &StakingAdmin, arg1: &mut StakingControl, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        arg1.unstake_time = arg2;
    }

    entry fun stake(arg0: &StakingControl, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::kiosk::list<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>(arg1, arg2, arg3, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>(arg1, arg3, 0x2::coin::zero<0x2::sui::SUI>(arg5));
        let v2 = v0;
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>(&arg0.empty_transfer_policy, v1);
        let v6 = 0x1::string::utf8(b"Staked ");
        0x1::string::append(&mut v6, *0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::name(&v2));
        let v7 = b"https://metadata.coinfever.app/api/image/?staked=true&id=";
        let v8 = 0x2::address::to_string(0x2::object::id_to_address(&arg3));
        0x1::vector::append<u8>(&mut v7, *0x1::string::as_bytes(&v8));
        let v9 = 0x2::tx_context::sender(arg5);
        let v10 = 0x2::clock::timestamp_ms(arg4);
        let v11 = ManiacNftStaked{
            id        : 0x2::object::new(arg5),
            name      : v6,
            image_url : 0x1::string::utf8(v7),
            nft       : v2,
            staked_at : v10,
        };
        0x2::transfer::transfer<ManiacNftStaked>(v11, v9);
        let v12 = NftStaked{
            nft_id    : arg3,
            staked_by : v9,
            staked_at : v10,
        };
        0x2::event::emit<NftStaked>(v12);
    }

    entry fun unstake(arg0: &StakingControl, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>, arg4: &0x2::clock::Clock, arg5: ManiacNftStaked) {
        assert!(0x2::clock::timestamp_ms(arg4) >= arg0.unstake_time, 0);
        let ManiacNftStaked {
            id        : v0,
            name      : _,
            image_url : _,
            nft       : v3,
            staked_at : _,
        } = arg5;
        0x2::kiosk::lock<0x28bb239a115e60925353a635c5c7e1d85a4e7435d5da3e7afafec5b417059c8d::maniac_nfts::ManiacNft>(arg1, arg2, arg3, v3);
        0x2::object::delete(v0);
    }

    // decompiled from Move bytecode v6
}

