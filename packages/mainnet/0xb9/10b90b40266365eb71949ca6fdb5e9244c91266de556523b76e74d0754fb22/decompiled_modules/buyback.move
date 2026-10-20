module 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::buyback {
    struct Buyback has key {
        id: 0x2::object::UID,
        version: u64,
        price: u64,
        epoch_price: u64,
        treasury: address,
        points_minted: u64,
        epoch: u64,
        epoch_open: bool,
        selling_ended: bool,
        deposit: u64,
        quota_assigned: u64,
        quota_unspent: u64,
        sui_paid: u64,
        sellable_points: u64,
        purchase_cap: u64,
        wallet_purchase_max: u64,
        points_purchased: u64,
        published_minted: u64,
        mint_numerator: u64,
        mint_cap: u64,
        pool: 0x2::balance::Balance<0x2::sui::SUI>,
        locked: 0x2::balance::Balance<0x2::sui::SUI>,
        accounts: 0x2::table::Table<address, BuybackAccount>,
        operators: 0x2::table::Table<0x2::object::ID, address>,
        function_mask: u128,
    }

    struct BuybackOperatorCap has store, key {
        id: 0x2::object::UID,
        buyback_id: 0x2::object::ID,
    }

    struct BuybackAccount has store {
        epoch: u64,
        quota_credited: bool,
        activity_minted: bool,
        remaining_sui: u64,
        points_purchased: u64,
    }

    struct BuybackIdKey has copy, drop, store {
        dummy_field: bool,
    }

    struct BuybackFunctionMaskUpdated has copy, drop {
        function_mask: u128,
    }

    struct BuybackCreated has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        treasury: address,
    }

    struct BuybackTreasuryUpdated has copy, drop {
        treasury: address,
    }

    struct BuybackEpochOpened has copy, drop {
        epoch: u64,
        treasury_cap: u64,
        deposit: u64,
        price: u64,
        sellable_points: u64,
        purchase_cap: u64,
        wallet_purchase_max: u64,
        mint_numerator: u64,
        mint_cap: u64,
    }

    struct SellQuotaCredited has copy, drop {
        epoch: u64,
        recipient: address,
        sui_amount: u64,
    }

    struct PointsMinted has copy, drop {
        id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        kind: u8,
        epoch: u64,
        price: u64,
    }

    struct PointsSold has copy, drop {
        seller: address,
        points_id: 0x2::object::ID,
        points: u64,
        sui_paid: u64,
        price: u64,
        epoch: u64,
    }

    struct PointsPurchased has copy, drop {
        buyer: address,
        points_id: 0x2::object::ID,
        points: u64,
        sui_paid: u64,
        price: u64,
        epoch: u64,
    }

    struct BuybackEpochClosed has copy, drop {
        epoch: u64,
        sui_returned: u64,
        sui_paid: u64,
    }

    struct PointSellingEnded has copy, drop {
        dummy_field: bool,
    }

    struct BuybackVersionMigrated has copy, drop {
        old_version: u64,
        new_version: u64,
    }

    struct BuybackOperatorIssued has copy, drop {
        buyback_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
        recipient: address,
    }

    struct BuybackOperatorRevoked has copy, drop {
        buyback_id: 0x2::object::ID,
        operator_id: 0x2::object::ID,
    }

    struct BuybackLockedWithdrawn has copy, drop {
        amount: u64,
        recipient: address,
    }

    fun accrue_minted(arg0: &mut Buyback, arg1: u64) {
        while (arg1 > 0) {
            let v0 = 210000 - arg0.points_minted % 210000;
            let v1 = if (arg1 < v0) {
                arg1
            } else {
                v0
            };
            arg0.points_minted = checked_add(arg0.points_minted, v1);
            arg1 = arg1 - v1;
            if (arg0.points_minted % 210000 == 0) {
                arg0.price = bump_price(arg0.price);
            };
        };
    }

    fun add_points_purchased(arg0: &mut Buyback, arg1: address, arg2: u64, arg3: u64) {
        ensure_account(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<address, BuybackAccount>(&mut arg0.accounts, arg1);
        v0.points_purchased = checked_add(v0.points_purchased, arg3);
    }

    public fun admin_close_buyback_epoch(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: &mut 0x2::tx_context::TxContext) {
        witness_admin(arg0);
        close_buyback_epoch(arg1, arg2);
    }

    public fun admin_create_buyback(arg0: &mut 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 2);
        assert!(arg2 != @0x0, 31);
        let v0 = BuybackIdKey{dummy_field: false};
        assert!(!0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::admin_has_field<BuybackIdKey>(arg0, v0), 3);
        let v1 = Buyback{
            id                  : 0x2::object::new(arg3),
            version             : 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::current_package_version(),
            price               : arg1,
            epoch_price         : arg1,
            treasury            : arg2,
            points_minted       : 0,
            epoch               : 0,
            epoch_open          : false,
            selling_ended       : false,
            deposit             : 0,
            quota_assigned      : 0,
            quota_unspent       : 0,
            sui_paid            : 0,
            sellable_points     : 0,
            purchase_cap        : 0,
            wallet_purchase_max : 0,
            points_purchased    : 0,
            published_minted    : 0,
            mint_numerator      : 0,
            mint_cap            : 0,
            pool                : 0x2::balance::zero<0x2::sui::SUI>(),
            locked              : 0x2::balance::zero<0x2::sui::SUI>(),
            accounts            : 0x2::table::new<address, BuybackAccount>(arg3),
            operators           : 0x2::table::new<0x2::object::ID, address>(arg3),
            function_mask       : 255,
        };
        let v2 = BuybackIdKey{dummy_field: false};
        0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::add_admin_field<BuybackIdKey, 0x2::object::ID>(arg0, v2, 0x2::object::id<Buyback>(&v1));
        let v3 = BuybackCreated{
            id       : 0x2::object::id<Buyback>(&v1),
            price    : arg1,
            treasury : arg2,
        };
        0x2::event::emit<BuybackCreated>(v3);
        0x2::transfer::share_object<Buyback>(v1);
    }

    public fun admin_credit_sell_quota(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: address, arg3: u64, arg4: u64) {
        witness_admin(arg0);
        credit_sell_quota(arg1, arg2, arg3, arg4);
    }

    public fun admin_end_point_selling(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback) {
        witness_admin(arg0);
        assert_enabled(arg1, 6);
        assert!(!arg1.epoch_open, 4);
        arg1.selling_ended = true;
        let v0 = PointSellingEnded{dummy_field: false};
        0x2::event::emit<PointSellingEnded>(v0);
    }

    public fun admin_issue_buyback_operator(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg1);
        let v0 = BuybackOperatorCap{
            id         : 0x2::object::new(arg3),
            buyback_id : 0x2::object::id<Buyback>(arg1),
        };
        let v1 = 0x2::object::id<BuybackOperatorCap>(&v0);
        0x2::table::add<0x2::object::ID, address>(&mut arg1.operators, v1, arg2);
        let v2 = BuybackOperatorIssued{
            buyback_id  : 0x2::object::id<Buyback>(arg1),
            operator_id : v1,
            recipient   : arg2,
        };
        0x2::event::emit<BuybackOperatorIssued>(v2);
        0x2::transfer::public_transfer<BuybackOperatorCap>(v0, arg2);
    }

    public fun admin_migrate_buyback(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback) {
        let v0 = arg1.version;
        let v1 = 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::current_package_version();
        assert!(v0 == v1 || v0 < v1 && v1 - v0 == 1, 24);
        arg1.version = v1;
        let v2 = BuybackVersionMigrated{
            old_version : v0,
            new_version : v1,
        };
        0x2::event::emit<BuybackVersionMigrated>(v2);
    }

    public fun admin_mint_points(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: u8, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        witness_admin(arg0);
        mint_points(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_open_buyback_epoch(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64) {
        witness_admin(arg0);
        open_buyback_epoch(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun admin_revoke_buyback_operator(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: 0x2::object::ID) {
        assert_version(arg1);
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg1.operators, arg2), 27);
        0x2::table::remove<0x2::object::ID, address>(&mut arg1.operators, arg2);
        let v0 = BuybackOperatorRevoked{
            buyback_id  : 0x2::object::id<Buyback>(arg1),
            operator_id : arg2,
        };
        0x2::event::emit<BuybackOperatorRevoked>(v0);
    }

    public fun admin_set_buyback_function_enabled(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: u8, arg3: bool) {
        witness_admin(arg0);
        assert_version(arg1);
        assert!(arg2 < 128, 29);
        if (arg3) {
            arg1.function_mask = arg1.function_mask | 1 << arg2;
        } else {
            arg1.function_mask = arg1.function_mask & (340282366920938463463374607431768211455 ^ 1 << arg2);
        };
        let v0 = BuybackFunctionMaskUpdated{function_mask: arg1.function_mask};
        0x2::event::emit<BuybackFunctionMaskUpdated>(v0);
    }

    public fun admin_set_buyback_function_mask(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: u128) {
        witness_admin(arg0);
        assert_version(arg1);
        arg1.function_mask = arg2;
        let v0 = BuybackFunctionMaskUpdated{function_mask: arg2};
        0x2::event::emit<BuybackFunctionMaskUpdated>(v0);
    }

    public fun admin_set_buyback_treasury(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: address) {
        witness_admin(arg0);
        assert_version(arg1);
        assert!(arg2 != @0x0, 31);
        arg1.treasury = arg2;
        let v0 = BuybackTreasuryUpdated{treasury: arg2};
        0x2::event::emit<BuybackTreasuryUpdated>(v0);
    }

    public fun admin_withdraw_locked(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap, arg1: &mut Buyback, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        witness_admin(arg0);
        assert_enabled(arg1, 7);
        assert!(arg2 > 0, 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg1.locked) >= arg2, 30);
        let v0 = BuybackLockedWithdrawn{
            amount    : arg2,
            recipient : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BuybackLockedWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.locked, arg2), arg3)
    }

    fun apply_epoch_mint(arg0: &mut Buyback, arg1: u8, arg2: u64) {
        assert!(arg1 == 0, 18);
        let v0 = checked_add(arg0.published_minted, arg2);
        assert!(v0 <= arg0.mint_cap, 19);
        arg0.published_minted = v0;
    }

    fun assert_enabled(arg0: &Buyback, arg1: u8) {
        assert_version(arg0);
        assert!(arg1 < 128, 29);
        let v0 = 1 << arg1;
        assert!(arg0.function_mask & v0 == v0, 28);
    }

    fun assert_operator(arg0: &Buyback, arg1: &BuybackOperatorCap) {
        assert_version(arg0);
        assert!(arg1.buyback_id == 0x2::object::id<Buyback>(arg0), 25);
        assert!(0x2::table::contains<0x2::object::ID, address>(&arg0.operators, 0x2::object::id<BuybackOperatorCap>(arg1)), 27);
    }

    fun assert_pool_matches_quotas(arg0: &Buyback) {
        assert!(arg0.quota_assigned <= arg0.deposit, 23);
        assert!(arg0.quota_unspent <= arg0.quota_assigned, 23);
        let v0 = arg0.quota_assigned - arg0.quota_unspent;
        assert!(v0 == arg0.sui_paid, 23);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pool) == arg0.deposit - v0, 23);
    }

    fun assert_version(arg0: &Buyback) {
        assert!(arg0.version == 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::current_package_version(), 24);
    }

    fun bump_price(arg0: u64) : u64 {
        let v0 = (arg0 as u128) * (1021 as u128) / (1000 as u128);
        assert!(v0 >= (arg0 as u128), 2);
        u64_from_u128(v0)
    }

    public fun buy_points(arg0: &mut Buyback, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::ZPoints {
        assert_enabled(arg0, 5);
        assert!(arg0.epoch_open, 5);
        assert!(!arg0.selling_ended, 6);
        assert!(arg2 > 0, 15);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg0.epoch;
        assert!(within_cap(points_purchased_of(arg0, v0, v1), arg2, wallet_purchase_cap(arg0.purchase_cap, arg0.wallet_purchase_max)), 17);
        assert!(within_cap(arg0.points_purchased, arg2, arg0.purchase_cap), 16);
        let v2 = arg0.price;
        let v3 = mint_cost(arg0.price, arg0.points_minted, arg2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == v3, 1);
        add_points_purchased(arg0, v0, v1, arg2);
        arg0.points_purchased = checked_add(arg0.points_purchased, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.locked, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        accrue_minted(arg0, arg2);
        let v4 = 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::create_z_points(arg2, v0, arg3);
        let v5 = PointsPurchased{
            buyer     : v0,
            points_id : 0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::ZPoints>(&v4),
            points    : arg2,
            sui_paid  : v3,
            price     : v2,
            epoch     : v1,
        };
        0x2::event::emit<PointsPurchased>(v5);
        v4
    }

    public fun buyback_deposit(arg0: &Buyback) : u64 {
        arg0.deposit
    }

    public fun buyback_epoch(arg0: &Buyback) : u64 {
        arg0.epoch
    }

    public fun buyback_epoch_open(arg0: &Buyback) : bool {
        arg0.epoch_open
    }

    public fun buyback_function_enabled(arg0: &Buyback, arg1: u8) : bool {
        if (arg1 >= 128) {
            return false
        };
        let v0 = 1 << arg1;
        arg0.function_mask & v0 == v0
    }

    public fun buyback_function_mask(arg0: &Buyback) : u128 {
        arg0.function_mask
    }

    public fun buyback_locked(arg0: &Buyback) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.locked)
    }

    public fun buyback_max_mint_numerator() : u64 {
        10000000000
    }

    public fun buyback_mint_cap(arg0: &Buyback) : u64 {
        arg0.mint_cap
    }

    public fun buyback_mint_denominator() : u64 {
        1000000000
    }

    public fun buyback_mint_numerator(arg0: &Buyback) : u64 {
        arg0.mint_numerator
    }

    public fun buyback_points_purchased(arg0: &Buyback) : u64 {
        arg0.points_purchased
    }

    public fun buyback_pool(arg0: &Buyback) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.pool)
    }

    public fun buyback_published_minted(arg0: &Buyback) : u64 {
        arg0.published_minted
    }

    public fun buyback_purchase_cap(arg0: &Buyback) : u64 {
        arg0.purchase_cap
    }

    public fun buyback_quota_assigned(arg0: &Buyback) : u64 {
        arg0.quota_assigned
    }

    public fun buyback_quota_unspent(arg0: &Buyback) : u64 {
        arg0.quota_unspent
    }

    public fun buyback_sellable_points(arg0: &Buyback) : u64 {
        arg0.sellable_points
    }

    public fun buyback_treasury(arg0: &Buyback) : address {
        arg0.treasury
    }

    public fun buyback_version(arg0: &Buyback) : u64 {
        arg0.version
    }

    public fun buyback_wallet_purchase_max(arg0: &Buyback) : u64 {
        arg0.wallet_purchase_max
    }

    fun checked_add(arg0: u64, arg1: u64) : u64 {
        u64_from_u128((arg0 as u128) + (arg1 as u128))
    }

    fun claim_activity_mint(arg0: &mut Buyback, arg1: address, arg2: u64) {
        ensure_account(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<address, BuybackAccount>(&mut arg0.accounts, arg1);
        assert!(!v0.activity_minted, 37);
        v0.activity_minted = true;
    }

    fun close_buyback_epoch(arg0: &mut Buyback, arg1: &mut 0x2::tx_context::TxContext) {
        assert_enabled(arg0, 3);
        assert!(arg0.epoch_open, 5);
        assert_pool_matches_quotas(arg0);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.pool);
        arg0.epoch_open = false;
        arg0.quota_unspent = 0;
        let v1 = BuybackEpochClosed{
            epoch        : arg0.epoch,
            sui_returned : v0,
            sui_paid     : arg0.sui_paid,
        };
        0x2::event::emit<BuybackEpochClosed>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v0), arg1), arg0.treasury);
    }

    fun credit_account(arg0: &mut Buyback, arg1: address, arg2: u64, arg3: u64) {
        ensure_account(arg0, arg1, arg2);
        let v0 = 0x2::table::borrow_mut<address, BuybackAccount>(&mut arg0.accounts, arg1);
        assert!(!v0.quota_credited, 33);
        v0.quota_credited = true;
        v0.remaining_sui = arg3;
    }

    fun credit_sell_quota(arg0: &mut Buyback, arg1: address, arg2: u64, arg3: u64) {
        assert_enabled(arg0, 1);
        assert!(arg0.epoch_open, 5);
        assert!(arg3 == arg0.epoch, 34);
        assert!(arg2 > 0, 1);
        let v0 = checked_add(arg0.quota_assigned, arg2);
        assert!(v0 <= arg0.deposit, 12);
        credit_account(arg0, arg1, arg3, arg2);
        arg0.quota_assigned = v0;
        arg0.quota_unspent = checked_add(arg0.quota_unspent, arg2);
        assert_pool_matches_quotas(arg0);
        let v1 = SellQuotaCredited{
            epoch      : arg3,
            recipient  : arg1,
            sui_amount : arg2,
        };
        0x2::event::emit<SellQuotaCredited>(v1);
    }

    fun debit_quota(arg0: &mut Buyback, arg1: address, arg2: u64, arg3: u64) {
        assert!(0x2::table::contains<address, BuybackAccount>(&arg0.accounts, arg1), 13);
        let v0 = 0x2::table::borrow_mut<address, BuybackAccount>(&mut arg0.accounts, arg1);
        assert!(v0.epoch == arg2, 13);
        assert!(v0.remaining_sui >= arg3, 13);
        v0.remaining_sui = v0.remaining_sui - arg3;
    }

    fun ensure_account(arg0: &mut Buyback, arg1: address, arg2: u64) {
        if (!0x2::table::contains<address, BuybackAccount>(&arg0.accounts, arg1)) {
            let v0 = BuybackAccount{
                epoch            : arg2,
                quota_credited   : false,
                activity_minted  : false,
                remaining_sui    : 0,
                points_purchased : 0,
            };
            0x2::table::add<address, BuybackAccount>(&mut arg0.accounts, arg1, v0);
        };
        let v1 = 0x2::table::borrow_mut<address, BuybackAccount>(&mut arg0.accounts, arg1);
        if (v1.epoch != arg2) {
            v1.epoch = arg2;
            v1.quota_credited = false;
            v1.activity_minted = false;
            v1.remaining_sui = 0;
            v1.points_purchased = 0;
        };
    }

    public fun epoch_sell_price(arg0: &Buyback) : u64 {
        arg0.epoch_price
    }

    fun mint_cost(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = arg1;
        let v1 = 0;
        while (arg2 > 0) {
            let v2 = 210000 - v0 % 210000;
            let v3 = if (arg2 < v2) {
                arg2
            } else {
                v2
            };
            v1 = v1 + (v3 as u128) * (arg0 as u128);
            arg2 = arg2 - v3;
            v0 = checked_add(v0, v2);
            if (v0 % 210000 == 0) {
                arg0 = bump_price(arg0);
            };
        };
        u64_from_u128(v1)
    }

    fun mint_points(arg0: &mut Buyback, arg1: u8, arg2: address, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_enabled(arg0, 2);
        assert!(!arg0.selling_ended, 6);
        assert!(arg3 > 0, 15);
        if (arg1 != 3) {
            assert!(arg0.epoch_open, 5);
            assert!(arg4 == arg0.epoch, 34);
            claim_activity_mint(arg0, arg2, arg4);
            apply_epoch_mint(arg0, arg1, arg3);
        };
        let v0 = arg0.price;
        let v1 = arg0.epoch;
        accrue_minted(arg0, arg3);
        let v2 = 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::create_z_points(arg3, arg2, arg5);
        let v3 = PointsMinted{
            id        : 0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::ZPoints>(&v2),
            recipient : arg2,
            amount    : arg3,
            kind      : arg1,
            epoch     : v1,
            price     : v0,
        };
        0x2::event::emit<PointsMinted>(v3);
        0x2::transfer::public_transfer<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::ZPoints>(v2, arg2);
    }

    fun open_buyback_epoch(arg0: &mut Buyback, arg1: u64, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: u64, arg4: u64, arg5: u64) {
        assert_enabled(arg0, 0);
        assert!(!arg0.selling_ended, 6);
        assert!(!arg0.epoch_open, 4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pool) == 0, 14);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 8);
        assert!(v0 <= arg1, 7);
        let v1 = v0 / arg0.price;
        assert!(v1 > 0, 8);
        assert!(arg5 <= 10000000000, 35);
        let v2 = u64_from_u128((v1 as u128) * (arg5 as u128) / (1000000000 as u128));
        assert!((arg3 as u128) <= ((((v1 as u128) * (25 as u128) / (100 as u128)) as u64) as u128), 9);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        arg0.epoch = checked_add(arg0.epoch, 1);
        arg0.epoch_open = true;
        arg0.deposit = v0;
        arg0.quota_assigned = 0;
        arg0.quota_unspent = 0;
        arg0.sui_paid = 0;
        arg0.sellable_points = v1;
        arg0.epoch_price = arg0.price;
        arg0.purchase_cap = arg3;
        arg0.wallet_purchase_max = arg4;
        arg0.points_purchased = 0;
        arg0.published_minted = 0;
        arg0.mint_numerator = arg5;
        arg0.mint_cap = v2;
        assert_pool_matches_quotas(arg0);
        let v3 = BuybackEpochOpened{
            epoch               : arg0.epoch,
            treasury_cap        : arg1,
            deposit             : v0,
            price               : arg0.price,
            sellable_points     : v1,
            purchase_cap        : arg3,
            wallet_purchase_max : arg4,
            mint_numerator      : arg5,
            mint_cap            : v2,
        };
        0x2::event::emit<BuybackEpochOpened>(v3);
    }

    public fun operator_authorized(arg0: &Buyback, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, address>(&arg0.operators, arg1)
    }

    public fun operator_cap_id(arg0: &BuybackOperatorCap) : 0x2::object::ID {
        0x2::object::id<BuybackOperatorCap>(arg0)
    }

    public fun operator_close_buyback_epoch(arg0: &BuybackOperatorCap, arg1: &mut Buyback, arg2: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg1, arg0);
        close_buyback_epoch(arg1, arg2);
    }

    public fun operator_credit_sell_quota(arg0: &BuybackOperatorCap, arg1: &mut Buyback, arg2: address, arg3: u64, arg4: u64) {
        assert_operator(arg1, arg0);
        credit_sell_quota(arg1, arg2, arg3, arg4);
    }

    public fun operator_mint_points(arg0: &BuybackOperatorCap, arg1: &mut Buyback, arg2: u8, arg3: address, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert_operator(arg1, arg0);
        assert!(arg2 != 3, 32);
        assert!(arg3 != *0x2::table::borrow<0x2::object::ID, address>(&arg1.operators, 0x2::object::id<BuybackOperatorCap>(arg0)), 36);
        assert!(arg3 != 0x2::tx_context::sender(arg6), 36);
        mint_points(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun operator_open_buyback_epoch(arg0: &BuybackOperatorCap, arg1: &mut Buyback, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: u64, arg5: u64, arg6: u64) {
        assert_operator(arg1, arg0);
        open_buyback_epoch(arg1, arg2, arg3, arg4, arg5, arg6);
    }

    public fun point_price(arg0: &Buyback) : u64 {
        arg0.price
    }

    public fun points_minted_supply(arg0: &Buyback) : u64 {
        arg0.points_minted
    }

    fun points_purchased_of(arg0: &Buyback, arg1: address, arg2: u64) : u64 {
        if (!0x2::table::contains<address, BuybackAccount>(&arg0.accounts, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, BuybackAccount>(&arg0.accounts, arg1);
        if (v0.epoch != arg2) {
            0
        } else {
            v0.points_purchased
        }
    }

    public fun quote_points_cost(arg0: &Buyback, arg1: u64) : u64 {
        mint_cost(arg0.price, arg0.points_minted, arg1)
    }

    public fun quote_sell_sui(arg0: &Buyback, arg1: u64) : u64 {
        let v0 = if (arg0.epoch_open) {
            arg0.epoch_price
        } else {
            arg0.price
        };
        sui_for_points(arg1, v0)
    }

    public fun sell_points(arg0: &mut Buyback, arg1: &mut 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::ZPoints, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_enabled(arg0, 4);
        assert!(arg0.epoch_open, 5);
        assert!(!arg0.selling_ended, 6);
        assert!(arg2 > 0 && arg2 <= 0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::z_points_amount(arg1), 15);
        let v0 = arg0.epoch_price;
        let v1 = sui_for_points(arg2, v0);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = arg0.epoch;
        debit_quota(arg0, v2, v3, v1);
        assert!(arg0.quota_unspent >= v1, 14);
        assert!(within_cap(arg0.sui_paid, v1, arg0.deposit), 14);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.pool) >= v1, 14);
        arg0.quota_unspent = arg0.quota_unspent - v1;
        arg0.sui_paid = checked_add(arg0.sui_paid, v1);
        0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::debit_z_points(arg1, arg2);
        let v4 = PointsSold{
            seller    : v2,
            points_id : 0x2::object::id<0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::ZPoints>(arg1),
            points    : arg2,
            sui_paid  : v1,
            price     : v0,
            epoch     : v3,
        };
        0x2::event::emit<PointsSold>(v4);
        assert_pool_matches_quotas(arg0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.pool, v1), arg3)
    }

    public fun sell_quota(arg0: &Buyback, arg1: address) : u64 {
        if (!arg0.epoch_open || !0x2::table::contains<address, BuybackAccount>(&arg0.accounts, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, BuybackAccount>(&arg0.accounts, arg1);
        if (v0.epoch != arg0.epoch) {
            0
        } else {
            v0.remaining_sui
        }
    }

    fun sui_for_points(arg0: u64, arg1: u64) : u64 {
        u64_from_u128((arg0 as u128) * (arg1 as u128))
    }

    fun u64_from_u128(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 26);
        (arg0 as u64)
    }

    public fun wallet_points_purchased(arg0: &Buyback, arg1: address) : u64 {
        points_purchased_of(arg0, arg1, arg0.epoch)
    }

    public fun wallet_purchase_cap(arg0: u64, arg1: u64) : u64 {
        let v0 = arg0 / 10;
        if (v0 > arg1) {
            arg1
        } else {
            v0
        }
    }

    fun within_cap(arg0: u64, arg1: u64, arg2: u64) : bool {
        (arg0 as u128) + (arg1 as u128) <= (arg2 as u128)
    }

    fun witness_admin(arg0: &0xe7e651e4974fe367aa2837712d68081efb299c470242a15e2b9c26ea326159ec::card::AdminCap) {
    }

    // decompiled from Move bytecode v7
}

