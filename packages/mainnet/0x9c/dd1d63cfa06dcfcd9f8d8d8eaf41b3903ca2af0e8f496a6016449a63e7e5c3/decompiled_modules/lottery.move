module 0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery {
    struct BalanceKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Operators has store, key {
        id: 0x2::object::UID,
        data: 0x2::vec_set::VecSet<address>,
    }

    struct LottoInfo<phantom T0> has store, key {
        id: 0x2::object::UID,
        status: 0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::LotteryStatus,
        size_of_lottery: u8,
        prize_pool: u64,
        prize_distribution: vector<u64>,
        starting_timestamp: u64,
        closing_timestamp: u64,
        merkle_root: 0x1::option::Option<vector<u8>>,
        winning_numbers: 0x1::option::Option<vector<u16>>,
        count_winner_per_match: 0x1::option::Option<vector<u64>>,
        claimed: 0x2::table::Table<u64, bool>,
        version: u64,
    }

    struct LotteryOpenEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        size_of_lottery: u8,
        prize_pool: u64,
        prize_distribution: vector<u64>,
        starting_timestamp: u64,
        closing_timestamp: u64,
        creator: address,
        token_reward: 0x1::type_name::TypeName,
    }

    struct LotteyCloseEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        winning_numbers: vector<u16>,
        sender: address,
    }

    struct LotteyCompleteEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        count_winner_per_match: vector<u64>,
        merkle_root: vector<u8>,
        sender: address,
    }

    struct TicketClaimEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        ticket_id: u64,
        ticket_numbers: vector<u16>,
        matching_numbers: u8,
        prize_amount: u64,
        claimer: address,
    }

    struct WithdrawRemainingRewardEvent has copy, drop, store {
        lottery_id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    fun assert_valid_ticket<T0>(arg0: &LottoInfo<T0>, arg1: u64, arg2: vector<u16>, arg3: address, arg4: &vector<vector<u8>>) {
        let v0 = 0x2::object::id<LottoInfo<T0>>(arg0);
        let v1 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<0x2::object::ID>(&v0));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<vector<u16>>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x2::bcs::to_bytes<address>(&arg3));
        assert!(0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::merkle_proof::verify(arg4, *0x1::option::borrow<vector<u8>>(&arg0.merkle_root), 0x2::hash::keccak256(&v1)), 5);
    }

    fun assert_version<T0>(arg0: &LottoInfo<T0>) {
        assert!(arg0.version == 2, 999);
    }

    fun assert_version_and_upgrade<T0>(arg0: &mut LottoInfo<T0>) {
        if (arg0.version < 2) {
            arg0.version = 2;
        };
        assert_version<T0>(arg0);
    }

    public fun bps<T0>(arg0: &LottoInfo<T0>) : u64 {
        let v0 = 0;
        let v1 = arg0.prize_distribution;
        0x1::vector::reverse<u64>(&mut v1);
        while (0x1::vector::length<u64>(&v1) != 0) {
            v0 = v0 + 0x1::vector::pop_back<u64>(&mut v1);
        };
        0x1::vector::destroy_empty<u64>(v1);
        v0
    }

    public entry fun claim_reward<T0>(arg0: &mut LottoInfo<T0>, arg1: u64, arg2: vector<u16>, arg3: vector<vector<u8>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg0);
        assert!(0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::is_completed(arg0.status), 8);
        assert_valid_ticket<T0>(arg0, arg1, arg2, 0x2::tx_context::sender(arg4), &arg3);
        assert!(!0x2::table::contains<u64, bool>(&arg0.claimed, arg1), 9);
        0x2::table::add<u64, bool>(&mut arg0.claimed, arg1, true);
        let v0 = get_number_of_matching(&arg2, 0x1::option::borrow<vector<u16>>(&arg0.winning_numbers));
        let v1 = 0;
        if (v0 > 0) {
            let v2 = get_prize_for_matching<T0>(arg0, v0, bps<T0>(arg0)) / *0x1::vector::borrow<u64>(0x1::option::borrow<vector<u64>>(&arg0.count_winner_per_match), (v0 as u64) - 1);
            v1 = v2;
            distribute_reward<T0>(arg0, v2, arg4);
        };
        let v3 = TicketClaimEvent{
            lottery_id       : 0x2::object::id<LottoInfo<T0>>(arg0),
            ticket_id        : arg1,
            ticket_numbers   : arg2,
            matching_numbers : v0,
            prize_amount     : v1,
            claimer          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<TicketClaimEvent>(v3);
    }

    public fun claimed<T0>(arg0: &LottoInfo<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.claimed, arg1)
    }

    public fun closing_timestamp<T0>(arg0: &LottoInfo<T0>) : u64 {
        arg0.closing_timestamp
    }

    public entry fun complete_lottery<T0>(arg0: &Operators, arg1: &mut LottoInfo<T0>, arg2: vector<u8>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.data, &v0), 10);
        assert!(0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::is_closed(arg1.status), 7);
        assert!(0x1::vector::length<u64>(&arg3) == (arg1.size_of_lottery as u64), 1);
        arg1.status = 0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::completed();
        0x1::option::fill<vector<u64>>(&mut arg1.count_winner_per_match, arg3);
        0x1::option::fill<vector<u8>>(&mut arg1.merkle_root, arg2);
        let v1 = LotteyCompleteEvent{
            lottery_id             : 0x2::object::id<LottoInfo<T0>>(arg1),
            count_winner_per_match : arg3,
            merkle_root            : arg2,
            sender                 : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LotteyCompleteEvent>(v1);
    }

    public fun count_winner_per_match<T0>(arg0: &LottoInfo<T0>) : &0x1::option::Option<vector<u64>> {
        &arg0.count_winner_per_match
    }

    public entry fun create_new_lotto<T0>(arg0: &Operators, arg1: 0x2::coin::Coin<T0>, arg2: u8, arg3: vector<u64>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0x2::vec_set::contains<address>(&arg0.data, &v0), 10);
        assert!(arg2 != 0, 0);
        assert!(0x1::vector::length<u64>(&arg3) == (arg2 as u64), 1);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg3)) {
            v1 = v1 + *0x1::vector::borrow<u64>(&arg3, v2);
            v2 = v2 + 1;
        };
        assert!(v1 == 1000000000, 2);
        assert!(0x2::coin::value<T0>(&arg1) != 0, 3);
        assert!(arg4 > 0x2::clock::timestamp_ms(arg5), 4);
        let v3 = 0x2::coin::value<T0>(&arg1);
        let v4 = 0x2::object::new(arg6);
        let v5 = LottoInfo<T0>{
            id                     : v4,
            status                 : 0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::active(),
            size_of_lottery        : arg2,
            prize_pool             : v3,
            prize_distribution     : arg3,
            starting_timestamp     : 0x2::clock::timestamp_ms(arg5),
            closing_timestamp      : arg4,
            merkle_root            : 0x1::option::none<vector<u8>>(),
            winning_numbers        : 0x1::option::none<vector<u16>>(),
            count_winner_per_match : 0x1::option::none<vector<u64>>(),
            claimed                : 0x2::table::new<u64, bool>(arg6),
            version                : 2,
        };
        let v6 = BalanceKey<T0>{dummy_field: false};
        0x2::dynamic_field::add<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut v5.id, v6, 0x2::coin::into_balance<T0>(arg1));
        0x2::transfer::public_share_object<LottoInfo<T0>>(v5);
        let v7 = LotteryOpenEvent{
            lottery_id         : 0x2::object::uid_to_inner(&v4),
            size_of_lottery    : arg2,
            prize_pool         : v3,
            prize_distribution : arg3,
            starting_timestamp : 0x2::clock::timestamp_ms(arg5),
            closing_timestamp  : arg4,
            creator            : 0x2::tx_context::sender(arg6),
            token_reward       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<LotteryOpenEvent>(v7);
    }

    fun determine_winning_numbers<T0>(arg0: &LottoInfo<T0>, arg1: u256) : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = 0;
        while (v1 < arg0.size_of_lottery) {
            let v2 = 0x2::bcs::to_bytes<u256>(&arg1);
            0x1::vector::append<u8>(&mut v2, 0x2::bcs::to_bytes<u8>(&v1));
            let v3 = 0x2::bcs::new(0x2::hash::keccak256(&v2));
            0x1::vector::push_back<u16>(&mut v0, ((0x2::bcs::peel_u256(&mut v3) % 10) as u16));
            v1 = v1 + 1;
        };
        v0
    }

    fun distribute_reward<T0>(arg0: &mut LottoInfo<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1 > 0) {
            let v0 = BalanceKey<T0>{dummy_field: false};
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), arg1, arg2), 0x2::tx_context::sender(arg2));
        };
    }

    entry fun draw_wining_numbers<T0>(arg0: &Operators, arg1: &mut LottoInfo<T0>, arg2: &0x2::random::Random, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version_and_upgrade<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::vec_set::contains<address>(&arg0.data, &v0), 10);
        assert!(arg1.closing_timestamp <= 0x2::clock::timestamp_ms(arg3), 7);
        let v1 = get_random_number(arg2, arg4);
        let v2 = determine_winning_numbers<T0>(arg1, v1);
        0x1::option::fill<vector<u16>>(&mut arg1.winning_numbers, v2);
        arg1.status = 0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::closed();
        let v3 = LotteyCloseEvent{
            lottery_id      : 0x2::object::id<LottoInfo<T0>>(arg1),
            winning_numbers : v2,
            sender          : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<LotteyCloseEvent>(v3);
    }

    fun get_number_of_matching(arg0: &vector<u16>, arg1: &vector<u16>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u16>(arg1)) {
            if (*0x1::vector::borrow<u16>(arg0, v1) != *0x1::vector::borrow<u16>(arg1, v1)) {
                break
            };
            v0 = v0 + 1;
            v1 = v1 + 1;
        };
        v0
    }

    fun get_prize_for_matching<T0>(arg0: &LottoInfo<T0>, arg1: u8, arg2: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            (((arg0.prize_pool as u128) * (*0x1::vector::borrow<u64>(&arg0.prize_distribution, (arg1 as u64) - 1) as u128) / (arg2 as u128)) as u64)
        }
    }

    fun get_random_number(arg0: &0x2::random::Random, arg1: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x2::random::new_generator(arg0, arg1);
        0x2::random::generate_u256(&mut v0)
    }

    public entry fun grant_operator(arg0: &AdminCap, arg1: &mut Operators, arg2: address) {
        if (!0x2::vec_set::contains<address>(&arg1.data, &arg2)) {
            0x2::vec_set::insert<address>(&mut arg1.data, arg2);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Operators{
            id   : 0x2::object::new(arg0),
            data : 0x2::vec_set::empty<address>(),
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Operators>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun merkle_root<T0>(arg0: &LottoInfo<T0>) : &0x1::option::Option<vector<u8>> {
        &arg0.merkle_root
    }

    public entry fun migrate_as_admin<T0>(arg0: &AdminCap, arg1: &mut LottoInfo<T0>) {
        assert!(arg1.version < 2, 1000);
        arg1.version = 2;
    }

    public fun prize_distribution<T0>(arg0: &LottoInfo<T0>) : &vector<u64> {
        &arg0.prize_distribution
    }

    public fun prize_pool<T0>(arg0: &LottoInfo<T0>) : u64 {
        arg0.prize_pool
    }

    public entry fun revoke_operator(arg0: &AdminCap, arg1: &mut Operators, arg2: address) {
        if (0x2::vec_set::contains<address>(&arg1.data, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.data, &arg2);
        };
    }

    public fun size_of_lottery<T0>(arg0: &LottoInfo<T0>) : u8 {
        arg0.size_of_lottery
    }

    public fun starting_timestamp<T0>(arg0: &LottoInfo<T0>) : u64 {
        arg0.starting_timestamp
    }

    public fun status<T0>(arg0: &LottoInfo<T0>) : 0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::LotteryStatus {
        arg0.status
    }

    public fun winning_numbers<T0>(arg0: &LottoInfo<T0>) : &0x1::option::Option<vector<u16>> {
        &arg0.winning_numbers
    }

    public fun withdraw_remaining_reward<T0>(arg0: &Operators, arg1: &mut LottoInfo<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_version_and_upgrade<T0>(arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&arg0.data, &v0), 10);
        assert!(0xfeb4ee419d393db96f811dc12fed05b5016e71cde6f976eb87cd139bc7023c31::lottery_status::is_completed(arg1.status), 8);
        let v1 = 0;
        let v2 = 0x1::option::borrow<vector<u64>>(&arg1.count_winner_per_match);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(v2)) {
            if (*0x1::vector::borrow<u64>(v2, v3) == 0) {
                v1 = v1 + get_prize_for_matching<T0>(arg1, ((v3 + 1) as u8), bps<T0>(arg1));
            };
            v3 = v3 + 1;
        };
        let v4 = WithdrawRemainingRewardEvent{
            lottery_id : 0x2::object::id<LottoInfo<T0>>(arg1),
            amount     : v1,
            sender     : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<WithdrawRemainingRewardEvent>(v4);
        let v5 = BalanceKey<T0>{dummy_field: false};
        0x2::coin::take<T0>(0x2::dynamic_field::borrow_mut<BalanceKey<T0>, 0x2::balance::Balance<T0>>(&mut arg1.id, v5), v1, arg2)
    }

    // decompiled from Move bytecode v6
}

