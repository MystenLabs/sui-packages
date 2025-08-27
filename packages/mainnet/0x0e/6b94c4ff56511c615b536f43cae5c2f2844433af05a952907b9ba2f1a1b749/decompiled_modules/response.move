module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::response {
    struct UpdateResponse<phantom T0> {
        vault_id: 0x2::object::ID,
        account: address,
        coll_amount: u64,
        debt_amount: u64,
        interest_amount: u64,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    public fun account<T0>(arg0: &UpdateResponse<T0>) : address {
        arg0.account
    }

    public fun add_witness<T0, T1: drop>(arg0: &mut UpdateResponse<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(witnesses<T0>(arg0), &v0)) {
            err_witness_already_exists();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, 0x1::type_name::get<T1>());
    }

    public fun coll_amount<T0>(arg0: &UpdateResponse<T0>) : u64 {
        arg0.coll_amount
    }

    public fun debt_amount<T0>(arg0: &UpdateResponse<T0>) : u64 {
        arg0.debt_amount
    }

    public(friend) fun destroy<T0>(arg0: UpdateResponse<T0>) : (0x2::object::ID, address, u64, u64, u64, 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        let UpdateResponse {
            vault_id        : v0,
            account         : v1,
            coll_amount     : v2,
            debt_amount     : v3,
            interest_amount : v4,
            witnesses       : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    fun err_witness_already_exists() {
        abort 301
    }

    public fun interest_amount<T0>(arg0: &UpdateResponse<T0>) : u64 {
        arg0.interest_amount
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) : UpdateResponse<T0> {
        UpdateResponse<T0>{
            vault_id        : arg0,
            account         : arg1,
            coll_amount     : arg2,
            debt_amount     : arg3,
            interest_amount : arg4,
            witnesses       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        }
    }

    public fun vault_id<T0>(arg0: &UpdateResponse<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun witnesses<T0>(arg0: &UpdateResponse<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    // decompiled from Move bytecode v6
}

