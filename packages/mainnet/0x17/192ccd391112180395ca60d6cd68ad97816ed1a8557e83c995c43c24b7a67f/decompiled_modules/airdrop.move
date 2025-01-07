module 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::airdrop {
    struct Airdrops has store, key {
        id: 0x2::object::UID,
        airdrops: 0x2::vec_map::VecMap<u64, Airdrop>,
        treasury_balances: 0x2::bag::Bag,
        round_index: u64,
    }

    struct Airdrop has store {
        round: u64,
        start_time: u64,
        end_time: u64,
        total_shares: u64,
        claimed_shares: u64,
        total_balance: u64,
        is_open: bool,
        description: vector<u8>,
        coin_type: 0x1::type_name::TypeName,
        image_url: vector<u8>,
        remaining_balance: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AirdropInfo has copy, drop {
        round: u64,
        start_time: u64,
        end_time: u64,
        total_shares: u64,
        claimed_shares: u64,
        total_balance: u64,
        is_open: bool,
        description: vector<u8>,
        coin_type: 0x1::type_name::TypeName,
        image_url: vector<u8>,
        remaining_balance: u64,
    }

    struct Claim has copy, drop {
        sender: address,
        round: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    entry fun new(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Airdrops{
            id                : 0x2::object::new(arg1),
            airdrops          : 0x2::vec_map::empty<u64, Airdrop>(),
            treasury_balances : 0x2::bag::new(arg1),
            round_index       : 0,
        };
        0x2::transfer::public_share_object<Airdrops>(v0);
    }

    entry fun insert<T0>(arg0: &AdminCap, arg1: &mut Airdrops, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: 0x2::coin::Coin<T0>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg7) >= arg5, 1);
        arg1.round_index = arg1.round_index + 1;
        let v0 = arg1.round_index;
        let v1 = 0x2::coin::value<T0>(&arg7) - arg5;
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg7, v1, arg9), 0x2::tx_context::sender(arg9));
        };
        let v2 = Airdrop{
            round             : v0,
            start_time        : arg2,
            end_time          : arg3,
            total_shares      : arg4,
            claimed_shares    : 0,
            total_balance     : arg5,
            is_open           : true,
            description       : arg6,
            coin_type         : 0x1::type_name::get<T0>(),
            image_url         : arg8,
            remaining_balance : arg5,
        };
        0x2::vec_map::insert<u64, Airdrop>(&mut arg1.airdrops, v0, v2);
        0x2::bag::add<u64, 0x2::balance::Balance<T0>>(&mut arg1.treasury_balances, v0, 0x2::coin::into_balance<T0>(arg7));
    }

    public fun airdrops(arg0: &Airdrops) {
        let v0 = 1;
        while (v0 < 0x2::vec_map::size<u64, Airdrop>(&arg0.airdrops) + 1) {
            let v1 = 0x2::vec_map::get<u64, Airdrop>(&arg0.airdrops, &v0);
            let v2 = AirdropInfo{
                round             : v1.round,
                start_time        : v1.start_time,
                end_time          : v1.end_time,
                total_shares      : v1.total_shares,
                claimed_shares    : v1.claimed_shares,
                total_balance     : v1.total_balance,
                is_open           : v1.is_open,
                description       : v1.description,
                coin_type         : v1.coin_type,
                image_url         : v1.image_url,
                remaining_balance : v1.remaining_balance,
            };
            0x2::event::emit<AirdropInfo>(v2);
            v0 = v0 + 1;
        };
    }

    public fun assert_invalid_claim_time(arg0: &0x2::clock::Clock, arg1: &Airdrop) {
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 >= arg1.start_time && v0 <= arg1.end_time, 4);
    }

    public fun assert_no_remaining_shares(arg0: &Airdrop) {
        assert!(arg0.total_shares - arg0.claimed_shares > 0, 5);
    }

    public fun assert_round_exited(arg0: &Airdrops, arg1: u64) {
        assert!(!0x2::vec_map::contains<u64, Airdrop>(&arg0.airdrops, &arg1), 3);
    }

    public fun assert_round_not_found(arg0: &Airdrops, arg1: u64) {
        assert!(0x2::vec_map::contains<u64, Airdrop>(&arg0.airdrops, &arg1), 2);
    }

    entry fun claim<T0>(arg0: &mut Airdrops, arg1: &mut 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::Nodes, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_round_not_found(arg0, arg2);
        let v1 = 0x2::vec_map::get_mut<u64, Airdrop>(&mut arg0.airdrops, &arg2);
        assert_invalid_claim_time(arg3, v1);
        assert_no_remaining_shares(v1);
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::update_purchased_quantity(arg1, v0, arg2);
        let v2 = v1.total_balance / v1.total_shares;
        v1.claimed_shares = v1.claimed_shares + 1;
        v1.remaining_balance = v1.remaining_balance - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg0.treasury_balances, arg2), v2), arg4), v0);
        let v3 = Claim{
            sender    : v0,
            round     : arg2,
            coin_type : 0x1::type_name::get<T0>(),
            amount    : v2,
        };
        0x2::event::emit<Claim>(v3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun insert_node(arg0: &AdminCap, arg1: &mut 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::Nodes, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64) {
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::insert(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    entry fun modify(arg0: &AdminCap, arg1: &mut Airdrops, arg2: u64, arg3: u64, arg4: u64, arg5: bool, arg6: vector<u8>) {
        assert_round_not_found(arg1, arg2);
        let v0 = 0x2::vec_map::get_mut<u64, Airdrop>(&mut arg1.airdrops, &arg2);
        v0.start_time = arg3;
        v0.end_time = arg4;
        v0.is_open = arg5;
        v0.description = arg6;
    }

    public fun modify_invite(arg0: &AdminCap, arg1: &mut 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::Invite, arg2: address, arg3: u64) {
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::modify(arg1, arg2, arg3);
    }

    public fun modify_node(arg0: &AdminCap, arg1: &mut 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::Nodes, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: u64, arg8: bool) {
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::modify(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun modify_nodes<T0>(arg0: &AdminCap, arg1: &mut 0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::Nodes, arg2: address) {
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::modify_nodes<T0>(arg1, arg2);
    }

    public fun new_invite(arg0: &AdminCap, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::invite::new(arg1, arg2, arg3);
    }

    public fun new_node<T0>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x17192ccd391112180395ca60d6cd68ad97816ed1a8557e83c995c43c24b7a67f::node::new<T0>(arg1, arg2);
    }

    entry fun withdraw<T0>(arg0: &AdminCap, arg1: &mut Airdrops, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_round_not_found(arg1, arg2);
        let v0 = 0x2::vec_map::get_mut<u64, Airdrop>(&mut arg1.airdrops, &arg2);
        v0.is_open = false;
        v0.remaining_balance = 0;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(0x2::bag::borrow_mut<u64, 0x2::balance::Balance<T0>>(&mut arg1.treasury_balances, arg2)), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

