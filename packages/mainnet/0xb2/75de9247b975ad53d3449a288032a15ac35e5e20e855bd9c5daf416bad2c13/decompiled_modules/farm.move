module 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::farm {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FarmMemberKey has store, key {
        id: 0x2::object::UID,
        unique_memberships: u16,
        locked: bool,
    }

    struct Farm<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin_id: 0x2::object::ID,
        td: 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::TimeDistributor<T0, 0x2::object::ID>,
    }

    struct ForcefulRemovalReceipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        key_id: 0x2::object::ID,
        balance: 0x2::balance::Balance<T0>,
        spent: bool,
    }

    struct MemberWithdrawAllTicket {
        key_id: 0x2::object::ID,
        farm_ids: 0x2::vec_set::VecSet<0x2::object::ID>,
    }

    public fun size<T0>(arg0: &Farm<T0>) : u64 {
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::size<T0, 0x2::object::ID>(&arg0.td)
    }

    public fun add_member<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: &mut FarmMemberKey, arg3: u32, arg4: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        assert!(arg2.locked == false, 1);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::add_member<T0, 0x2::object::ID>(&mut arg1.td, 0x2::object::id<FarmMemberKey>(arg2), arg3, arg4);
        arg2.unique_memberships = arg2.unique_memberships + 1;
    }

    public fun add_members<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: &mut vector<FarmMemberKey>, arg3: vector<u32>, arg4: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        let v0 = 0x1::vector::empty<0x2::object::ID>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<FarmMemberKey>(arg2)) {
            let v2 = 0x1::vector::borrow_mut<FarmMemberKey>(arg2, v1);
            assert!(v2.locked == false, 1);
            v2.unique_memberships = v2.unique_memberships + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v0, 0x2::object::id<FarmMemberKey>(v2));
            v1 = v1 + 1;
        };
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::add_members<T0, 0x2::object::ID>(&mut arg1.td, v0, arg3, arg4);
    }

    public fun assert_admin_cap<T0>(arg0: &Farm<T0>, arg1: &AdminCap) {
        assert!(0x2::object::borrow_id<AdminCap>(arg1) == &arg0.admin_id, 0);
    }

    public fun change_member_weight<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: 0x2::object::ID, arg3: u32, arg4: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::change_weight<T0, 0x2::object::ID>(&mut arg1.td, &arg2, arg3, arg4);
    }

    public fun change_member_weights_by_idxs<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: vector<u64>, arg3: vector<u32>, arg4: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::change_weights_by_idxs<T0, 0x2::object::ID>(&mut arg1.td, arg2, arg3, arg4);
    }

    public fun change_unlock_per_second<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::change_unlock_per_second<T0, 0x2::object::ID>(&mut arg1.td, arg2, arg3);
    }

    public fun change_unlock_start_ts_sec<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: u64, arg3: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::change_unlock_start_ts_sec<T0, 0x2::object::ID>(&mut arg1.td, arg2, arg3);
    }

    public fun create<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Farm<T0>, AdminCap) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = Farm<T0>{
            id       : 0x2::object::new(arg2),
            admin_id : 0x2::object::id<AdminCap>(&v0),
            td       : 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::create<T0, 0x2::object::ID>(arg0, arg1),
        };
        (v1, v0)
    }

    public fun create_and_share<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : AdminCap {
        let (v0, v1) = create<T0>(0x2::coin::into_balance<T0>(arg0), arg1, arg2);
        0x2::transfer::share_object<Farm<T0>>(v0);
        v1
    }

    public fun create_and_transfer_member_key(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_member_key(arg0);
        0x2::transfer::transfer<FarmMemberKey>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun create_member_key(arg0: &mut 0x2::tx_context::TxContext) : FarmMemberKey {
        FarmMemberKey{
            id                 : 0x2::object::new(arg0),
            unique_memberships : 0,
            locked             : false,
        }
    }

    public fun destroy_admin_cap_irreversibly_i_know_what_im_doing(arg0: AdminCap) {
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_member_key(arg0: FarmMemberKey) {
        assert!(arg0.unique_memberships == 0, 5);
        let FarmMemberKey {
            id                 : v0,
            unique_memberships : _,
            locked             : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_withdraw_all_ticket(arg0: MemberWithdrawAllTicket, arg1: &mut FarmMemberKey) {
        assert!(arg0.key_id == 0x2::object::id<FarmMemberKey>(arg1), 2);
        assert!(0x2::vec_set::size<0x2::object::ID>(&arg0.farm_ids) == (arg1.unique_memberships as u64), 4);
        let MemberWithdrawAllTicket {
            key_id   : _,
            farm_ids : _,
        } = arg0;
        arg1.locked = false;
    }

    public fun forcefully_remove_member<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_admin_cap<T0>(arg1, arg0);
        let (_, v1) = 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::remove_member<T0, 0x2::object::ID>(&mut arg1.td, &arg2, arg3);
        let v2 = ForcefulRemovalReceipt<T0>{
            id      : 0x2::object::new(arg4),
            key_id  : arg2,
            balance : v1,
            spent   : false,
        };
        0x2::transfer::share_object<ForcefulRemovalReceipt<T0>>(v2);
    }

    public fun get_unlock_per_second<T0>(arg0: &Farm<T0>) : u64 {
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::unlock_per_second<T0, 0x2::object::ID>(&arg0.td)
    }

    public fun key_memberships(arg0: &FarmMemberKey) : u16 {
        arg0.unique_memberships
    }

    public fun member_withdraw_all<T0>(arg0: &mut Farm<T0>, arg1: &FarmMemberKey, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::member_withdraw_all<T0, 0x2::object::ID>(&mut arg0.td, 0x2::object::borrow_id<FarmMemberKey>(arg1), arg2)
    }

    public fun member_withdraw_all_with_ticket<T0>(arg0: &mut Farm<T0>, arg1: &mut MemberWithdrawAllTicket, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg1.farm_ids, 0x2::object::borrow_id<Farm<T0>>(arg0)) == false, 3);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg1.farm_ids, 0x2::object::id<Farm<T0>>(arg0));
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::member_withdraw_all<T0, 0x2::object::ID>(&mut arg0.td, &arg1.key_id, arg2)
    }

    public fun new_withdraw_all_ticket(arg0: &mut FarmMemberKey) : MemberWithdrawAllTicket {
        assert!(arg0.locked == false, 1);
        arg0.locked = true;
        MemberWithdrawAllTicket{
            key_id   : 0x2::object::id<FarmMemberKey>(arg0),
            farm_ids : 0x2::vec_set::empty<0x2::object::ID>(),
        }
    }

    public fun redeem_forceful_removal_receipt<T0>(arg0: &mut ForcefulRemovalReceipt<T0>, arg1: &mut FarmMemberKey) : 0x2::balance::Balance<T0> {
        assert!(arg0.spent == false, 6);
        assert!(&arg0.key_id == 0x2::object::borrow_id<FarmMemberKey>(arg1), 2);
        assert!(arg1.locked == false, 1);
        arg1.unique_memberships = arg1.unique_memberships - 1;
        arg0.spent = true;
        0x2::balance::split<T0>(&mut arg0.balance, 0x2::balance::value<T0>(&arg0.balance))
    }

    public fun remove_member<T0>(arg0: &mut Farm<T0>, arg1: &mut FarmMemberKey, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        assert!(arg1.locked == false, 1);
        let (_, v1) = 0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::remove_member<T0, 0x2::object::ID>(&mut arg0.td, 0x2::object::borrow_id<FarmMemberKey>(arg1), arg2);
        arg1.unique_memberships = arg1.unique_memberships - 1;
        v1
    }

    public fun top_up<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock) {
        top_up_balance<T0>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), arg3);
    }

    public fun top_up_balance<T0>(arg0: &AdminCap, arg1: &mut Farm<T0>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        assert_admin_cap<T0>(arg1, arg0);
        0xb275de9247b975ad53d3449a288032a15ac35e5e20e855bd9c5daf416bad2c13::time_distributor::top_up<T0, 0x2::object::ID>(&mut arg1.td, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

