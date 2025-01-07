module 0x23f43c4c84788a2acba2aba37610704197821b568e2c3f0a87fe024231bcd3d3::option_airdrop {
    struct OPTION_AIRDROP has drop {
        dummy_field: bool,
    }

    struct VERSION has drop {
        dummy_field: bool,
    }

    struct Snapshot has key {
        id: 0x2::object::UID,
        users: vector<address>,
        shares: vector<u64>,
        total_share: u64,
    }

    struct AirdropPlan has store {
        vault_index: u64,
        airdrops: vector<Airdrop>,
    }

    struct Airdrop has store {
        users: vector<address>,
        sizes: vector<u64>,
    }

    struct AddAirdropPlanEvent has copy, drop {
        vault_index: u64,
        auction_max_size: u64,
        round: u64,
    }

    entry fun add_airdrop_plan(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Snapshot, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg6);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(!0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"airdrop_plan")), 0);
        let v1 = AddAirdropPlanEvent{
            vault_index      : arg2,
            auction_max_size : arg3,
            round            : arg4,
        };
        0x2::event::emit<AddAirdropPlanEvent>(v1);
        let v2 = AirdropPlan{
            vault_index : arg2,
            airdrops    : 0x1::vector::empty<Airdrop>(),
        };
        let v3 = 0;
        let v4 = arg1.total_share;
        let v5 = vector[];
        let v6 = vector[];
        let v7 = &arg1.users;
        let v8 = &arg1.shares;
        let v9 = 0x1::vector::length<address>(v7);
        assert!(v9 == 0x1::vector::length<u64>(v8), 9223372595200524287);
        let v10 = 0;
        while (v10 < v9) {
            let v11 = 0x1::vector::borrow<u64>(v8, v10);
            if (v3 == arg5) {
                let v12 = Airdrop{
                    users : v5,
                    sizes : v6,
                };
                0x1::vector::push_back<Airdrop>(&mut v2.airdrops, v12);
                v5 = vector[];
                v6 = vector[];
                v3 = 0;
            };
            let v13 = (((arg3 as u128) * (*v11 as u128) / (v4 as u128)) as u64);
            0x1::vector::push_back<address>(&mut v5, *0x1::vector::borrow<address>(v7, v10));
            0x1::vector::push_back<u64>(&mut v6, v13);
            v4 = v4 - *v11;
            arg3 = arg3 - v13;
            v3 = v3 + 1;
            v10 = v10 + 1;
        };
        let v14 = Airdrop{
            users : v5,
            sizes : v6,
        };
        0x1::vector::push_back<Airdrop>(&mut v2.airdrops, v14);
        0x2::dynamic_field::add<0x1::string::String, AirdropPlan>(&mut arg1.id, 0x1::string::utf8(b"airdrop_plan"), v2);
    }

    entry fun add_user_share(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Snapshot, arg2: vector<address>, arg3: vector<u64>, arg4: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 9223372350387388415);
        while (0x1::vector::length<address>(&arg2) != 0) {
            let v1 = 0x1::vector::pop_back<u64>(&mut arg3);
            0x1::vector::push_back<address>(&mut arg1.users, 0x1::vector::pop_back<address>(&mut arg2));
            0x1::vector::push_back<u64>(&mut arg1.shares, v1);
            arg1.total_share = arg1.total_share + v1;
        };
        0x1::vector::destroy_empty<address>(arg2);
    }

    entry fun airdrop_otc(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Snapshot, arg2: &mut 0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::typus_dov_single::Registry, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg4);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"airdrop_plan")), 0);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::string::String, AirdropPlan>(&mut arg1.id, 0x1::string::utf8(b"airdrop_plan"));
        let Airdrop {
            users : v2,
            sizes : v3,
        } = 0x1::vector::pop_back<Airdrop>(&mut v1.airdrops);
        0x321848bf1ae327a9e022ccb3701940191e02fa193ab160d9c0e49cd3c003de3a::tds_authorized_entry::airdrop_otc<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS, 0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(arg2, v1.vault_index, 0, 0x2::balance::zero<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(), 0x2::balance::zero<0xf82dc05634970553615eef6112a1ac4fb7bf10272bf6cbe0f80ef44a6c489385::typus::TYPUS>(), v2, v3, arg3, arg4);
        if (0x1::vector::length<Airdrop>(&v1.airdrops) == 0) {
            let AirdropPlan {
                vault_index : _,
                airdrops    : v5,
            } = 0x2::dynamic_field::remove<0x1::string::String, AirdropPlan>(&mut arg1.id, 0x1::string::utf8(b"airdrop_plan"));
            0x1::vector::destroy_empty<Airdrop>(v5);
        };
    }

    fun init(arg0: OPTION_AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::issue_version<OPTION_AIRDROP, VERSION>(&arg0, v0, arg1);
        let v1 = Snapshot{
            id          : 0x2::object::new(arg1),
            users       : vector[],
            shares      : vector[],
            total_share : 0,
        };
        0x2::transfer::share_object<Snapshot>(v1);
    }

    entry fun remove_airdrop_plan(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Snapshot, arg2: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg2);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        assert!(0x2::dynamic_field::exists_<0x1::string::String>(&arg1.id, 0x1::string::utf8(b"airdrop_plan")), 0);
        let AirdropPlan {
            vault_index : _,
            airdrops    : v2,
        } = 0x2::dynamic_field::remove<0x1::string::String, AirdropPlan>(&mut arg1.id, 0x1::string::utf8(b"airdrop_plan"));
        let v3 = v2;
        while (0x1::vector::length<Airdrop>(&v3) != 0) {
            let Airdrop {
                users : _,
                sizes : _,
            } = 0x1::vector::pop_back<Airdrop>(&mut v3);
        };
        0x1::vector::destroy_empty<Airdrop>(v3);
    }

    entry fun remove_user_share(arg0: &0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::Version, arg1: &mut Snapshot, arg2: &0x2::tx_context::TxContext) {
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_authority(arg0, arg2);
        let v0 = VERSION{dummy_field: false};
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_witness<VERSION>(arg0, v0);
        0xb44f547f5f9e35513a35139a8f2381923ea3f861e6d8debcd5aaf077f2d3a39d::version::verify_version(arg0, 1);
        arg1.users = vector[];
        arg1.shares = vector[];
        arg1.total_share = 0;
    }

    // decompiled from Move bytecode v6
}

