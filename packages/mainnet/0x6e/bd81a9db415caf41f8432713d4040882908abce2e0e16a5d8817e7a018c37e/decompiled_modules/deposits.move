module 0x6ebd81a9db415caf41f8432713d4040882908abce2e0e16a5d8817e7a018c37e::deposits {
    struct UserDeposit has store, key {
        id: 0x2::object::UID,
    }

    struct DepositRegistry has store, key {
        id: 0x2::object::UID,
        user_deposits: 0x2::object_table::ObjectTable<vector<u8>, UserDeposit>,
    }

    public fun borrow_deposit_mut(arg0: &mut DepositRegistry, arg1: address, arg2: u64) : &mut 0x2::object::UID {
        let v0 = encode_key(arg1, arg2);
        if (!0x2::object_table::contains<vector<u8>, UserDeposit>(&arg0.user_deposits, v0)) {
            let v1 = UserDeposit{id: 0x2::derived_object::claim<vector<u8>>(&mut arg0.id, v0)};
            0x2::object_table::add<vector<u8>, UserDeposit>(&mut arg0.user_deposits, v0, v1);
        };
        &mut 0x2::object_table::borrow_mut<vector<u8>, UserDeposit>(&mut arg0.user_deposits, v0).id
    }

    public fun deposit_address(arg0: 0x2::object::ID, arg1: address, arg2: u64) : address {
        0x2::derived_object::derive_address<vector<u8>>(arg0, encode_key(arg1, arg2))
    }

    fun encode_key(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::address::to_bytes(arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : DepositRegistry {
        DepositRegistry{
            id            : 0x2::object::new(arg0),
            user_deposits : 0x2::object_table::new<vector<u8>, UserDeposit>(arg0),
        }
    }

    // decompiled from Move bytecode v7
}

