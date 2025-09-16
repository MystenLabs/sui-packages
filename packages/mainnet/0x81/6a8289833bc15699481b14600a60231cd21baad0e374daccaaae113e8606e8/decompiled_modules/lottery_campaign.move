module 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::lottery_campaign {
    struct LotteryTicket has key {
        id: 0x2::object::UID,
        ticket_index: u64,
        info: TicketInfo,
    }

    struct TicketInfo has copy, drop, store {
        owner: address,
        is_paid: bool,
        is_pre_winner: bool,
    }

    struct MainTicketRegistry has key {
        id: 0x2::object::UID,
        next_ticket_index: u64,
        tickets: 0x2::table::Table<u64, TicketInfo>,
    }

    struct DrawRegistry has key {
        id: 0x2::object::UID,
        winners: 0x2::table::Table<u64, bool>,
        next_to_process: u64,
        random_winners_needed: u64,
        random_winners_selected: u64,
        finalized: bool,
        winner_index_progress: u64,
        next_loser_index: u64,
        minted_losers: u64,
        finalized_winners: bool,
        finalized_losers: bool,
        pre_winner_count: u64,
    }

    struct LotteryUSDCPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct PizzaTicketsOwnersRegistry has key {
        id: 0x2::object::UID,
        owners: 0x2::table::Table<u64, address>,
        next_pizza_owner_index: u64,
        minted_pizza: u64,
    }

    struct PizzaTicket has key {
        id: 0x2::object::UID,
        ticket_index: u64,
        owner: address,
    }

    struct LotteryRegistryCap has store, key {
        id: 0x2::object::UID,
    }

    struct FreeTicketRewarded has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_index: u64,
        recipient: address,
        is_pre_winner: bool,
    }

    struct PaidTicketRewarded has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_index: u64,
        recipient: address,
    }

    struct DrawSnapshotTaken has copy, drop {
        total_pre_winners: u64,
    }

    struct RandomWinnersSnapshotTaken has copy, drop {
        total_random_winners: u64,
    }

    struct BoosterPackRewarded has copy, drop {
        ticket_index: u64,
        recipient: address,
    }

    struct TicketRefunded has copy, drop {
        ticket_index: u64,
        recipient: address,
        amount: u64,
    }

    struct BoosterPackLoserRewarded has copy, drop {
        ticket_index: u64,
        recipient: address,
    }

    struct LotteryUSDCPlaced has copy, drop {
        sender: address,
        amount: u64,
    }

    struct PizzaTicketRewarded has copy, drop {
        ticket_id: 0x2::object::ID,
        ticket_index: u64,
        recipient: address,
    }

    struct PizzaBoosterPackRewarded has copy, drop {
        ticket_index: u64,
        recipient: address,
    }

    struct LotteryUSDCWithdrawn has copy, drop {
        sender: address,
        amount: u64,
    }

    struct LotteryTicketBurned has copy, drop {
        ticket_id: 0x2::object::ID,
    }

    struct PizzaTicketBurned has copy, drop {
        ticket_id: 0x2::object::ID,
    }

    public fun burn(arg0: LotteryTicket) {
        let LotteryTicket {
            id           : v0,
            ticket_index : _,
            info         : _,
        } = arg0;
        let v3 = v0;
        let v4 = LotteryTicketBurned{ticket_id: 0x2::object::uid_to_inner(&v3)};
        0x2::event::emit<LotteryTicketBurned>(v4);
        0x2::object::delete(v3);
    }

    public fun burn_pizza_ticket(arg0: PizzaTicket) {
        let PizzaTicket {
            id           : v0,
            ticket_index : _,
            owner        : _,
        } = arg0;
        let v3 = v0;
        let v4 = PizzaTicketBurned{ticket_id: 0x2::object::uid_to_inner(&v3)};
        0x2::event::emit<PizzaTicketBurned>(v4);
        0x2::object::delete(v3);
    }

    public fun draw_cursor(arg0: &DrawRegistry) : u64 {
        arg0.next_to_process
    }

    public fun finalized(arg0: &DrawRegistry) : bool {
        arg0.finalized
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MainTicketRegistry{
            id                : 0x2::object::new(arg0),
            next_ticket_index : 0,
            tickets           : 0x2::table::new<u64, TicketInfo>(arg0),
        };
        let v1 = DrawRegistry{
            id                      : 0x2::object::new(arg0),
            winners                 : 0x2::table::new<u64, bool>(arg0),
            next_to_process         : 0,
            random_winners_needed   : 0,
            random_winners_selected : 0,
            finalized               : false,
            winner_index_progress   : 0,
            next_loser_index        : 0,
            minted_losers           : 0,
            finalized_winners       : false,
            finalized_losers        : false,
            pre_winner_count        : 0,
        };
        let v2 = LotteryUSDCPool{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
        };
        let v3 = PizzaTicketsOwnersRegistry{
            id                     : 0x2::object::new(arg0),
            owners                 : 0x2::table::new<u64, address>(arg0),
            next_pizza_owner_index : 0,
            minted_pizza           : 0,
        };
        let v4 = LotteryRegistryCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<LotteryRegistryCap>(v4, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<MainTicketRegistry>(v0);
        0x2::transfer::share_object<DrawRegistry>(v1);
        0x2::transfer::share_object<LotteryUSDCPool>(v2);
        0x2::transfer::share_object<PizzaTicketsOwnersRegistry>(v3);
    }

    public fun is_paid(arg0: &LotteryTicket) : bool {
        arg0.info.is_paid
    }

    public fun is_pre_winner(arg0: &LotteryTicket) : bool {
        arg0.info.is_pre_winner
    }

    public fun is_winner(arg0: &DrawRegistry, arg1: u64) : bool {
        0x2::table::contains<u64, bool>(&arg0.winners, arg1)
    }

    public fun loser_boosterpacks_finalized(arg0: &DrawRegistry) : bool {
        arg0.finalized_losers
    }

    public fun mint_free_ticket(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::WhiteListMintRegistry, arg1: &mut MainTicketRegistry, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg4)), 2);
        let v0 = arg1.next_ticket_index;
        arg1.next_ticket_index = v0 + 1;
        let v1 = TicketInfo{
            owner         : arg2,
            is_paid       : false,
            is_pre_winner : arg3,
        };
        0x2::table::add<u64, TicketInfo>(&mut arg1.tickets, v0, v1);
        let v2 = 0x2::object::new(arg4);
        let v3 = FreeTicketRewarded{
            ticket_id     : 0x2::object::uid_to_inner(&v2),
            ticket_index  : v0,
            recipient     : arg2,
            is_pre_winner : arg3,
        };
        0x2::event::emit<FreeTicketRewarded>(v3);
        let v4 = LotteryTicket{
            id           : v2,
            ticket_index : v0,
            info         : v1,
        };
        0x2::transfer::transfer<LotteryTicket>(v4, arg2);
    }

    public fun mint_loser_boosterpacks_and_refund_batch(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &MainTicketRegistry, arg2: &mut DrawRegistry, arg3: &mut LotteryUSDCPool, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!loser_boosterpacks_finalized(arg2), 5);
        let v0 = arg1.next_ticket_index;
        let v1 = arg2.next_loser_index;
        let v2 = v1;
        let v3 = 0;
        let v4 = if (v1 + arg14 > v0) {
            v0
        } else {
            v1 + arg14
        };
        while (v2 < v4 && v3 < arg13) {
            if (!0x2::table::contains<u64, bool>(&arg2.winners, v2)) {
                let v5 = 0x2::table::borrow<u64, TicketInfo>(&arg1.tickets, v2);
                let v6 = BoosterPackLoserRewarded{
                    ticket_index : v2,
                    recipient    : v5.owner,
                };
                0x2::event::emit<BoosterPackLoserRewarded>(v6);
                0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::boosterpack::mint_soulbound_boosterpack(v5.owner, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15);
                if (v5.is_paid) {
                    if (usdc_pool_balance(arg3) >= 200000000) {
                        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3.balance, 200000000, arg15), v5.owner);
                        let v7 = TicketRefunded{
                            ticket_index : v2,
                            recipient    : v5.owner,
                            amount       : 200000000,
                        };
                        0x2::event::emit<TicketRefunded>(v7);
                    } else {
                        let v8 = TicketRefunded{
                            ticket_index : v2,
                            recipient    : v5.owner,
                            amount       : 0,
                        };
                        0x2::event::emit<TicketRefunded>(v8);
                    };
                };
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        arg2.next_loser_index = v2;
        arg2.minted_losers = arg2.minted_losers + v3;
        if (arg2.minted_losers == v0 - arg2.pre_winner_count + arg2.random_winners_selected) {
            arg2.finalized_losers = true;
        };
    }

    public fun mint_pizza_boosterpacks_batch(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &0x2::transfer_policy::TransferPolicy<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::boosterpack::BoosterPack>, arg2: &mut PizzaTicketsOwnersRegistry, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = arg2.minted_pizza;
        let v1 = 0;
        while (v0 < arg2.next_pizza_owner_index && v1 < arg12) {
            let v2 = *0x2::table::borrow<u64, address>(&arg2.owners, v0);
            let v3 = PizzaBoosterPackRewarded{
                ticket_index : v0,
                recipient    : v2,
            };
            0x2::event::emit<PizzaBoosterPackRewarded>(v3);
            0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::boosterpack::mint_boosterpack(arg1, v2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg13);
            v1 = v1 + 1;
            v0 = v0 + 1;
        };
        arg2.minted_pizza = v0;
    }

    public fun mint_pizza_ticket(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::WhiteListMintRegistry, arg1: &mut PizzaTicketsOwnersRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 2);
        let v0 = arg1.next_pizza_owner_index;
        arg1.next_pizza_owner_index = v0 + 1;
        0x2::table::add<u64, address>(&mut arg1.owners, v0, arg2);
        let v1 = 0x2::object::new(arg3);
        let v2 = PizzaTicketRewarded{
            ticket_id    : 0x2::object::uid_to_inner(&v1),
            ticket_index : v0,
            recipient    : arg2,
        };
        0x2::event::emit<PizzaTicketRewarded>(v2);
        let v3 = PizzaTicket{
            id           : v1,
            ticket_index : v0,
            owner        : arg2,
        };
        0x2::transfer::transfer<PizzaTicket>(v3, arg2);
    }

    public fun mint_winner_boosterpacks_batch(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &0x2::transfer_policy::TransferPolicy<0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::boosterpack::BoosterPack>, arg2: &MainTicketRegistry, arg3: &mut DrawRegistry, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg13: u64, arg14: u64, arg15: &mut 0x2::tx_context::TxContext) {
        assert!(!winner_boosterpacks_finalized(arg3), 4);
        let v0 = arg2.next_ticket_index;
        let v1 = arg3.winner_index_progress;
        let v2 = v1;
        let v3 = 0;
        let v4 = if (v1 + arg14 > v0) {
            v0
        } else {
            v1 + arg14
        };
        while (v2 < v4 && v3 < arg13) {
            if (0x2::table::contains<u64, bool>(&arg3.winners, v2)) {
                let v5 = 0x2::table::borrow<u64, TicketInfo>(&arg2.tickets, v2);
                let v6 = BoosterPackRewarded{
                    ticket_index : v2,
                    recipient    : v5.owner,
                };
                0x2::event::emit<BoosterPackRewarded>(v6);
                0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::boosterpack::mint_boosterpack(arg1, v5.owner, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg15);
                v3 = v3 + 1;
            };
            v2 = v2 + 1;
        };
        arg3.winner_index_progress = v2;
        if (arg3.winner_index_progress >= arg2.next_ticket_index) {
            arg3.finalized_winners = true;
        };
    }

    public fun minted_losers(arg0: &DrawRegistry) : u64 {
        arg0.minted_losers
    }

    public fun minted_pizza_boosterpacks(arg0: &PizzaTicketsOwnersRegistry) : u64 {
        arg0.minted_pizza
    }

    public fun next_loser_index(arg0: &DrawRegistry) : u64 {
        arg0.next_loser_index
    }

    public fun next_pizza_owner_index(arg0: &PizzaTicketsOwnersRegistry) : u64 {
        arg0.next_pizza_owner_index
    }

    public fun next_ticket_index(arg0: &MainTicketRegistry) : u64 {
        arg0.next_ticket_index
    }

    public fun owner(arg0: &LotteryTicket) : address {
        arg0.info.owner
    }

    public fun pizza_owners(arg0: &PizzaTicketsOwnersRegistry) : &0x2::table::Table<u64, address> {
        &arg0.owners
    }

    public fun pizza_ticket_holder(arg0: &PizzaTicket) : address {
        arg0.owner
    }

    public fun pizza_ticket_index(arg0: &PizzaTicket) : u64 {
        arg0.ticket_index
    }

    public fun purchase_ticket(arg0: &mut MainTicketRegistry, arg1: &DrawRegistry, arg2: &mut LotteryUSDCPool, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!winner_boosterpacks_finalized(arg1), 4);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) == 200000000, 0);
        let v0 = LotteryUSDCPlaced{
            sender : 0x2::tx_context::sender(arg4),
            amount : 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3),
        };
        0x2::event::emit<LotteryUSDCPlaced>(v0);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg2.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        let v1 = arg0.next_ticket_index;
        arg0.next_ticket_index = v1 + 1;
        let v2 = TicketInfo{
            owner         : 0x2::tx_context::sender(arg4),
            is_paid       : true,
            is_pre_winner : false,
        };
        0x2::table::add<u64, TicketInfo>(&mut arg0.tickets, v1, v2);
        let v3 = 0x2::object::new(arg4);
        let v4 = PaidTicketRewarded{
            ticket_id    : 0x2::object::uid_to_inner(&v3),
            ticket_index : v1,
            recipient    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<PaidTicketRewarded>(v4);
        let v5 = LotteryTicket{
            id           : v3,
            ticket_index : v1,
            info         : v2,
        };
        0x2::transfer::transfer<LotteryTicket>(v5, 0x2::tx_context::sender(arg4));
    }

    public fun random_winners_needed(arg0: &DrawRegistry) : u64 {
        arg0.random_winners_needed
    }

    public fun random_winners_selected(arg0: &DrawRegistry) : u64 {
        arg0.random_winners_selected
    }

    entry fun select_random_winners_batch(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &MainTicketRegistry, arg2: &mut DrawRegistry, arg3: &0x2::random::Random, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg3, arg5);
        let v1 = 0;
        while (v1 < arg4 && arg2.random_winners_selected < arg2.random_winners_needed) {
            let v2 = 0x2::random::generate_u64_in_range(&mut v0, 0, arg1.next_ticket_index - 1);
            if (!0x2::table::borrow<u64, TicketInfo>(&arg1.tickets, v2).is_pre_winner) {
                if (!0x2::table::contains<u64, bool>(&arg2.winners, v2)) {
                    0x2::table::add<u64, bool>(&mut arg2.winners, v2, true);
                    arg2.random_winners_selected = arg2.random_winners_selected + 1;
                    v1 = v1 + 1;
                };
            };
        };
        if (arg2.random_winners_selected == arg2.random_winners_needed && !arg2.finalized) {
            arg2.finalized = true;
            let v3 = RandomWinnersSnapshotTaken{total_random_winners: arg2.random_winners_selected};
            0x2::event::emit<RandomWinnersSnapshotTaken>(v3);
        };
    }

    public fun sweep_remaining_funds_to_treasury(arg0: &LotteryRegistryCap, arg1: &mut LotteryUSDCPool, arg2: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::PoolAdminSettings, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 > 0, 7);
        assert!(arg3 <= usdc_pool_balance(arg1), 8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::take<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, arg3, arg4), 0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::treasury_address(arg2));
        let v0 = LotteryUSDCWithdrawn{
            sender : 0x2::tx_context::sender(arg4),
            amount : arg3,
        };
        0x2::event::emit<LotteryUSDCWithdrawn>(v0);
    }

    public fun take_draw_snapshot_batch(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &MainTicketRegistry, arg2: &mut DrawRegistry, arg3: u64, arg4: u64, arg5: u64) {
        assert!(arg2.random_winners_selected == 0, 6);
        let v0 = arg1.next_ticket_index;
        let v1 = if (arg4 + arg5 > v0) {
            v0
        } else {
            arg4 + arg5
        };
        while (arg4 < v1) {
            if (0x2::table::borrow<u64, TicketInfo>(&arg1.tickets, arg4).is_pre_winner && !0x2::table::contains<u64, bool>(&arg2.winners, arg4)) {
                0x2::table::add<u64, bool>(&mut arg2.winners, arg4, true);
                arg2.pre_winner_count = arg2.pre_winner_count + 1;
            };
            arg4 = arg4 + 1;
        };
        arg2.next_to_process = v1;
        if (v1 >= v0) {
            assert!(arg3 >= arg2.pre_winner_count, 1);
            let v2 = arg3 - arg2.pre_winner_count;
            assert!(v0 - arg2.pre_winner_count >= v2, 3);
            arg2.random_winners_needed = v2;
            arg2.random_winners_selected = 0;
            let v3 = DrawSnapshotTaken{total_pre_winners: arg2.pre_winner_count};
            0x2::event::emit<DrawSnapshotTaken>(v3);
        };
    }

    public fun ticket_index(arg0: &LotteryTicket) : u64 {
        arg0.ticket_index
    }

    public fun tickets(arg0: &MainTicketRegistry) : &0x2::table::Table<u64, TicketInfo> {
        &arg0.tickets
    }

    public fun top_up_usdc_pool(arg0: &0xb908f3c6fea6865d32e2048c520cdfe3b5c5bbcebb658117c41bad70f52b7ccc::registry::AdminCap, arg1: &mut LotteryUSDCPool, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg1.balance, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
    }

    public fun total_pizza_ticket_owners(arg0: &PizzaTicketsOwnersRegistry) : u64 {
        0x2::table::length<u64, address>(&arg0.owners)
    }

    public fun total_tickets(arg0: &MainTicketRegistry) : u64 {
        0x2::table::length<u64, TicketInfo>(&arg0.tickets)
    }

    public fun usdc_pool_balance(arg0: &LotteryUSDCPool) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.balance)
    }

    public fun winner_boosterpacks_finalized(arg0: &DrawRegistry) : bool {
        arg0.finalized_winners
    }

    public fun winner_index_progress(arg0: &DrawRegistry) : u64 {
        arg0.winner_index_progress
    }

    // decompiled from Move bytecode v6
}

