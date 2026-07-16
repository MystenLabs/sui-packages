module 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent {
    struct PaymentValidated has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::type_name::TypeName,
        mode: u8,
        payer: 0x1::option::Option<address>,
        recipient: address,
        amount: u64,
    }

    struct PaymentVerified has copy, drop {
        service: 0x1::type_name::TypeName,
        amount: u64,
        recipient: address,
    }

    struct SwapValidated has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::type_name::TypeName,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        spender: address,
        amount_in: u64,
        min_amount_out: u64,
    }

    struct SwapVerified has copy, drop {
        wallet_id: 0x2::object::ID,
        service: 0x1::type_name::TypeName,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    struct ServiceSig<phantom T0, phantom T1> {
        amount: u64,
        recipient: address,
    }

    struct ServiceSigForPayer<phantom T0, phantom T1> {
        amount: u64,
        recipient: address,
        payer: address,
    }

    struct ServiceSigUnmetered<phantom T0, phantom T1> {
        amount: u64,
        recipient: address,
    }

    struct WalletWitness<phantom T0, phantom T1> {
        amount: u64,
        recipient: address,
    }

    struct ServiceReceiptSig<phantom T0, phantom T1> {
        amount: u64,
        recipient: address,
    }

    struct SwapSig<phantom T0, phantom T1, phantom T2> {
        amount_in: u64,
        min_amount_out: u64,
    }

    struct WalletSwapWitness<phantom T0, phantom T1, phantom T2> {
        amount_in: u64,
        min_amount_out: u64,
    }

    struct ServiceSwapReceipt<phantom T0, phantom T1, phantom T2> {
        amount_in: u64,
        amount_out: u64,
    }

    public fun create_receipt_sig<T0: drop, T1>(arg0: T0, arg1: u64, arg2: address) : ServiceReceiptSig<T0, T1> {
        ServiceReceiptSig<T0, T1>{
            amount    : arg1,
            recipient : arg2,
        }
    }

    public fun create_swap_receipt<T0: drop, T1, T2>(arg0: T0, arg1: u64, arg2: u64) : ServiceSwapReceipt<T0, T1, T2> {
        ServiceSwapReceipt<T0, T1, T2>{
            amount_in  : arg1,
            amount_out : arg2,
        }
    }

    public fun request_payment<T0: drop, T1>(arg0: T0, arg1: u64, arg2: address) : ServiceSig<T0, T1> {
        ServiceSig<T0, T1>{
            amount    : arg1,
            recipient : arg2,
        }
    }

    public fun request_payment_for_payer<T0: drop, T1>(arg0: T0, arg1: u64, arg2: address, arg3: address) : ServiceSigForPayer<T0, T1> {
        ServiceSigForPayer<T0, T1>{
            amount    : arg1,
            recipient : arg2,
            payer     : arg3,
        }
    }

    public fun request_payment_unmetered<T0: drop, T1>(arg0: T0, arg1: u64, arg2: address) : ServiceSigUnmetered<T0, T1> {
        ServiceSigUnmetered<T0, T1>{
            amount    : arg1,
            recipient : arg2,
        }
    }

    public fun request_swap<T0: drop, T1, T2>(arg0: T0, arg1: u64, arg2: u64) : SwapSig<T0, T1, T2> {
        SwapSig<T0, T1, T2>{
            amount_in      : arg1,
            min_amount_out : arg2,
        }
    }

    public fun validate_and_pay<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: ServiceSig<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, WalletWitness<T0, T1>) {
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::is_authorized<T0, T1>(arg0), 0);
        let ServiceSig {
            amount    : v0,
            recipient : v1,
        } = arg1;
        let v2 = 0x2::tx_context::sender(arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::debit_service_allowance<T0>(arg0, v2, v0);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::debit_coin_allowance<T1>(arg0, v2, v0);
        let v3 = WalletWitness<T0, T1>{
            amount    : v0,
            recipient : v1,
        };
        let v4 = PaymentValidated{
            wallet_id : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            service   : 0x1::type_name::with_defining_ids<T0>(),
            mode      : 0,
            payer     : 0x1::option::some<address>(v2),
            recipient : v1,
            amount    : v0,
        };
        0x2::event::emit<PaymentValidated>(v4);
        (0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::pay_by_service<T0, T1>(arg0, v0, arg2), v3)
    }

    public fun validate_and_pay_for_payer<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: ServiceSigForPayer<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, WalletWitness<T0, T1>) {
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::is_authorized<T0, T1>(arg0), 0);
        let ServiceSigForPayer {
            amount    : v0,
            recipient : v1,
            payer     : v2,
        } = arg1;
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::debit_service_allowance<T0>(arg0, v2, v0);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::debit_coin_allowance<T1>(arg0, v2, v0);
        let v3 = WalletWitness<T0, T1>{
            amount    : v0,
            recipient : v1,
        };
        let v4 = PaymentValidated{
            wallet_id : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            service   : 0x1::type_name::with_defining_ids<T0>(),
            mode      : 1,
            payer     : 0x1::option::some<address>(v2),
            recipient : v1,
            amount    : v0,
        };
        0x2::event::emit<PaymentValidated>(v4);
        (0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::pay_by_service<T0, T1>(arg0, v0, arg2), v3)
    }

    public fun validate_and_pay_unmetered<T0, T1>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: ServiceSigUnmetered<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, WalletWitness<T0, T1>) {
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::is_authorized<T0, T1>(arg0), 0);
        let ServiceSigUnmetered {
            amount    : v0,
            recipient : v1,
        } = arg1;
        let v2 = WalletWitness<T0, T1>{
            amount    : v0,
            recipient : v1,
        };
        let v3 = PaymentValidated{
            wallet_id : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            service   : 0x1::type_name::with_defining_ids<T0>(),
            mode      : 2,
            payer     : 0x1::option::none<address>(),
            recipient : v1,
            amount    : v0,
        };
        0x2::event::emit<PaymentValidated>(v3);
        (0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::pay_by_service<T0, T1>(arg0, v0, arg2), v2)
    }

    public fun validate_and_swap_out<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: SwapSig<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, WalletSwapWitness<T0, T1, T2>) {
        assert!(0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::is_authorized<T0, T1>(arg0), 0);
        let SwapSig {
            amount_in      : v0,
            min_amount_out : v1,
        } = arg1;
        let v2 = 0x2::tx_context::sender(arg2);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::debit_service_allowance<T0>(arg0, v2, v0);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::delegate::debit_coin_allowance<T1>(arg0, v2, v0);
        let v3 = WalletSwapWitness<T0, T1, T2>{
            amount_in      : v0,
            min_amount_out : v1,
        };
        let v4 = SwapValidated{
            wallet_id      : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            service        : 0x1::type_name::with_defining_ids<T0>(),
            coin_in        : 0x1::type_name::with_defining_ids<T1>(),
            coin_out       : 0x1::type_name::with_defining_ids<T2>(),
            spender        : v2,
            amount_in      : v0,
            min_amount_out : v1,
        };
        0x2::event::emit<SwapValidated>(v4);
        (0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::pay_by_service<T0, T1>(arg0, v0, arg2), v3)
    }

    public fun verify_and_clear<T0, T1>(arg0: WalletWitness<T0, T1>, arg1: ServiceReceiptSig<T0, T1>) {
        let WalletWitness {
            amount    : v0,
            recipient : v1,
        } = arg0;
        let ServiceReceiptSig {
            amount    : v2,
            recipient : v3,
        } = arg1;
        assert!(v0 == v2, 1);
        assert!(v1 == v3, 2);
        let v4 = PaymentVerified{
            service   : 0x1::type_name::with_defining_ids<T0>(),
            amount    : v0,
            recipient : v1,
        };
        0x2::event::emit<PaymentVerified>(v4);
    }

    public fun verify_swap_and_credit<T0, T1, T2>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: WalletSwapWitness<T0, T1, T2>, arg2: ServiceSwapReceipt<T0, T1, T2>, arg3: 0x2::coin::Coin<T2>) {
        let WalletSwapWitness {
            amount_in      : v0,
            min_amount_out : v1,
        } = arg1;
        let ServiceSwapReceipt {
            amount_in  : v2,
            amount_out : v3,
        } = arg2;
        assert!(v0 == v2, 3);
        assert!(0x2::coin::value<T2>(&arg3) == v3, 3);
        assert!(v3 >= v1, 4);
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::receive_from_service_internal<T0, T2>(arg0, arg3);
        let v4 = SwapVerified{
            wallet_id  : 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0),
            service    : 0x1::type_name::with_defining_ids<T0>(),
            coin_in    : 0x1::type_name::with_defining_ids<T1>(),
            coin_out   : 0x1::type_name::with_defining_ids<T2>(),
            amount_in  : v2,
            amount_out : v3,
        };
        0x2::event::emit<SwapVerified>(v4);
    }

    public fun wallet_swap_witness_amount_in<T0, T1, T2>(arg0: &WalletSwapWitness<T0, T1, T2>) : u64 {
        arg0.amount_in
    }

    public fun wallet_swap_witness_min_amount_out<T0, T1, T2>(arg0: &WalletSwapWitness<T0, T1, T2>) : u64 {
        arg0.min_amount_out
    }

    public fun wallet_witness_amount<T0, T1>(arg0: &WalletWitness<T0, T1>) : u64 {
        arg0.amount
    }

    public fun wallet_witness_recipient<T0, T1>(arg0: &WalletWitness<T0, T1>) : address {
        arg0.recipient
    }

    // decompiled from Move bytecode v7
}

