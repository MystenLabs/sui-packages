module 0x4d60167ca198b1264e4d3b95f5227eaf877876058c7cfb970d2e9abde90a6638::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    struct AquaReceipt has key {
        id: 0x2::object::UID,
        shares: u64,
        owner: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
    }

    struct StrategyCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct BorrowReceipt<phantom T0> {
        vault_id: 0x2::object::ID,
        borrowed_amount: u64,
    }

    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        idle_balance: 0x2::balance::Balance<T0>,
        invested_assets: 0x2::bag::Bag,
        user_balances: 0x2::table::Table<address, u64>,
        total_invested: u64,
        total_shares: u64,
        current_strategy: u8,
    }

    struct DepositEvent has copy, drop {
        user: address,
        usdc_amount: u64,
        aqua_minted: u64,
    }

    struct WithdrawEvent has copy, drop {
        user: address,
        aqua_burned: u64,
        usdc_returned: u64,
    }

    struct RerouteEvent has copy, drop {
        from_strategy: u8,
        to_strategy: u8,
        amount_moved: u64,
    }

    struct WithdrawalRequestedEvent has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        shares: u64,
        min_usdc: u64,
    }

    struct WithdrawalFulfilledEvent has copy, drop {
        request_id: 0x2::object::ID,
        user: address,
        usdc_returned: u64,
    }

    struct WithdrawalRequest has key {
        id: 0x2::object::UID,
        user: address,
        shares: u64,
        min_usdc: u64,
    }

    public fun add_display_field<T0: key>(arg0: &AdminCap, arg1: &mut 0x2::display::Display<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<T0>(arg1, arg2, arg3);
        0x2::display::update_version<T0>(arg1);
    }

    public fun admin_bag_contains<T0, T1>(arg0: &KeeperCap, arg1: &Vault<T0>) : bool {
        0x2::bag::contains<0x1::type_name::TypeName>(&arg1.invested_assets, 0x1::type_name::get<T1>())
    }

    public fun admin_burn_receipt(arg0: &KeeperCap, arg1: AquaReceipt) {
        let AquaReceipt {
            id     : v0,
            shares : _,
            owner  : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun admin_burn_receipt_by_admin_cap(arg0: &AdminCap, arg1: AquaReceipt) {
        let AquaReceipt {
            id     : v0,
            shares : _,
            owner  : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun admin_drain_bag_entry<T0, T1>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2::coin::from_balance<T1>(0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg1.invested_assets, 0x1::type_name::get<T1>()), arg2)
    }

    public fun admin_drain_bag_usdc<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg1.invested_assets, v0)) {
            0x2::balance::join<T0>(&mut arg1.idle_balance, 0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg1.invested_assets, v0));
        };
    }

    public fun admin_drain_dust<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(&mut arg1.idle_balance, 0x2::balance::value<T0>(&arg1.idle_balance), arg2)
    }

    public fun admin_remove_user_balance<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: address) {
        if (0x2::table::contains<address, u64>(&arg1.user_balances, arg2)) {
            0x2::table::remove<address, u64>(&mut arg1.user_balances, arg2);
        };
    }

    public fun admin_set_invested<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u64) {
        arg1.total_invested = arg2;
    }

    public fun admin_set_strategy<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u8) {
        arg1.current_strategy = arg2;
    }

    public fun admin_set_total_shares<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u64) {
        arg1.total_shares = arg2;
    }

    public fun admin_zero_invested<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>) {
        arg1.total_invested = 0;
    }

    public fun borrow_all_for_strategy<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap) : (0x2::balance::Balance<T0>, BorrowReceipt<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        let v0 = 0x2::balance::value<T0>(&arg0.idle_balance);
        arg0.total_invested = arg0.total_invested + v0;
        let v1 = BorrowReceipt<T0>{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            borrowed_amount : v0,
        };
        (0x2::balance::withdraw_all<T0>(&mut arg0.idle_balance), v1)
    }

    public fun borrow_for_strategy<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap, arg2: u64) : (0x2::balance::Balance<T0>, BorrowReceipt<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        arg0.total_invested = arg0.total_invested + arg2;
        let v0 = BorrowReceipt<T0>{
            vault_id        : 0x2::object::id<Vault<T0>>(arg0),
            borrowed_amount : arg2,
        };
        (0x2::balance::split<T0>(&mut arg0.idle_balance, arg2), v0)
    }

    public fun burn_partial_receipt(arg0: &mut AquaReceipt, arg1: u64) {
        arg0.shares = arg0.shares - arg1;
    }

    public fun commit_strategy<T0, T1>(arg0: &mut Vault<T0>, arg1: BorrowReceipt<T0>, arg2: 0x2::balance::Balance<T1>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::balance::join<T1>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0), arg2);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0, arg2);
        };
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg1;
    }

    public fun create_strategy_cap<T0>(arg0: &AdminCap, arg1: &Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : StrategyCap {
        StrategyCap{
            id       : 0x2::object::new(arg2),
            vault_id : 0x2::object::id<Vault<T0>>(arg1),
        }
    }

    public fun create_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id               : 0x2::object::new(arg0),
            idle_balance     : 0x2::balance::zero<T0>(),
            invested_assets  : 0x2::bag::new(arg0),
            user_balances    : 0x2::table::new<address, u64>(arg0),
            total_invested   : 0,
            total_shares     : 0,
            current_strategy : 0,
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
        let v1 = KeeperCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<KeeperCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_balances, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_balances, v1)
        } else {
            0
        };
        assert!(v2 + v0 <= 50000000, 4);
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v1)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v1);
            *v3 = *v3 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_balances, v1, v0);
        };
        let v4 = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested;
        let v5 = if (arg0.total_shares == 0 || v4 == 0) {
            v0
        } else {
            v0 * arg0.total_shares / v4
        };
        0x2::coin::put<T0>(&mut arg0.idle_balance, arg1);
        arg0.total_shares = arg0.total_shares + v5;
        mint_receipt(v5, v1, arg2);
        let v6 = DepositEvent{
            user        : v1,
            usdc_amount : v0,
            aqua_minted : v5,
        };
        0x2::event::emit<DepositEvent>(v6);
    }

    public fun deposit_and_get_shares<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = if (0x2::table::contains<address, u64>(&arg0.user_balances, v1)) {
            *0x2::table::borrow<address, u64>(&arg0.user_balances, v1)
        } else {
            0
        };
        assert!(v2 + v0 <= 50000000, 4);
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v1)) {
            let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v1);
            *v3 = *v3 + v0;
        } else {
            0x2::table::add<address, u64>(&mut arg0.user_balances, v1, v0);
        };
        let v4 = 0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested;
        let v5 = if (arg0.total_shares == 0 || v4 == 0) {
            v0
        } else {
            v0 * arg0.total_shares / v4
        };
        0x2::coin::put<T0>(&mut arg0.idle_balance, arg1);
        arg0.total_shares = arg0.total_shares + v5;
        let v6 = DepositEvent{
            user        : v1,
            usdc_amount : v0,
            aqua_minted : v5,
        };
        0x2::event::emit<DepositEvent>(v6);
        v5
    }

    public fun fulfill_withdrawal<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: WithdrawalRequest, arg3: &mut 0x2::tx_context::TxContext) {
        let WithdrawalRequest {
            id       : v0,
            user     : v1,
            shares   : _,
            min_usdc : v3,
        } = arg2;
        let v4 = v0;
        0x2::object::delete(v4);
        let v5 = 0x2::balance::value<T0>(&arg1.idle_balance);
        assert!(v5 >= v3, 5);
        let v6 = WithdrawalFulfilledEvent{
            request_id    : 0x2::object::uid_to_inner(&v4),
            user          : v1,
            usdc_returned : v5,
        };
        0x2::event::emit<WithdrawalFulfilledEvent>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.idle_balance, v5, arg3), v1);
    }

    public fun get_balance(arg0: &AquaReceipt) : u64 {
        arg0.shares
    }

    public fun get_exchange_rate<T0>(arg0: &Vault<T0>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested, arg0.total_shares)
    }

    public fun get_vault_idle_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.idle_balance)
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<AQUA>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AquaYield Deposit Receipt"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Your official deposit receipt for AquaYield."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/e-5jZ0JJ1ZBjdPBXC2aGq0bmFErJzmNNAOkYJc_meW0"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b""));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"AquaYield Protocol"));
        let v5 = 0x2::display::new_with_fields<AquaReceipt>(&v0, v1, v3, arg1);
        0x2::display::update_version<AquaReceipt>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<AquaReceipt>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_display(arg0: &AdminCap, arg1: &0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AquaYield Receipt (Mainnet)"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Official deposit receipt for AquaYield."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/e-5jZ0JJ1ZBjdPBXC2aGq0bmFErJzmNNAOkYJc_meW0"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/e-5jZ0JJ1ZBjdPBXC2aGq0bmFErJzmNNAOkYJc_meW0"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://aquayield.app"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"AquaYield Protocol"));
        let v4 = 0x2::display::new_with_fields<AquaReceipt>(arg1, v0, v2, arg2);
        0x2::display::update_version<AquaReceipt>(&mut v4);
        0x2::transfer::public_share_object<0x2::display::Display<AquaReceipt>>(v4);
    }

    public fun mint_receipt(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AquaReceipt{
            id     : 0x2::object::new(arg2),
            shares : arg0,
            owner  : arg1,
        };
        0x2::transfer::transfer<AquaReceipt>(v0, arg1);
    }

    public fun repay_rebalance<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap, arg2: BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>, arg4: u64) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg2.vault_id, 2);
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        assert!(0x2::coin::value<T0>(&arg3) >= arg4, 1);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg3));
        if (arg0.total_invested >= arg2.borrowed_amount) {
            arg0.total_invested = arg0.total_invested - arg2.borrowed_amount;
        } else {
            arg0.total_invested = 0;
        };
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg2;
    }

    public fun repay_withdraw<T0>(arg0: &mut Vault<T0>, arg1: &StrategyCap, arg2: BorrowReceipt<T0>, arg3: 0x2::coin::Coin<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg2.vault_id, 2);
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        assert!(0x2::coin::value<T0>(&arg3) >= arg2.borrowed_amount, 1);
        0x2::balance::join<T0>(&mut arg0.idle_balance, 0x2::coin::into_balance<T0>(arg3));
        if (arg0.total_invested >= arg2.borrowed_amount) {
            arg0.total_invested = arg0.total_invested - arg2.borrowed_amount;
        } else {
            arg0.total_invested = 0;
        };
        let BorrowReceipt {
            vault_id        : _,
            borrowed_amount : _,
        } = arg2;
    }

    public fun request_withdrawal<T0>(arg0: &mut Vault<T0>, arg1: &mut AquaReceipt, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2 > 0, 1);
        assert!(arg1.shares >= arg2, 1);
        assert!(arg1.owner == v0, 1);
        arg1.shares = arg1.shares - arg2;
        arg0.total_shares = arg0.total_shares - arg2;
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            if (*v1 > arg3) {
                *v1 = *v1 - arg3;
            } else {
                *v1 = 0;
            };
        };
        let v2 = WithdrawalRequest{
            id       : 0x2::object::new(arg4),
            user     : v0,
            shares   : arg2,
            min_usdc : arg3,
        };
        let v3 = WithdrawalRequestedEvent{
            request_id : 0x2::object::id<WithdrawalRequest>(&v2),
            user       : v0,
            shares     : arg2,
            min_usdc   : arg3,
        };
        0x2::event::emit<WithdrawalRequestedEvent>(v3);
        0x2::transfer::share_object<WithdrawalRequest>(v2);
    }

    public fun request_withdrawal_v2<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 > 0, 1);
        arg0.total_shares = arg0.total_shares - arg1;
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            if (*v1 > arg2) {
                *v1 = *v1 - arg2;
            } else {
                *v1 = 0;
            };
        };
        let v2 = WithdrawalRequest{
            id       : 0x2::object::new(arg3),
            user     : v0,
            shares   : arg1,
            min_usdc : arg2,
        };
        let v3 = WithdrawalRequestedEvent{
            request_id : 0x2::object::id<WithdrawalRequest>(&v2),
            user       : v0,
            shares     : arg1,
            min_usdc   : arg2,
        };
        0x2::event::emit<WithdrawalRequestedEvent>(v3);
        0x2::transfer::share_object<WithdrawalRequest>(v2);
    }

    public fun reroute<T0>(arg0: &KeeperCap, arg1: &mut Vault<T0>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 8, 3);
        arg1.current_strategy = arg2;
        let v0 = RerouteEvent{
            from_strategy : arg1.current_strategy,
            to_strategy   : arg2,
            amount_moved  : 0x2::balance::value<T0>(&arg1.idle_balance),
        };
        0x2::event::emit<RerouteEvent>(v0);
    }

    public fun share_display<T0: key>(arg0: &AdminCap, arg1: 0x2::display::Display<T0>) {
        0x2::transfer::public_share_object<0x2::display::Display<T0>>(arg1);
    }

    public fun take_yield_balance<T0, T1>(arg0: &mut Vault<T0>, arg1: &StrategyCap) : 0x2::balance::Balance<T1> {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 2);
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(&arg0.invested_assets, v0)) {
            0x2::bag::remove<0x1::type_name::TypeName, 0x2::balance::Balance<T1>>(&mut arg0.invested_assets, v0)
        } else {
            0x2::balance::zero<T1>()
        }
    }

    public fun update_display_field<T0: key>(arg0: &AdminCap, arg1: &mut 0x2::display::Display<T0>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<T0>(arg1, arg2, arg3);
        0x2::display::update_version<T0>(arg1);
    }

    public fun user_burn_receipt<T0>(arg0: &Vault<T0>, arg1: AquaReceipt, arg2: &0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1.shares == 0 || arg0.total_shares == 0, 1);
        let AquaReceipt {
            id     : v0,
            shares : _,
            owner  : _,
        } = arg1;
        0x2::object::delete(v0);
    }

    public fun user_burn_zero_receipt(arg0: AquaReceipt, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.shares == 0, 1);
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
        let AquaReceipt {
            id     : v0,
            shares : _,
            owner  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: AquaReceipt, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = get_balance(&arg1);
        assert!(v1 >= arg2, 1);
        assert!(arg2 > 0, 1);
        let v2 = arg2 * (0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested) / arg0.total_shares;
        arg0.total_shares = arg0.total_shares - arg2;
        let v3 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
        if (*v3 > v2) {
            *v3 = *v3 - v2;
        } else {
            *v3 = 0;
        };
        if (v1 == arg2) {
            let AquaReceipt {
                id     : v4,
                shares : _,
                owner  : _,
            } = arg1;
            0x2::object::delete(v4);
        } else {
            let v7 = &mut arg1;
            burn_partial_receipt(v7, arg2);
            0x2::transfer::transfer<AquaReceipt>(arg1, v0);
        };
        let v8 = WithdrawEvent{
            user          : v0,
            aqua_burned   : arg2,
            usdc_returned : v2,
        };
        0x2::event::emit<WithdrawEvent>(v8);
        0x2::coin::take<T0>(&mut arg0.idle_balance, v2, arg3)
    }

    public fun withdraw_with_shares<T0>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = arg1 * (0x2::balance::value<T0>(&arg0.idle_balance) + arg0.total_invested) / arg0.total_shares;
        arg0.total_shares = arg0.total_shares - arg1;
        if (0x2::table::contains<address, u64>(&arg0.user_balances, v0)) {
            let v2 = 0x2::table::borrow_mut<address, u64>(&mut arg0.user_balances, v0);
            if (*v2 > v1) {
                *v2 = *v2 - v1;
            } else {
                *v2 = 0;
            };
        };
        let v3 = WithdrawEvent{
            user          : v0,
            aqua_burned   : arg1,
            usdc_returned : v1,
        };
        0x2::event::emit<WithdrawEvent>(v3);
        0x2::coin::take<T0>(&mut arg0.idle_balance, v1, arg2)
    }

    // decompiled from Move bytecode v6
}

