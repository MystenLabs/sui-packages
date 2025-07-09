module 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::funding {
    struct FundingPool<phantom T0> has store, key {
        id: 0x2::object::UID,
        info: PoolInfo,
        state: PoolState,
        vault: 0x2::balance::Balance<T0>,
        owners: 0x2::table::Table<0x1::string::String, Ticket>,
    }

    struct PoolInfo has copy, drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        icon_url: 0x1::string::String,
        start_at: u64,
        max_tickets_num: u64,
        max_tickets_num_per_user: u64,
    }

    struct PoolState has store {
        paused: bool,
        stage: u8,
        ticket_price: u64,
        claimed_tickets_num: u64,
        released_tickets_num: u64,
        amount_per_ticket_on_release: u64,
    }

    struct Ticket has store {
        total: u64,
        hoding: u64,
        released: u64,
        deposited: u64,
        withdrawn: u64,
    }

    struct SoldTicketEvent has copy, drop {
        id: u256,
        uid: 0x1::string::String,
        bought_num: u64,
        spent_token_amount: u64,
        timestamp: u64,
    }

    struct ReleaseTicketEvent has copy, drop {
        id: u256,
        uid: 0x1::string::String,
        withdraw_num: u64,
        withdraw_amount: u64,
        timestamp: u64,
    }

    struct FundingPoolUpdateEvent has copy, drop {
        id: address,
        info: PoolInfo,
    }

    public fun admin_deposit<T0>(arg0: &mut FundingPool<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state.stage == 1, 10);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg2, arg3);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun admin_withdraw<T0>(arg0: &mut FundingPool<T0>, arg1: u64, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.state.stage == 1 || arg0.state.stage == 3, 10);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg2, arg3);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.vault, arg1), arg3)
    }

    fun check_pause<T0>(arg0: &FundingPool<T0>, arg1: bool, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &0x2::tx_context::TxContext) {
        if (arg1 && 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::is_admin(arg2, arg3)) {
            return
        };
        if (arg0.state.paused) {
            abort 15
        };
    }

    public fun create_info(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64) : PoolInfo {
        PoolInfo{
            name                     : arg0,
            description              : arg1,
            icon_url                 : arg2,
            start_at                 : arg3,
            max_tickets_num          : arg4,
            max_tickets_num_per_user : arg5,
        }
    }

    public fun create_pool<T0>(arg0: PoolInfo, arg1: u64, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg2, arg3);
        let v0 = 0x2::object::new(arg3);
        let v1 = FundingPoolUpdateEvent{
            id   : 0x2::object::uid_to_address(&v0),
            info : arg0,
        };
        0x2::event::emit<FundingPoolUpdateEvent>(v1);
        let v2 = FundingPool<T0>{
            id     : v0,
            info   : arg0,
            state  : create_state(arg1),
            vault  : 0x2::balance::zero<T0>(),
            owners : 0x2::table::new<0x1::string::String, Ticket>(arg3),
        };
        0x2::transfer::public_share_object<FundingPool<T0>>(v2);
    }

    fun create_state(arg0: u64) : PoolState {
        PoolState{
            paused                       : false,
            stage                        : 0,
            ticket_price                 : arg0,
            claimed_tickets_num          : 0,
            released_tickets_num         : 0,
            amount_per_ticket_on_release : 0,
        }
    }

    public fun next_stage<T0>(arg0: &mut FundingPool<T0>, arg1: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg2: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg1, arg2);
        let v0 = arg0.state.stage;
        let v1 = &v0;
        let v2 = 0;
        if (v1 == &v2) {
            arg0.state.stage = 1;
        } else {
            let v3 = 1;
            if (v1 == &v3) {
                arg0.state.stage = 2;
                arg0.state.amount_per_ticket_on_release = 0x2::balance::value<T0>(&arg0.vault) / arg0.state.claimed_tickets_num;
            } else {
                let v4 = 2;
                assert!(v1 == &v4, 20);
                arg0.state.stage = 3;
            };
        };
    }

    public fun purchase<T0>(arg0: &mut FundingPool<T0>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::auth::Auth, arg4: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::auth::uid(arg3);
        let v1 = 0x2::clock::timestamp_ms(arg5);
        check_pause<T0>(arg0, true, arg4, arg6);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_admin(arg4, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0FundingPurchase(), arg6);
        assert!(arg0.state.stage == 0, 10);
        assert!(v1 >= arg0.info.start_at, 10);
        arg0.state.claimed_tickets_num = arg0.state.claimed_tickets_num + arg1;
        assert!(arg0.state.claimed_tickets_num <= arg0.info.max_tickets_num, 12);
        let v2 = arg0.info.max_tickets_num_per_user;
        let v3 = arg0.state.ticket_price;
        let v4 = ticket_borrow_mut<T0>(arg0, v0);
        v4.total = v4.total + arg1;
        v4.hoding = v4.hoding + arg1;
        assert!(v4.total <= v2, 1);
        let v5 = arg1 * v3;
        v4.deposited = v4.deposited + v5;
        assert!(0x2::coin::value<T0>(&arg2) >= v5, 2);
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::balance::split<T0>(0x2::coin::balance_mut<T0>(&mut arg2), v5));
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::utils::transfer_or_destroy<T0>(arg2, arg6);
        let v6 = SoldTicketEvent{
            id                 : 0x2::address::to_u256(0x2::tx_context::fresh_object_address(arg6)),
            uid                : v0,
            bought_num         : arg1,
            spent_token_amount : v5,
            timestamp          : v1,
        };
        0x2::event::emit<SoldTicketEvent>(v6);
    }

    fun ticket_borrow_mut<T0>(arg0: &mut FundingPool<T0>, arg1: 0x1::string::String) : &mut Ticket {
        if (!0x2::table::contains<0x1::string::String, Ticket>(&arg0.owners, arg1)) {
            let v0 = Ticket{
                total     : 0,
                hoding    : 0,
                released  : 0,
                deposited : 0,
                withdrawn : 0,
            };
            0x2::table::add<0x1::string::String, Ticket>(&mut arg0.owners, arg1, v0);
        };
        0x2::table::borrow_mut<0x1::string::String, Ticket>(&mut arg0.owners, arg1)
    }

    public fun toggle_pause<T0>(arg0: &mut FundingPool<T0>, arg1: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg2: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg1, arg2);
        arg0.state.paused = !arg0.state.paused;
    }

    public fun update_info<T0>(arg0: &mut FundingPool<T0>, arg1: PoolInfo, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_admin(arg2, arg3);
        arg0.info = arg1;
        let v0 = FundingPoolUpdateEvent{
            id   : 0x2::object::uid_to_address(&arg0.id),
            info : arg1,
        };
        0x2::event::emit<FundingPoolUpdateEvent>(v0);
    }

    public fun withdraw<T0>(arg0: &mut FundingPool<T0>, arg1: u64, arg2: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::auth::Auth, arg3: &0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::State, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg0.state.stage == 2, 10);
        0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::package_state::check_license_without_admin(arg3, 0, 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::consts::F0FundingWithdraw(), arg5);
        check_pause<T0>(arg0, true, arg3, arg5);
        let v0 = 0xe15294a337e2c136e81f7408b494cd63d2c957bdaf85d38200c69f90e0ba9242::auth::uid(arg2);
        let v1 = arg0.state.amount_per_ticket_on_release;
        arg0.state.released_tickets_num = arg0.state.released_tickets_num + arg1;
        let v2 = ticket_borrow_mut<T0>(arg0, v0);
        assert!(v2.hoding >= arg1, 14);
        v2.released = v2.released + arg1;
        v2.hoding = v2.hoding - arg1;
        let v3 = arg1 * v1;
        v2.withdrawn = v2.withdrawn + v3;
        let v4 = ReleaseTicketEvent{
            id              : 0x2::address::to_u256(0x2::tx_context::fresh_object_address(arg5)),
            uid             : v0,
            withdraw_num    : arg1,
            withdraw_amount : v3,
            timestamp       : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<ReleaseTicketEvent>(v4);
        let v5 = 0x2::balance::value<T0>(&arg0.vault);
        let v6 = if (arg0.state.released_tickets_num == arg0.state.claimed_tickets_num && v5 < v3) {
            next_stage<T0>(arg0, arg3, arg5);
            0x2::balance::split<T0>(&mut arg0.vault, v5)
        } else {
            0x2::balance::split<T0>(&mut arg0.vault, v3)
        };
        0x2::coin::from_balance<T0>(v6, arg5)
    }

    // decompiled from Move bytecode v7
}

