module 0xfd59dfaf3bbd9c5cff3a764ee2aecf836468b06bddbd215a0488ada28f897190::vault {
    struct Vault has store, key {
        id: 0x2::object::UID,
        stakers: 0x2::table::Table<address, u64>,
        admin: address,
    }

    struct StakeProof<phantom T0> has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct Pppdf has store, key {
        id: 0x2::object::UID,
        color: u32,
    }

    public fun add_new_coin<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 1);
        0x2::dynamic_field::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, 0x1::type_name::get<T0>(), 0x2::coin::into_balance<T0>(arg1));
    }

    public entry fun create_and_add_dynamic_field_to_vault_object(arg0: &mut Vault, arg1: u32, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Pppdf{
            id    : 0x2::object::new(arg2),
            color : arg1,
        };
        0x2::dynamic_field::add<vector<u8>, Pppdf>(&mut arg0.id, b"NAME", v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Vault{
            id      : 0x2::object::new(arg0),
            stakers : 0x2::table::new<address, u64>(arg0),
            admin   : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Vault>(v0);
    }

    public fun stake<T0>(arg0: &mut Vault, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : StakeProof<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        let v1 = 0x2::tx_context::sender(arg2);
        let v2 = 0x2::coin::value<T0>(&arg1);
        if (0x2::table::contains<address, u64>(&arg0.stakers, v1)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.stakers, v1) = *0x2::table::borrow<address, u64>(&arg0.stakers, v1) + v2;
        } else {
            0x2::table::add<address, u64>(&mut arg0.stakers, v1, v2);
        };
        0x2::balance::join<T0>(0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0), 0x2::coin::into_balance<T0>(arg1));
        StakeProof<T0>{
            id     : 0x2::object::new(arg2),
            amount : v2,
        }
    }

    public fun withdraw_coin<T0>(arg0: &mut Vault, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 1);
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::dynamic_field::exists_<0x1::type_name::TypeName>(&arg0.id, v0), 2);
        let v1 = 0x2::dynamic_field::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(&mut arg0.id, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(v1, 0x2::balance::value<T0>(v1)), arg1), arg0.admin);
    }

    // decompiled from Move bytecode v6
}

