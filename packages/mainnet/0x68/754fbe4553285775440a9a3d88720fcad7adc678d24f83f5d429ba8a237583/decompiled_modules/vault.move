module 0x68754fbe4553285775440a9a3d88720fcad7adc678d24f83f5d429ba8a237583::vault {
    struct Vault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        withdrawal_amount: u64,
        code: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    public fun empty(arg0: Vault, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_valid_admin_cap(&arg0, &arg1);
        let AdminCap {
            id       : v0,
            vault_id : _,
        } = arg1;
        0x2::object::delete(v0);
        let Vault {
            id                : v2,
            balance           : v3,
            withdrawal_amount : _,
            code              : _,
        } = arg0;
        0x2::object::delete(v2);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg2)
    }

    public fun new(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Vault{
            id                : 0x2::object::new(arg3),
            balance           : 0x2::coin::into_balance<0x2::sui::SUI>(arg0),
            withdrawal_amount : arg1,
            code              : arg2,
        };
        let v1 = AdminCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::uid_to_inner(&v0.id),
        };
        0x2::transfer::share_object<Vault>(v0);
        v1
    }

    fun assert_valid_admin_cap(arg0: &Vault, arg1: &AdminCap) {
        assert!(0x2::object::uid_to_inner(&arg0.id) == arg1.vault_id, 9223372419106865151);
    }

    fun assert_valid_key_code(arg0: &Vault, arg1: &0x68754fbe4553285775440a9a3d88720fcad7adc678d24f83f5d429ba8a237583::key::Key) {
        assert!(arg0.code == 0x68754fbe4553285775440a9a3d88720fcad7adc678d24f83f5d429ba8a237583::key::get_code(arg1), 9223372401926995967);
    }

    public fun withdraw(arg0: &mut Vault, arg1: 0x68754fbe4553285775440a9a3d88720fcad7adc678d24f83f5d429ba8a237583::key::Key, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_valid_key_code(arg0, &arg1);
        0x68754fbe4553285775440a9a3d88720fcad7adc678d24f83f5d429ba8a237583::key::delete(arg1);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg0.withdrawal_amount), arg2)
    }

    // decompiled from Move bytecode v6
}

