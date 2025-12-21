module 0x1a38ab26f41fbbb8b4ce8f745bb56f0ef9c7bb8ed48fdb9cac24ce408d2a38cd::subscription {
    struct PaymentInfo has store {
        reference_id: 0x1::string::String,
        user_id: 0x1::string::String,
        package_name: 0x1::string::String,
        amount: u64,
        paid: bool,
        active: bool,
        payment_date: u64,
        activation_date: 0x1::option::Option<u64>,
        user_address: address,
        expiry_epoch: u64,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct SubscriptionPackage has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        price: u64,
        duration_days: u64,
    }

    struct TreasuryVault<phantom T0: store> has key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    struct AccountSubscription has key {
        id: 0x2::object::UID,
        payments: 0x2::table::Table<0x1::string::String, PaymentInfo>,
        admin: address,
        treasury: address,
        packages: 0x2::table::Table<0x1::string::String, SubscriptionPackage>,
        roles: 0x2::table::Table<address, u64>,
    }

    struct PaymentReceived has copy, drop {
        reference_id: 0x1::string::String,
        amount: u64,
        user_address: address,
        user_id: 0x1::string::String,
        timestamp: u64,
    }

    struct SubscriptionActivated has copy, drop {
        reference_id: 0x1::string::String,
        user_address: address,
        activation_date: u64,
    }

    struct AdminChanged has copy, drop {
        old_admin: address,
        new_admin: address,
    }

    struct TreasuryChanged has copy, drop {
        old_treasury: address,
        new_treasury: address,
    }

    struct PackageAdded has copy, drop {
        name: 0x1::string::String,
        price: u64,
        duration_days: u64,
    }

    struct RoleGranted has copy, drop {
        grantee: address,
        roles_mask: u64,
        granted_by: address,
        timestamp: u64,
    }

    struct RoleRevoked has copy, drop {
        grantee: address,
        roles_mask: u64,
        revoked_by: address,
        timestamp: u64,
    }

    public entry fun activate_subscription(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, PaymentInfo>(&mut arg0.payments, v0);
        assert!(v1.paid, 3);
        assert!(!v1.active, 4);
        v1.active = true;
        v1.activation_date = 0x1::option::some<u64>(0x2::tx_context::epoch(arg3));
        let v2 = SubscriptionActivated{
            reference_id    : v0,
            user_address    : v1.user_address,
            activation_date : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<SubscriptionActivated>(v2);
    }

    public entry fun activate_subscription_by_role(arg0: &mut AccountSubscription, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg2), 1), 7);
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        let v1 = 0x2::table::borrow_mut<0x1::string::String, PaymentInfo>(&mut arg0.payments, v0);
        assert!(v1.paid, 3);
        assert!(!v1.active, 4);
        v1.active = true;
        v1.activation_date = 0x1::option::some<u64>(0x2::tx_context::epoch(arg2));
        let v2 = SubscriptionActivated{
            reference_id    : v0,
            user_address    : v1.user_address,
            activation_date : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<SubscriptionActivated>(v2);
    }

    public entry fun add_package(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = SubscriptionPackage{
            id            : 0x2::object::new(arg5),
            name          : 0x1::string::utf8(arg2),
            price         : arg3,
            duration_days : arg4,
        };
        let v1 = 0x1::string::utf8(arg2);
        0x2::table::add<0x1::string::String, SubscriptionPackage>(&mut arg0.packages, v1, v0);
        let v2 = PackageAdded{
            name          : v1,
            price         : arg3,
            duration_days : arg4,
        };
        0x2::event::emit<PackageAdded>(v2);
    }

    public entry fun add_package_by_role(arg0: &mut AccountSubscription, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg4), 2), 7);
        let v0 = SubscriptionPackage{
            id            : 0x2::object::new(arg4),
            name          : 0x1::string::utf8(arg1),
            price         : arg2,
            duration_days : arg3,
        };
        let v1 = 0x1::string::utf8(arg1);
        0x2::table::add<0x1::string::String, SubscriptionPackage>(&mut arg0.packages, v1, v0);
        let v2 = PackageAdded{
            name          : v1,
            price         : arg2,
            duration_days : arg3,
        };
        0x2::event::emit<PackageAdded>(v2);
    }

    public entry fun change_admin(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: address) {
        arg0.admin = arg2;
        let v0 = AdminChanged{
            old_admin : arg0.admin,
            new_admin : arg2,
        };
        0x2::event::emit<AdminChanged>(v0);
    }

    public entry fun change_treasury(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: address) {
        arg0.treasury = arg2;
        let v0 = TreasuryChanged{
            old_treasury : arg0.treasury,
            new_treasury : arg2,
        };
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public entry fun change_treasury_by_role(arg0: &mut AccountSubscription, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(has_role(arg0, 0x2::tx_context::sender(arg2), 4), 7);
        arg0.treasury = arg1;
        let v0 = TreasuryChanged{
            old_treasury : arg0.treasury,
            new_treasury : arg1,
        };
        0x2::event::emit<TreasuryChanged>(v0);
    }

    public entry fun create_vault<T0: store>(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryVault<T0>{
            id   : 0x2::object::new(arg2),
            coin : 0x2::coin::zero<T0>(arg2),
        };
        0x2::transfer::share_object<TreasuryVault<T0>>(v0);
    }

    public fun get_activation_date(arg0: &AccountSubscription, arg1: vector<u8>) : 0x1::option::Option<u64> {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).activation_date
    }

    public fun get_expiry_epoch(arg0: &AccountSubscription, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).expiry_epoch
    }

    public fun get_package_duration_days(arg0: &AccountSubscription, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, SubscriptionPackage>(&arg0.packages, v0), 6);
        0x2::table::borrow<0x1::string::String, SubscriptionPackage>(&arg0.packages, v0).duration_days
    }

    public fun get_package_info(arg0: &AccountSubscription, arg1: vector<u8>) : (0x1::string::String, u64, u64) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, SubscriptionPackage>(&arg0.packages, v0), 6);
        let v1 = 0x2::table::borrow<0x1::string::String, SubscriptionPackage>(&arg0.packages, v0);
        (v1.name, v1.price, v1.duration_days)
    }

    public fun get_package_price(arg0: &AccountSubscription, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, SubscriptionPackage>(&arg0.packages, v0), 6);
        0x2::table::borrow<0x1::string::String, SubscriptionPackage>(&arg0.packages, v0).price
    }

    public fun get_payment_amount(arg0: &AccountSubscription, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).amount
    }

    public fun get_payment_date(arg0: &AccountSubscription, arg1: vector<u8>) : u64 {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).payment_date
    }

    public fun get_payment_status(arg0: &AccountSubscription, arg1: vector<u8>) : (bool, bool, u64, 0x1::option::Option<u64>, address, 0x1::string::String) {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        let v1 = 0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0);
        (v1.paid, v1.active, v1.payment_date, v1.activation_date, v1.user_address, v1.user_id)
    }

    public fun get_user_address(arg0: &AccountSubscription, arg1: vector<u8>) : address {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).user_address
    }

    public entry fun grant_role(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.roles, arg2)) {
            0x2::table::remove<address, u64>(&mut arg0.roles, arg2);
            0x2::table::add<address, u64>(&mut arg0.roles, arg2, *0x2::table::borrow<address, u64>(&arg0.roles, arg2) | arg3);
        } else {
            0x2::table::add<address, u64>(&mut arg0.roles, arg2, arg3);
        };
        let v0 = RoleGranted{
            grantee    : arg2,
            roles_mask : arg3,
            granted_by : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<RoleGranted>(v0);
    }

    public fun has_role(arg0: &AccountSubscription, arg1: address, arg2: u64) : bool {
        if (!0x2::table::contains<address, u64>(&arg0.roles, arg1)) {
            return false
        };
        *0x2::table::borrow<address, u64>(&arg0.roles, arg1) & arg2 != 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = AccountSubscription{
            id       : 0x2::object::new(arg0),
            payments : 0x2::table::new<0x1::string::String, PaymentInfo>(arg0),
            admin    : 0x2::tx_context::sender(arg0),
            treasury : 0x2::tx_context::sender(arg0),
            packages : 0x2::table::new<0x1::string::String, SubscriptionPackage>(arg0),
            roles    : 0x2::table::new<address, u64>(arg0),
        };
        let v2 = SubscriptionPackage{
            id            : 0x2::object::new(arg0),
            name          : 0x1::string::utf8(b"Premium"),
            price         : 10000000000,
            duration_days : 30,
        };
        0x2::table::add<0x1::string::String, SubscriptionPackage>(&mut v1.packages, 0x1::string::utf8(b"premium"), v2);
        0x2::transfer::share_object<AccountSubscription>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_active(arg0: &AccountSubscription, arg1: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).active
    }

    public fun is_paid(arg0: &AccountSubscription, arg1: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(arg1);
        assert!(0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0), 1);
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).paid
    }

    public fun is_subscription_active(arg0: &AccountSubscription, arg1: vector<u8>) : bool {
        let v0 = 0x1::string::utf8(arg1);
        if (!0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0)) {
            return false
        };
        0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0).active
    }

    public fun is_subscription_valid(arg0: &AccountSubscription, arg1: vector<u8>, arg2: u64) : bool {
        let v0 = 0x1::string::utf8(arg1);
        if (!0x2::table::contains<0x1::string::String, PaymentInfo>(&arg0.payments, v0)) {
            return false
        };
        let v1 = 0x2::table::borrow<0x1::string::String, PaymentInfo>(&arg0.payments, v0);
        if (!v1.active) {
            return false
        };
        arg2 <= v1.expiry_epoch
    }

    public entry fun pay_subscription<T0: store>(arg0: &mut AccountSubscription, arg1: &mut TreasuryVault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg3);
        let v1 = 0x1::string::utf8(arg4);
        let v2 = 0x1::string::utf8(arg5);
        let v3 = 0x2::tx_context::sender(arg6);
        let v4 = 0x2::coin::value<T0>(&arg2);
        assert!(0x2::table::contains<0x1::string::String, SubscriptionPackage>(&arg0.packages, v2), 6);
        assert!(v4 > 0, 0);
        let v5 = 0x2::tx_context::epoch(arg6);
        let v6 = PaymentInfo{
            reference_id    : v0,
            user_id         : v1,
            package_name    : v2,
            amount          : v4,
            paid            : true,
            active          : true,
            payment_date    : v5,
            activation_date : 0x1::option::some<u64>(v5),
            user_address    : v3,
            expiry_epoch    : v5 + 0x2::table::borrow<0x1::string::String, SubscriptionPackage>(&arg0.packages, v2).duration_days,
        };
        0x2::table::add<0x1::string::String, PaymentInfo>(&mut arg0.payments, v6.reference_id, v6);
        0x2::coin::join<T0>(&mut arg1.coin, arg2);
        let v7 = PaymentReceived{
            reference_id : v0,
            amount       : v4,
            user_address : v3,
            user_id      : v1,
            timestamp    : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<PaymentReceived>(v7);
        let v8 = SubscriptionActivated{
            reference_id    : v0,
            user_address    : v3,
            activation_date : 0x2::tx_context::epoch(arg6),
        };
        0x2::event::emit<SubscriptionActivated>(v8);
    }

    public entry fun pay_subscription_passthrough<T0>(arg0: &mut AccountSubscription, arg1: 0x2::coin::Coin<T0>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg2);
        let v1 = 0x1::string::utf8(arg3);
        let v2 = 0x1::string::utf8(arg4);
        let v3 = 0x2::tx_context::sender(arg5);
        let v4 = 0x2::coin::value<T0>(&arg1);
        assert!(0x2::table::contains<0x1::string::String, SubscriptionPackage>(&arg0.packages, v2), 6);
        assert!(v4 > 0, 0);
        let v5 = 0x2::tx_context::epoch(arg5);
        let v6 = PaymentInfo{
            reference_id    : v0,
            user_id         : v1,
            package_name    : v2,
            amount          : v4,
            paid            : true,
            active          : true,
            payment_date    : v5,
            activation_date : 0x1::option::some<u64>(v5),
            user_address    : v3,
            expiry_epoch    : v5 + 0x2::table::borrow<0x1::string::String, SubscriptionPackage>(&arg0.packages, v2).duration_days,
        };
        0x2::table::add<0x1::string::String, PaymentInfo>(&mut arg0.payments, v6.reference_id, v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, arg0.treasury);
        let v7 = PaymentReceived{
            reference_id : v0,
            amount       : v4,
            user_address : v3,
            user_id      : v1,
            timestamp    : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<PaymentReceived>(v7);
        let v8 = SubscriptionActivated{
            reference_id    : v0,
            user_address    : v3,
            activation_date : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<SubscriptionActivated>(v8);
    }

    public entry fun revoke_role(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.roles, arg2)) {
            let v0 = *0x2::table::borrow<address, u64>(&arg0.roles, arg2) & 18446744073709551615 - arg3;
            0x2::table::remove<address, u64>(&mut arg0.roles, arg2);
            if (v0 != 0) {
                0x2::table::add<address, u64>(&mut arg0.roles, arg2, v0);
            };
        };
        let v1 = RoleRevoked{
            grantee    : arg2,
            roles_mask : arg3,
            revoked_by : 0x2::tx_context::sender(arg4),
            timestamp  : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<RoleRevoked>(v1);
    }

    public entry fun transfer_admin_cap(arg0: &mut AccountSubscription, arg1: AdminCap, arg2: address) {
        0x2::transfer::transfer<AdminCap>(arg1, arg2);
    }

    public entry fun withdraw_to<T0: store>(arg0: &mut AccountSubscription, arg1: &AdminCap, arg2: &mut TreasuryVault<T0>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0);
        assert!(0x2::coin::value<T0>(&arg2.coin) >= arg4, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2.coin, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

