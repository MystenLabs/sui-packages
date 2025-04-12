module 0xb6e9a1d39607e354a3536b320a0c016bffdcb9e629c90b3d91ca1f4ce04fc741::vault {
    struct Vault<phantom T0> has store, key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<T0>,
    }

    struct Receipt<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct VaultTable has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::ascii::String, 0x2::object::ID>,
    }

    public entry fun deposit<T0>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.reserve, 0x2::coin::into_balance<T0>(arg1));
        let v0 = Receipt<T0>{
            id     : 0x2::object::new(arg2),
            amount : 0x2::coin::value<T0>(&arg1),
        };
        0x2::transfer::transfer<Receipt<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun get_vault_id<T0>(arg0: &VaultTable, arg1: &0x2::tx_context::TxContext) : 0x2::object::ID {
        *0x2::table::borrow<0x1::ascii::String, 0x2::object::ID>(&arg0.table, 0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultTable{
            id    : 0x2::object::new(arg0),
            table : 0x2::table::new<0x1::ascii::String, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<VaultTable>(v0);
    }

    public entry fun init_vault<T0>(arg0: &mut VaultTable, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (!0x2::table::contains<0x1::ascii::String, 0x2::object::ID>(&arg0.table, v0)) {
            let v1 = Vault<T0>{
                id      : 0x2::object::new(arg1),
                reserve : 0x2::balance::zero<T0>(),
            };
            0x2::table::add<0x1::ascii::String, 0x2::object::ID>(&mut arg0.table, v0, 0x2::object::id<Vault<T0>>(&v1));
            0x2::transfer::share_object<Vault<T0>>(v1);
        };
    }

    public entry fun withdraw<T0>(arg0: &mut Vault<T0>, arg1: Receipt<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        let Receipt {
            id     : v0,
            amount : v1,
        } = arg1;
        assert!(v1 > 0, 1);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.reserve, v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

