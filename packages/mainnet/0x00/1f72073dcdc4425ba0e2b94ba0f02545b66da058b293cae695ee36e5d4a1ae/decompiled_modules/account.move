module 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::account {
    struct UserAccount has key {
        id: 0x2::object::UID,
        owner: address,
        account_id: 0x2::object::ID,
    }

    struct Account<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        offset: u64,
        balance: 0x2::balance::Balance<T0>,
        profit: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64,
        margin_total: u64,
        margin_cross_total: u64,
        margin_isolated_total: u64,
        margin_cross_buy_total: u64,
        margin_cross_sell_total: u64,
        margin_isolated_buy_total: u64,
        margin_isolated_sell_total: u64,
        cross_position_idx: 0x2::vec_map::VecMap<PFK, 0x2::object::ID>,
        isolated_position_idx: vector<0x2::object::ID>,
    }

    struct PFK has copy, drop, store {
        market_id: 0x2::object::ID,
        account_id: 0x2::object::ID,
        direction: u8,
    }

    public(friend) fun add_isolated_position_id<T0>(arg0: &mut Account<T0>, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.isolated_position_idx, arg1);
    }

    public(friend) fun add_pfk_id<T0>(arg0: &mut Account<T0>, arg1: PFK, arg2: 0x2::object::ID) {
        0x2::vec_map::insert<PFK, 0x2::object::ID>(&mut arg0.cross_position_idx, arg1, arg2);
    }

    public fun contains_isolated_position_id<T0>(arg0: &Account<T0>, arg1: &0x2::object::ID) : bool {
        0x1::vector::contains<0x2::object::ID>(&arg0.isolated_position_idx, arg1)
    }

    public fun contains_pfk<T0>(arg0: &Account<T0>, arg1: &PFK) : bool {
        0x2::vec_map::contains<PFK, 0x2::object::ID>(&arg0.cross_position_idx, arg1)
    }

    public fun create_account<T0>(arg0: &0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg1);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = Account<T0>{
            id                         : v0,
            owner                      : 0x2::tx_context::sender(arg1),
            offset                     : 0,
            balance                    : 0x2::balance::zero<T0>(),
            profit                     : 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::new(0, false),
            margin_total               : 0,
            margin_cross_total         : 0,
            margin_isolated_total      : 0,
            margin_cross_buy_total     : 0,
            margin_cross_sell_total    : 0,
            margin_isolated_buy_total  : 0,
            margin_isolated_sell_total : 0,
            cross_position_idx         : 0x2::vec_map::empty<PFK, 0x2::object::ID>(),
            isolated_position_idx      : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v3 = UserAccount{
            id         : 0x2::object::new(arg1),
            owner      : 0x2::tx_context::sender(arg1),
            account_id : v1,
        };
        0x2::transfer::transfer<UserAccount>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Account<T0>>(v2);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::create<Account<T0>>(v1);
        v1
    }

    public(friend) fun dec_margin_cross_buy_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_cross_buy_total = arg0.margin_cross_buy_total - arg1;
    }

    public(friend) fun dec_margin_cross_sell_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_cross_sell_total = arg0.margin_cross_sell_total - arg1;
    }

    public(friend) fun dec_margin_cross_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_cross_total = arg0.margin_cross_total - arg1;
    }

    public(friend) fun dec_margin_isolated_buy_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_isolated_buy_total = arg0.margin_isolated_buy_total - arg1;
    }

    public(friend) fun dec_margin_isolated_sell_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_isolated_sell_total = arg0.margin_isolated_sell_total - arg1;
    }

    public(friend) fun dec_margin_isolated_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_isolated_total = arg0.margin_isolated_total - arg1;
    }

    public(friend) fun dec_margin_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_total = arg0.margin_total - arg1;
    }

    public(friend) fun dec_profit<T0>(arg0: &mut Account<T0>, arg1: u64) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::dec_u64(&mut arg0.profit, arg1);
    }

    public fun deposit<T0>(arg0: &mut Account<T0>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        if (arg2 == 0) {
            0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
            return
        };
        assert!(arg2 <= 0x2::coin::value<T0>(&arg1), 1);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, arg2, arg3)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg3));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Account<T0>>(0x2::object::id<Account<T0>>(arg0));
    }

    public fun get_all_position_ids<T0>(arg0: &Account<T0>) : vector<0x2::object::ID> {
        let v0 = arg0.isolated_position_idx;
        let v1 = 0;
        while (v1 < 0x2::vec_map::size<PFK, 0x2::object::ID>(&arg0.cross_position_idx)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<PFK, 0x2::object::ID>(&arg0.cross_position_idx, v1);
            0x1::vector::push_back<0x2::object::ID>(&mut v0, *v3);
            v1 = v1 + 1;
        };
        v0
    }

    public fun get_balance<T0>(arg0: &Account<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun get_margin_cross_buy_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_cross_buy_total
    }

    public fun get_margin_cross_sell_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_cross_sell_total
    }

    public fun get_margin_cross_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_cross_total
    }

    public fun get_margin_isolated_buy_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_isolated_buy_total
    }

    public fun get_margin_isolated_sell_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_isolated_sell_total
    }

    public fun get_margin_isolated_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_isolated_total
    }

    public fun get_margin_total<T0>(arg0: &Account<T0>) : u64 {
        arg0.margin_total
    }

    public fun get_margin_used<T0>(arg0: &Account<T0>) : u64 {
        0x2::math::max(arg0.margin_cross_buy_total, arg0.margin_cross_sell_total)
    }

    public fun get_offset<T0>(arg0: &Account<T0>) : u64 {
        arg0.offset
    }

    public fun get_owner<T0>(arg0: &Account<T0>) : address {
        arg0.owner
    }

    public fun get_pfk_id<T0>(arg0: &Account<T0>, arg1: &PFK) : 0x2::object::ID {
        *0x2::vec_map::get<PFK, 0x2::object::ID>(&arg0.cross_position_idx, arg1)
    }

    public fun get_pfk_ids<T0>(arg0: &Account<T0>) : vector<0x2::object::ID> {
        let v0 = 0;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        while (v0 < 0x2::vec_map::size<PFK, 0x2::object::ID>(&arg0.cross_position_idx)) {
            let (_, v3) = 0x2::vec_map::get_entry_by_idx<PFK, 0x2::object::ID>(&arg0.cross_position_idx, v0);
            0x1::vector::push_back<0x2::object::ID>(&mut v1, *v3);
            v0 = v0 + 1;
        };
        v1
    }

    public fun get_profit<T0>(arg0: &Account<T0>) : &0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64 {
        &arg0.profit
    }

    public fun get_uid<T0>(arg0: &Account<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_uid_mut<T0>(arg0: &mut Account<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun inc_margin_cross_buy_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_cross_buy_total = arg0.margin_cross_buy_total + arg1;
    }

    public(friend) fun inc_margin_cross_sell_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_cross_sell_total = arg0.margin_cross_sell_total + arg1;
    }

    public(friend) fun inc_margin_cross_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_cross_total = arg0.margin_cross_total + arg1;
    }

    public(friend) fun inc_margin_isolated_buy_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_isolated_buy_total = arg0.margin_isolated_buy_total + arg1;
    }

    public(friend) fun inc_margin_isolated_sell_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_isolated_sell_total = arg0.margin_isolated_sell_total + arg1;
    }

    public(friend) fun inc_margin_isolated_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_isolated_total = arg0.margin_isolated_total + arg1;
    }

    public(friend) fun inc_margin_total<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.margin_total = arg0.margin_total + arg1;
    }

    public(friend) fun inc_profit<T0>(arg0: &mut Account<T0>, arg1: u64) {
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::inc_u64(&mut arg0.profit, arg1);
    }

    public(friend) fun join_balance<T0>(arg0: &mut Account<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public fun new_PFK(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u8) : PFK {
        PFK{
            market_id  : arg0,
            account_id : arg1,
            direction  : arg2,
        }
    }

    public(friend) fun remove_isolated_position_id<T0>(arg0: &mut Account<T0>, arg1: 0x2::object::ID) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(&arg0.isolated_position_idx)) {
            if (*0x1::vector::borrow<0x2::object::ID>(&arg0.isolated_position_idx, v0) == arg1) {
                0x1::vector::swap_remove<0x2::object::ID>(&mut arg0.isolated_position_idx, v0);
                return
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun remove_pfk_id<T0>(arg0: &mut Account<T0>, arg1: &PFK) {
        let (_, _) = 0x2::vec_map::remove<PFK, 0x2::object::ID>(&mut arg0.cross_position_idx, arg1);
    }

    public(friend) fun set_offset<T0>(arg0: &mut Account<T0>, arg1: u64) {
        arg0.offset = arg1;
    }

    public(friend) fun split_balance<T0>(arg0: &mut Account<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    public(friend) fun withdrawal<T0, T1>(arg0: 0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::I64, arg1: &mut Account<T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 2);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::dec_u64(&mut arg0, arg2);
        assert!(!0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::is_negative(&arg0), 3);
        let v0 = get_margin_used<T1>(arg1);
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::dec_u64(&mut arg0, arg2);
        if (v0 > 0) {
            assert!(0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::i64::get_value(&arg0) / v0 >= 1, 3);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
        0x1f72073dcdc4425ba0e2b94ba0f02545b66da058b293cae695ee36e5d4a1ae::event::update<Account<T1>>(0x2::object::id<Account<T1>>(arg1));
    }

    // decompiled from Move bytecode v6
}

