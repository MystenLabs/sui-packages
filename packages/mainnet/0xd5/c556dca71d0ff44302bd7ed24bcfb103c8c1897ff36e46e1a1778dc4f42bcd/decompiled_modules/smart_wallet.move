module 0xd5c556dca71d0ff44302bd7ed24bcfb103c8c1897ff36e46e1a1778dc4f42bcd::smart_wallet {
    struct SmartWallet has store, key {
        id: 0x2::object::UID,
        admin_address: address,
        executor_addresses: 0x2::vec_set::VecSet<address>,
    }

    public entry fun add_executor(arg0: &mut SmartWallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 1);
        assert!(!0x2::vec_set::contains<address>(&arg0.executor_addresses, &arg1), 2);
        0x2::vec_set::insert<address>(&mut arg0.executor_addresses, arg1);
    }

    fun create_wallet(arg0: address, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) : SmartWallet {
        let v0 = 0x2::vec_set::empty<address>();
        if (0x1::vector::is_empty<address>(&arg1)) {
            0x2::vec_set::insert<address>(&mut v0, arg0);
        } else {
            0x2::vec_set::insert<address>(&mut v0, arg0);
            let v1 = 0;
            while (v1 < 0x1::vector::length<address>(&arg1)) {
                let v2 = *0x1::vector::borrow<address>(&arg1, v1);
                if (!0x2::vec_set::contains<address>(&v0, &v2)) {
                    0x2::vec_set::insert<address>(&mut v0, v2);
                };
                v1 = v1 + 1;
            };
        };
        SmartWallet{
            id                 : 0x2::object::new(arg2),
            admin_address      : arg0,
            executor_addresses : v0,
        }
    }

    public fun get_admin_address(arg0: &SmartWallet) : address {
        arg0.admin_address
    }

    public fun get_executor_addresses(arg0: &SmartWallet) : vector<address> {
        0x2::vec_set::into_keys<address>(arg0.executor_addresses)
    }

    public fun get_wallet_uid(arg0: &SmartWallet) : &0x2::object::UID {
        &arg0.id
    }

    public fun get_wallet_uid_mut(arg0: &mut SmartWallet) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun initialize_wallet(arg0: address, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<SmartWallet>(create_wallet(arg0, arg1, arg2));
    }

    public fun is_admin(arg0: &SmartWallet, arg1: address) : bool {
        arg0.admin_address == arg1
    }

    public fun is_executor(arg0: &SmartWallet, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.executor_addresses, &arg1)
    }

    public entry fun remove_executor(arg0: &mut SmartWallet, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin_address, 1);
        assert!(arg1 != arg0.admin_address, 4);
        assert!(0x2::vec_set::contains<address>(&arg0.executor_addresses, &arg1), 3);
        0x2::vec_set::remove<address>(&mut arg0.executor_addresses, &arg1);
    }

    // decompiled from Move bytecode v6
}

