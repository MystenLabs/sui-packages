module 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::burn {
    struct BURN_RULE has copy, drop {
        dummy_field: bool,
    }

    struct Burn has store, key {
        id: 0x2::object::UID,
        burn_vec: vector<u64>,
        total_burned_clovers: u64,
    }

    struct BurnPotato {
        clover: 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover,
    }

    struct BurnEvent has copy, drop, store {
        clover_ids: vector<0x2::object::ID>,
        to_clover_id: 0x2::object::ID,
        from_tier: 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::CloverType,
        to_tier: 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::CloverType,
    }

    public fun burn(arg0: &mut Burn, arg1: vector<BurnPotato>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::transfer_policy::TransferPolicy<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>();
        0x1::vector::reverse<BurnPotato>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<BurnPotato>(&arg1)) {
            let BurnPotato { clover: v2 } = 0x1::vector::pop_back<BurnPotato>(&mut arg1);
            0x1::vector::push_back<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<BurnPotato>(arg1);
        let v3 = 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::tier(0x1::vector::borrow<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v0, 0));
        let v4 = &v0;
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(v4)) {
            assert!(0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::tier(0x1::vector::borrow<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(v4, v5)) == v3, 13906834401976647679);
            v5 = v5 + 1;
        };
        let v6 = 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::clover_type_to_index(v3);
        assert!(0x1::vector::length<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v0) == *0x1::vector::borrow<u64>(&arg0.burn_vec, v6), 13906834432041418751);
        arg0.total_burned_clovers = arg0.total_burned_clovers + 0x1::vector::length<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v0);
        let v7 = 0x1::vector::empty<0x2::object::ID>();
        0x1::vector::reverse<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&mut v0);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v0)) {
            let v9 = 0x1::vector::pop_back<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&mut v0);
            0x1::vector::push_back<0x2::object::ID>(&mut v7, 0x2::object::id<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v9));
            0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::burn(v9);
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(v0);
        let v10 = 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::mint(arg5, 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::index_to_clover_type(v6 + 1));
        let v11 = BurnEvent{
            clover_ids   : v7,
            to_clover_id : 0x2::object::id<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(&v10),
            from_tier    : v3,
            to_tier      : 0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::index_to_clover_type(v6 + 1),
        };
        0x2::event::emit<BurnEvent>(v11);
        0x2::kiosk::lock<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(arg2, arg3, arg4, v10);
    }

    public fun change_burn_vec(arg0: &0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::admin::AdminCap, arg1: &mut Burn, arg2: vector<u64>) {
        arg1.burn_vec = arg2;
    }

    public fun create_burn_potato(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>, arg4: &mut 0x2::tx_context::TxContext) : BurnPotato {
        0x2::kiosk::list<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(arg1, arg2, arg0, 0);
        let (v0, v1) = 0x2::kiosk::purchase<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(arg1, arg0, 0x2::coin::zero<0x2::sui::SUI>(arg4));
        let v2 = v1;
        let v3 = BURN_RULE{dummy_field: false};
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::witness_rule::prove<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover, BURN_RULE>(v3, arg3, &mut v2);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0xae9bb8ce14d0e9fb941c992211d274826c87e8a30f0bf45d6356cd288aba07fb::clover::SamClover>(arg3, v2);
        BurnPotato{clover: v0}
    }

    public(friend) fun new_burn(arg0: vector<u64>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Burn{
            id                   : 0x2::object::new(arg1),
            burn_vec             : arg0,
            total_burned_clovers : 0,
        };
        0x2::transfer::public_share_object<Burn>(v0);
    }

    // decompiled from Move bytecode v6
}

