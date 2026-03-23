module 0xcd0f021a76678ac50d49f6bb83d4c393321a506bc18b5c42720b37a5b2465bc4::escrow {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct EscrowVault has key {
        id: 0x2::object::UID,
        escrows: 0x2::table::Table<u64, EscrowRecord>,
        discount_coin_fees: 0x2::table::Table<0x1::ascii::String, DiscountConfig>,
        paused: bool,
    }

    struct DiscountConfig has store {
        threshold_base: u64,
        fee_bps: u64,
    }

    struct EscrowRecord has store {
        sender: address,
        recipient: address,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        created_epoch: u64,
        opened: bool,
    }

    struct PaymentEscrowed has copy, drop {
        message_id: u64,
        sender: address,
        recipient: address,
        amount: u64,
        protocol_fee: u64,
    }

    struct PaymentReleased has copy, drop {
        message_id: u64,
        recipient: address,
        amount: u64,
    }

    struct PaymentReclaimed has copy, drop {
        message_id: u64,
        sender: address,
        amount: u64,
    }

    struct VaultPaused has copy, drop {
        paused_by: address,
    }

    struct VaultResumed has copy, drop {
        resumed_by: address,
    }

    struct ESCROW has drop {
        dummy_field: bool,
    }

    public fun escrow_payment(arg0: &mut EscrowVault, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 50000000, 4);
        assert!(arg3 != @0x0, 7);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v2 = v1 * 500 / 10000;
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2));
        let v4 = EscrowRecord{
            sender        : v0,
            recipient     : arg3,
            amount        : v3,
            created_epoch : 0x2::tx_context::epoch(arg5),
            opened        : false,
        };
        0x2::table::add<u64, EscrowRecord>(&mut arg0.escrows, arg2, v4);
        let v5 = PaymentEscrowed{
            message_id   : arg2,
            sender       : v0,
            recipient    : arg3,
            amount       : v1 - v2,
            protocol_fee : v2,
        };
        0x2::event::emit<PaymentEscrowed>(v5);
    }

    public fun escrow_payment_discount<T0>(arg0: &mut EscrowVault, arg1: &mut Treasury, arg2: u64, arg3: address, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= 50000000, 4);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v2 = 500;
        let v3 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        if (0x2::table::contains<0x1::ascii::String, DiscountConfig>(&arg0.discount_coin_fees, v3)) {
            let v4 = 0x2::table::borrow<0x1::ascii::String, DiscountConfig>(&arg0.discount_coin_fees, v3);
            if (0x2::coin::value<T0>(&arg5) >= v4.threshold_base) {
                v2 = v4.fee_bps;
            };
        };
        let v5 = v1 * v2 / 10000;
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v5));
        let v7 = EscrowRecord{
            sender        : v0,
            recipient     : arg3,
            amount        : v6,
            created_epoch : 0x2::tx_context::epoch(arg6),
            opened        : false,
        };
        0x2::table::add<u64, EscrowRecord>(&mut arg0.escrows, arg2, v7);
        let v8 = PaymentEscrowed{
            message_id   : arg2,
            sender       : v0,
            recipient    : arg3,
            amount       : v1 - v5,
            protocol_fee : v5,
        };
        0x2::event::emit<PaymentEscrowed>(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg5, v0);
    }

    fun init(arg0: ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = Treasury{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<Treasury>(v1);
        let v2 = EscrowVault{
            id                 : 0x2::object::new(arg1),
            escrows            : 0x2::table::new<u64, EscrowRecord>(arg1),
            discount_coin_fees : 0x2::table::new<0x1::ascii::String, DiscountConfig>(arg1),
            paused             : false,
        };
        let v3 = DiscountConfig{
            threshold_base : 50000000000000,
            fee_bps        : 150,
        };
        0x2::table::add<0x1::ascii::String, DiscountConfig>(&mut v2.discount_coin_fees, 0x1::ascii::string(b"0x7a321bdf6cd445cfe5f5cad61e7668d001eee2ac2f054175b37913b6e8f1cc84::AOOA::AOOA"), v3);
        0x2::transfer::share_object<EscrowVault>(v2);
    }

    public fun is_paused(arg0: &EscrowVault) : bool {
        arg0.paused
    }

    public fun min_payment() : u64 {
        50000000
    }

    public entry fun pause_vault(arg0: &AdminCap, arg1: &mut EscrowVault, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = true;
        let v0 = VaultPaused{paused_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<VaultPaused>(v0);
    }

    public fun reclaim_payment(arg0: &mut EscrowVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<u64, EscrowRecord>(&mut arg0.escrows, arg1);
        assert!(v1.sender == v0, 2);
        assert!(!v1.opened, 1);
        assert!(0x2::tx_context::epoch(arg2) >= v1.created_epoch + 30, 3);
        v1.opened = true;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.amount);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.amount, v2), arg2), v0);
        let v3 = PaymentReclaimed{
            message_id : arg1,
            sender     : v0,
            amount     : v2,
        };
        0x2::event::emit<PaymentReclaimed>(v3);
    }

    public entry fun register_discount_coin<T0>(arg0: &AdminCap, arg1: &mut EscrowVault, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>());
        assert!(!0x2::table::contains<0x1::ascii::String, DiscountConfig>(&arg1.discount_coin_fees, v0), 5);
        let v1 = DiscountConfig{
            threshold_base : arg2,
            fee_bps        : arg3,
        };
        0x2::table::add<0x1::ascii::String, DiscountConfig>(&mut arg1.discount_coin_fees, v0, v1);
    }

    public fun release_payment(arg0: &mut EscrowVault, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 6);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x2::table::borrow_mut<u64, EscrowRecord>(&mut arg0.escrows, arg1);
        assert!(v1.recipient == v0, 0);
        assert!(!v1.opened, 1);
        v1.opened = true;
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&v1.amount);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1.amount, v2), arg2), v0);
        let v3 = PaymentReleased{
            message_id : arg1,
            recipient  : v0,
            amount     : v2,
        };
        0x2::event::emit<PaymentReleased>(v3);
    }

    public entry fun resume_vault(arg0: &AdminCap, arg1: &mut EscrowVault, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.paused = false;
        let v0 = VaultResumed{resumed_by: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<VaultResumed>(v0);
    }

    public fun treasury_balance(arg0: &Treasury) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public entry fun withdraw_fees(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

