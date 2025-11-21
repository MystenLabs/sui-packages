module 0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::vault {
    struct Vault<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        vault_type: u8,
    }

    struct Receipt<phantom T0> {
        vault_id: 0x2::object::ID,
        repay_amount: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        vault_type: u8,
        creator: address,
    }

    public entry fun admin_withdraw_all<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, 0x2::balance::value<T0>(&arg1.balance)), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun create_vault<T0>(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = Vault<T0>{
            id         : v0,
            balance    : 0x2::balance::zero<T0>(),
            vault_type : arg0,
        };
        let v2 = VaultCreated{
            vault_id   : 0x2::object::uid_to_inner(&v0),
            coin_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            vault_type : arg0,
            creator    : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<VaultCreated>(v2);
        0x2::transfer::share_object<Vault<T0>>(v1);
    }

    public fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun get_balance<T0>(arg0: &Vault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun loan<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        assert!(0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 4003);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 4002);
        let v0 = Receipt<T0>{
            vault_id     : 0x2::object::id<Vault<T0>>(arg1),
            repay_amount : arg2,
        };
        (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), v0)
    }

    public fun repay<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: Receipt<T0>) {
        let Receipt {
            vault_id     : v0,
            repay_amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault<T0>>(arg0) == v0, 4005);
        assert!(0x2::coin::value<T0>(&arg1) >= v1, 4005);
        0x2::balance::join<T0>(&mut arg0.balance, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun withdraw<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1.vault_type == 1, 4004);
        assert!(0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::is_whitelisted(arg0, 0x2::tx_context::sender(arg3)), 4003);
        assert!(0x2::balance::value<T0>(&arg1.balance) >= arg2, 4002);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3)
    }

    public fun withdraw_all<T0>(arg0: &0x2a93082fb51995e7626ed9a934694b90dbd257ea5606fd5afd244a620ccb1870::admin::Roles, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::balance::value<T0>(&arg1.balance);
        withdraw<T0>(arg0, arg1, v0, arg2)
    }

    // decompiled from Move bytecode v6
}

