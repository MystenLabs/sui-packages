module 0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        allowed: vector<0x2::object::ID>,
        balance: 0x2::balance::Balance<T0>,
        enmergency: bool,
    }

    public(friend) fun claim<T0>(arg0: &mut Vault<T0>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.enmergency, 1002);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.allowed, &arg1), 1001);
        0x2::balance::split<T0>(&mut arg0.balance, arg2)
    }

    entry fun create<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: vector<0x2::object::ID>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id         : 0x2::object::new(arg2),
            allowed    : arg1,
            balance    : 0x2::balance::zero<T0>(),
            enmergency : false,
        };
        0x2::transfer::public_share_object<Vault<T0>>(v0);
    }

    entry fun create_vault<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: vector<0x2::object::ID>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault<T0>{
            id         : 0x2::object::new(arg3),
            allowed    : arg1,
            balance    : 0x2::coin::into_balance<T0>(arg2),
            enmergency : false,
        };
        0x2::transfer::public_share_object<Vault<T0>>(v0);
    }

    entry fun deposit<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Vault<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg1.balance, 0x2::coin::into_balance<T0>(arg2));
    }

    entry fun switch_enmergency<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Vault<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        arg1.enmergency = !arg1.enmergency;
    }

    entry fun withdraw<T0>(arg0: &0x84ecf13cfeabca60cf8278165940a3e651143c0c29b948310e9b8b2bf525e74d::admin::AdminCap, arg1: &mut Vault<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.enmergency, 1002);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance, arg2), arg3), 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v6
}

