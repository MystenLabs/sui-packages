module 0xcc35516196ddea93fbc859703b58cc9fef923e7dd40efa3faeb2816dedeb0687::subscription {
    struct SubscriptionService has drop {
        dummy_field: bool,
    }

    struct ServiceCap has store, key {
        id: 0x2::object::UID,
        service_id: 0x2::object::ID,
    }

    struct Service<phantom T0> has key {
        id: 0x2::object::UID,
        price: u64,
        service_name: 0x1::string::String,
        service_owner: address,
        yearly_price_pct: u8,
    }

    struct Receipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        serviceID: 0x2::object::ID,
        expire_date: u64,
        receipt_owner: address,
        paid_amount: u64,
    }

    struct ChargeCap has store, key {
        id: 0x2::object::UID,
        walletID: 0x2::object::ID,
        serviceID: 0x2::object::ID,
        charge_date: u64,
        is_year: bool,
        subscriber: address,
    }

    struct ServiceCreated has copy, drop {
        service_id: 0x2::object::ID,
        service_owner: address,
        price: u64,
    }

    struct Subscribed has copy, drop {
        wallet_id: 0x2::object::ID,
        service_id: 0x2::object::ID,
        payment_registry: 0x2::object::ID,
        payment_nonce: 0x1::ascii::String,
        subscriber: address,
        is_year: bool,
        amount_paid: u64,
        next_charge_date: u64,
    }

    struct FeeCharged has copy, drop {
        wallet_id: 0x2::object::ID,
        service_id: 0x2::object::ID,
        payment_registry: 0x2::object::ID,
        payment_nonce: 0x1::ascii::String,
        subscriber: address,
        amount_paid: u64,
        next_charge_date: u64,
    }

    public fun charge_fee<T0>(arg0: &mut ChargeCap, arg1: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg2: &Service<T0>, arg3: &mut 0xbc126f1535fba7d641cb9150ad9eae93b104972586ba20f3c60bfe0e53b69bc6::payment_kit::PaymentRegistry, arg4: 0x1::ascii::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg2.service_owner, 19);
        assert!(0x2::clock::timestamp_ms(arg5) > arg0.charge_date, 0);
        assert!(arg0.walletID == 0x2::object::id<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet>(arg1), 18);
        assert!(arg0.serviceID == 0x2::object::id<Service<T0>>(arg2), 1);
        let (v0, _) = compute_payment<T0>(arg2, arg0.is_year, arg0.charge_date);
        if (arg0.is_year) {
            arg0.charge_date = arg0.charge_date + 31536000000;
        } else {
            arg0.charge_date = arg0.charge_date + 2592000000;
        };
        let v2 = arg2.service_owner;
        let v3 = SubscriptionService{dummy_field: false};
        let (v4, v5) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay_for_payer<SubscriptionService, T0>(arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment_for_payer<SubscriptionService, T0>(v3, v0, v2, arg0.subscriber), arg6);
        0xbc126f1535fba7d641cb9150ad9eae93b104972586ba20f3c60bfe0e53b69bc6::payment_kit::process_registry_payment<T0>(arg3, arg4, v0, v4, 0x1::option::some<address>(v2), arg5, arg6);
        let v6 = SubscriptionService{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<SubscriptionService, T0>(v5, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<SubscriptionService, T0>(v6, v0, v2));
        0x2::transfer::public_transfer<Receipt<T0>>(create_receipt<T0>(arg2, v0, arg0.charge_date, arg6), arg0.subscriber);
        let v7 = FeeCharged{
            wallet_id        : 0x2::object::id<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet>(arg1),
            service_id       : 0x2::object::id<Service<T0>>(arg2),
            payment_registry : 0x2::object::id<0xbc126f1535fba7d641cb9150ad9eae93b104972586ba20f3c60bfe0e53b69bc6::payment_kit::PaymentRegistry>(arg3),
            payment_nonce    : arg4,
            subscriber       : arg0.subscriber,
            amount_paid      : v0,
            next_charge_date : arg0.charge_date,
        };
        0x2::event::emit<FeeCharged>(v7);
    }

    fun compute_payment<T0>(arg0: &Service<T0>, arg1: bool, arg2: u64) : (u64, u64) {
        if (arg1) {
            (arg0.price * 12 * (arg0.yearly_price_pct as u64) / 100, arg2 + 31536000000)
        } else {
            (arg0.price, arg2 + 2592000000)
        }
    }

    fun create_receipt<T0>(arg0: &Service<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Receipt<T0> {
        Receipt<T0>{
            id            : 0x2::object::new(arg3),
            serviceID     : 0x2::object::id<Service<T0>>(arg0),
            expire_date   : arg2,
            receipt_owner : 0x2::tx_context::sender(arg3),
            paid_amount   : arg1,
        }
    }

    public fun create_service<T0>(arg0: u64, arg1: 0x1::string::String, arg2: address, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg2, 19);
        assert!(arg3 <= 100, 2);
        let v0 = Service<T0>{
            id               : 0x2::object::new(arg4),
            price            : arg0,
            service_name     : arg1,
            service_owner    : arg2,
            yearly_price_pct : arg3,
        };
        let v1 = 0x2::object::id<Service<T0>>(&v0);
        let v2 = ServiceCap{
            id         : 0x2::object::new(arg4),
            service_id : v1,
        };
        0x2::transfer::public_transfer<ServiceCap>(v2, arg2);
        0x2::transfer::share_object<Service<T0>>(v0);
        let v3 = ServiceCreated{
            service_id    : v1,
            service_owner : arg2,
            price         : arg0,
        };
        0x2::event::emit<ServiceCreated>(v3);
    }

    public fun get_service_name<T0>(arg0: &Service<T0>) : 0x1::string::String {
        arg0.service_name
    }

    public fun get_service_owner<T0>(arg0: &Service<T0>) : address {
        arg0.service_owner
    }

    public fun get_service_price<T0>(arg0: &Service<T0>) : u64 {
        arg0.price
    }

    public fun get_yearly_price_pct<T0>(arg0: &Service<T0>) : u8 {
        arg0.yearly_price_pct
    }

    public fun subscribe<T0>(arg0: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &Service<T0>, arg2: &mut 0xbc126f1535fba7d641cb9150ad9eae93b104972586ba20f3c60bfe0e53b69bc6::payment_kit::PaymentRegistry, arg3: 0x1::ascii::String, arg4: bool, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = compute_payment<T0>(arg1, arg4, 0x2::clock::timestamp_ms(arg5));
        let v2 = 0x2::tx_context::sender(arg6);
        let v3 = arg1.service_owner;
        let v4 = SubscriptionService{dummy_field: false};
        let (v5, v6) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay<SubscriptionService, T0>(arg0, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment<SubscriptionService, T0>(v4, v0, v3), arg6);
        0xbc126f1535fba7d641cb9150ad9eae93b104972586ba20f3c60bfe0e53b69bc6::payment_kit::process_registry_payment<T0>(arg2, arg3, v0, v5, 0x1::option::some<address>(v3), arg5, arg6);
        let v7 = SubscriptionService{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<SubscriptionService, T0>(v6, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<SubscriptionService, T0>(v7, v0, v3));
        let v8 = ChargeCap{
            id          : 0x2::object::new(arg6),
            walletID    : 0x2::object::id<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet>(arg0),
            serviceID   : 0x2::object::id<Service<T0>>(arg1),
            charge_date : v1,
            is_year     : arg4,
            subscriber  : v2,
        };
        0x2::transfer::public_transfer<ChargeCap>(v8, arg1.service_owner);
        0x2::transfer::public_transfer<Receipt<T0>>(create_receipt<T0>(arg1, v0, v1, arg6), v2);
        let v9 = Subscribed{
            wallet_id        : 0x2::object::id<0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet>(arg0),
            service_id       : 0x2::object::id<Service<T0>>(arg1),
            payment_registry : 0x2::object::id<0xbc126f1535fba7d641cb9150ad9eae93b104972586ba20f3c60bfe0e53b69bc6::payment_kit::PaymentRegistry>(arg2),
            payment_nonce    : arg3,
            subscriber       : v2,
            is_year          : arg4,
            amount_paid      : v0,
            next_charge_date : v1,
        };
        0x2::event::emit<Subscribed>(v9);
    }

    // decompiled from Move bytecode v7
}

