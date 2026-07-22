module 0x592db2001ec424e56643aa608054567e3e51cb7f7e17ee9a2b4a69955193827::payment {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PaymentVault<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        fee_bps: u64,
        fee_recipient: address,
        paused: bool,
        gross_volume: u64,
        payment_count: u64,
        fee_balance: 0x2::balance::Balance<T0>,
        processed_orders: 0x2::table::Table<vector<u8>, bool>,
    }

    struct PaymentCompleted<phantom T0> has copy, drop {
        order_id: vector<u8>,
        payer: address,
        merchant: address,
        gross_amount: u64,
        fee_amount: u64,
        merchant_amount: u64,
    }

    struct CommercePaymentCompleted<phantom T0> has copy, drop {
        order_id: vector<u8>,
        payer: address,
        merchant: address,
        gross_amount: u64,
        concession_bps: u64,
        platform_fee_amount: u64,
        buy_amount: u64,
        merchant_amount: u64,
    }

    struct FeeWithdrawn<phantom T0> has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct ConfigUpdated has copy, drop {
        fee_bps: u64,
        fee_recipient: address,
    }

    struct PauseChanged has copy, drop {
        paused: bool,
    }

    fun assert_current<T0>(arg0: &PaymentVault<T0>) {
        assert!(arg0.version == 2, 4);
    }

    public fun create<T0>(arg0: u64, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 1000, 1);
        assert!(arg1 != @0x0, 6);
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        let v1 = PaymentVault<T0>{
            id               : 0x2::object::new(arg2),
            version          : 2,
            fee_bps          : arg0,
            fee_recipient    : arg1,
            paused           : false,
            gross_volume     : 0,
            payment_count    : 0,
            fee_balance      : 0x2::balance::zero<T0>(),
            processed_orders : 0x2::table::new<vector<u8>, bool>(arg2),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::share_object<PaymentVault<T0>>(v1);
    }

    public fun fee_balance<T0>(arg0: &PaymentVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fee_balance)
    }

    public fun fee_bps<T0>(arg0: &PaymentVault<T0>) : u64 {
        arg0.fee_bps
    }

    public fun fee_recipient<T0>(arg0: &PaymentVault<T0>) : address {
        arg0.fee_recipient
    }

    public fun gross_volume<T0>(arg0: &PaymentVault<T0>) : u64 {
        arg0.gross_volume
    }

    public fun is_order_processed<T0>(arg0: &PaymentVault<T0>, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.processed_orders, arg1)
    }

    public fun is_paused<T0>(arg0: &PaymentVault<T0>) : bool {
        arg0.paused
    }

    public fun migrate<T0>(arg0: &AdminCap, arg1: &mut PaymentVault<T0>) {
        assert!(arg1.version < 2, 8);
        arg1.version = 2;
    }

    public fun pay<T0>(arg0: &mut PaymentVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_current<T0>(arg0);
        assert!(!arg0.paused, 3);
        assert!(arg2 != @0x0, 6);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_orders, arg3), 5);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let (v1, v2) = quote(v0, arg0.fee_bps);
        assert!(v2 > 0, 2);
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg4)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_orders, arg3, true);
        arg0.gross_volume = arg0.gross_volume + v0;
        arg0.payment_count = arg0.payment_count + 1;
        let v3 = PaymentCompleted<T0>{
            order_id        : arg3,
            payer           : 0x2::tx_context::sender(arg4),
            merchant        : arg2,
            gross_amount    : v0,
            fee_amount      : v1,
            merchant_amount : v2,
        };
        0x2::event::emit<PaymentCompleted<T0>>(v3);
    }

    public fun pay_with_concession<T0>(arg0: &mut PaymentVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current<T0>(arg0);
        assert!(!arg0.paused, 3);
        assert!(arg2 != @0x0, 6);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_orders, arg3), 5);
        assert!(arg4 >= 300 && arg4 <= 9900, 9);
        assert!(arg4 >= arg0.fee_bps, 9);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let (v1, v2, v3) = quote_commerce(v0, arg0.fee_bps, arg4);
        assert!(v3 > 0, 2);
        let v4 = v1 + v2;
        if (v4 > 0) {
            0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg5)));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_orders, arg3, true);
        arg0.gross_volume = arg0.gross_volume + v0;
        arg0.payment_count = arg0.payment_count + 1;
        let v5 = CommercePaymentCompleted<T0>{
            order_id            : arg3,
            payer               : 0x2::tx_context::sender(arg5),
            merchant            : arg2,
            gross_amount        : v0,
            concession_bps      : arg4,
            platform_fee_amount : v1,
            buy_amount          : v2,
            merchant_amount     : v3,
        };
        0x2::event::emit<CommercePaymentCompleted<T0>>(v5);
    }

    public fun pay_with_concession_for_swap<T0>(arg0: &mut PaymentVault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_current<T0>(arg0);
        assert!(!arg0.paused, 3);
        assert!(arg2 != @0x0, 6);
        assert!(!0x1::vector::is_empty<u8>(&arg3), 2);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.processed_orders, arg3), 5);
        assert!(arg4 >= 300 && arg4 <= 9900, 9);
        assert!(arg4 >= arg0.fee_bps, 9);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        let (v1, v2, v3) = quote_commerce(v0, arg0.fee_bps, arg4);
        assert!(v3 > 0 && v2 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.fee_balance, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v1, arg5)));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.processed_orders, arg3, true);
        arg0.gross_volume = arg0.gross_volume + v0;
        arg0.payment_count = arg0.payment_count + 1;
        let v4 = CommercePaymentCompleted<T0>{
            order_id            : arg3,
            payer               : 0x2::tx_context::sender(arg5),
            merchant            : arg2,
            gross_amount        : v0,
            concession_bps      : arg4,
            platform_fee_amount : v1,
            buy_amount          : v2,
            merchant_amount     : v3,
        };
        0x2::event::emit<CommercePaymentCompleted<T0>>(v4);
        0x2::coin::split<T0>(&mut arg1, v2, arg5)
    }

    public fun payment_count<T0>(arg0: &PaymentVault<T0>) : u64 {
        arg0.payment_count
    }

    public fun quote(arg0: u64, arg1: u64) : (u64, u64) {
        assert!(arg0 > 0, 2);
        assert!(arg1 <= 1000, 1);
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        (v0, arg0 - v0)
    }

    public fun quote_commerce(arg0: u64, arg1: u64, arg2: u64) : (u64, u64, u64) {
        assert!(arg0 > 0, 2);
        assert!(arg1 <= 1000, 1);
        assert!(arg2 >= 300 && arg2 <= 9900, 9);
        assert!(arg2 >= arg1, 9);
        let v0 = (((arg0 as u128) * (arg1 as u128) / (10000 as u128)) as u64);
        let v1 = (((arg0 as u128) * (arg2 as u128) / (10000 as u128)) as u64);
        (v0, v1 - v0, arg0 - v1)
    }

    public fun set_config<T0>(arg0: &AdminCap, arg1: &mut PaymentVault<T0>, arg2: u64, arg3: address) {
        assert_current<T0>(arg1);
        assert!(arg2 <= 1000, 1);
        assert!(arg3 != @0x0, 6);
        arg1.fee_bps = arg2;
        arg1.fee_recipient = arg3;
        let v0 = ConfigUpdated{
            fee_bps       : arg2,
            fee_recipient : arg3,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun set_paused<T0>(arg0: &AdminCap, arg1: &mut PaymentVault<T0>, arg2: bool) {
        assert_current<T0>(arg1);
        arg1.paused = arg2;
        let v0 = PauseChanged{paused: arg2};
        0x2::event::emit<PauseChanged>(v0);
    }

    public fun version<T0>(arg0: &PaymentVault<T0>) : u64 {
        arg0.version
    }

    public fun withdraw_all_fees<T0>(arg0: &AdminCap, arg1: &mut PaymentVault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current<T0>(arg1);
        let v0 = 0x2::balance::value<T0>(&arg1.fee_balance);
        assert!(v0 > 0, 7);
        let v1 = arg1.fee_recipient;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.fee_balance), arg2), v1);
        let v2 = FeeWithdrawn<T0>{
            recipient : v1,
            amount    : v0,
        };
        0x2::event::emit<FeeWithdrawn<T0>>(v2);
    }

    public fun withdraw_fees<T0>(arg0: &AdminCap, arg1: &mut PaymentVault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current<T0>(arg1);
        assert!(arg2 > 0 && arg2 <= 0x2::balance::value<T0>(&arg1.fee_balance), 7);
        let v0 = arg1.fee_recipient;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.fee_balance, arg2), arg3), v0);
        let v1 = FeeWithdrawn<T0>{
            recipient : v0,
            amount    : arg2,
        };
        0x2::event::emit<FeeWithdrawn<T0>>(v1);
    }

    // decompiled from Move bytecode v7
}

