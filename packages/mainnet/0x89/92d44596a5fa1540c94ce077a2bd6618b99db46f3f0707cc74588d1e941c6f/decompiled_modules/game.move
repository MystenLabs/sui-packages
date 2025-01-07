module 0x8992d44596a5fa1540c94ce077a2bd6618b99db46f3f0707cc74588d1e941c6f::game {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        version: u8,
        balance: 0x2::balance::Balance<0x8992d44596a5fa1540c94ce077a2bd6618b99db46f3f0707cc74588d1e941c6f::tongold::TONGOLD>,
        init_reward: u64,
        operator_pk: vector<u8>,
        boat_level: 0x2::table_vec::TableVec<BoatLevel>,
        mesh_level: 0x2::table_vec::TableVec<MeshLevel>,
        seafood_level: 0x2::table_vec::TableVec<SeafoodLevel>,
        special_boost: 0x2::table_vec::TableVec<SpecialBoost>,
        gas_fee: u16,
        ref1: u16,
        ref2: u16,
        v_ref: u16,
        v_join_fee: u64,
        v_leave_fee: u64,
    }

    struct BoatLevel has store {
        fishing_time: u32,
        price_upgrade: u64,
    }

    struct MeshLevel has store {
        speed: u32,
        price_upgrade: u64,
    }

    struct SeafoodLevel has store {
        rate: u32,
    }

    struct SpecialBoost has store {
        type: u8,
        rate: u32,
        start_time: u64,
        duration: u64,
    }

    struct User has store, key {
        id: 0x2::object::UID,
        boat: u8,
        mesh: u8,
        seafood: u8,
        special_boost: 0x1::option::Option<u16>,
        special_boost_start_time: u64,
        village: 0x1::string::String,
        referral: address,
        last_claim: u64,
    }

    struct Village has store, key {
        id: 0x2::object::UID,
        village_id: 0x1::string::String,
        balance: 0x2::balance::Balance<0x8992d44596a5fa1540c94ce077a2bd6618b99db46f3f0707cc74588d1e941c6f::tongold::TONGOLD>,
        owner: address,
        num_of_members: u64,
    }

    struct CreateUser has copy, drop, store {
        user_address: address,
        ref_address: address,
        init_reward: u64,
        village_id: 0x1::string::String,
    }

    struct ClaimToken has copy, drop, store {
        user_address: address,
        amount_user_received: u64,
        ref1_address: address,
        amount_ref1_received: u64,
        ref2_address: address,
        amount_ref2_received: u64,
        village_id: 0x1::string::String,
        amount_village_received: u64,
    }

    struct CreateVillage has copy, drop, store {
        village_id: 0x1::string::String,
        owner: address,
    }

    struct JoinVillage has copy, drop, store {
        village_id: 0x1::string::String,
        user_address: address,
        ref_address: address,
    }

    struct LeaveVillage has copy, drop, store {
        village_id: 0x1::string::String,
        user_address: address,
    }

    struct UpdateRef has copy, drop, store {
        user_address: address,
        new_ref: address,
    }

    struct UpgradeLevel has copy, drop, store {
        type: u8,
        user_address: address,
        level: u16,
        amount_upgrade: u64,
    }

    entry fun add_treasury_cap(arg0: &OwnerCap, arg1: &mut GameInfo, arg2: 0x2::coin::TreasuryCap<0x8992d44596a5fa1540c94ce077a2bd6618b99db46f3f0707cc74588d1e941c6f::tongold::TONGOLD>) {
        0x2::dynamic_field::add<0x1::string::String, 0x2::coin::TreasuryCap<0x8992d44596a5fa1540c94ce077a2bd6618b99db46f3f0707cc74588d1e941c6f::tongold::TONGOLD>>(&mut arg1.id, 0x1::string::utf8(b"treasury"), arg2);
    }

    // decompiled from Move bytecode v6
}

