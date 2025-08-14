module 0xa82cb0dcfa2ac2ccd635e628209775eef382e652f7ee5abd42d00f3de8828053::request {
    struct UpdateRequest<phantom T0> {
        vault_id: 0x2::object::ID,
        account: address,
        deposit: 0x2::coin::Coin<T0>,
        borrow_amount: u64,
        repayment: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>,
        withdraw_amount: u64,
        witnesses: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        memo: 0x1::string::String,
    }

    public fun account<T0>(arg0: &UpdateRequest<T0>) : address {
        arg0.account
    }

    public fun add_witness<T0, T1: drop>(arg0: &mut UpdateRequest<T0>, arg1: T1) {
        let v0 = 0x1::type_name::get<T1>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(witnesses<T0>(arg0), &v0)) {
            err_witness_already_exists();
        };
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.witnesses, v0);
    }

    public fun borrow_amount<T0>(arg0: &UpdateRequest<T0>) : u64 {
        arg0.borrow_amount
    }

    public fun deposit_amount<T0>(arg0: &UpdateRequest<T0>) : u64 {
        0x2::coin::value<T0>(&arg0.deposit)
    }

    public(friend) fun destroy<T0>(arg0: UpdateRequest<T0>) : (0x2::object::ID, address, 0x2::coin::Coin<T0>, u64, 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, u64, 0x2::vec_set::VecSet<0x1::type_name::TypeName>, 0x1::string::String) {
        let UpdateRequest {
            vault_id        : v0,
            account         : v1,
            deposit         : v2,
            borrow_amount   : v3,
            repayment       : v4,
            withdraw_amount : v5,
            witnesses       : v6,
            memo            : v7,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7)
    }

    fun err_witness_already_exists() {
        abort 201
    }

    public fun memo<T0>(arg0: &UpdateRequest<T0>) : 0x1::string::String {
        arg0.memo
    }

    public(friend) fun new<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: 0x2::coin::Coin<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>, arg5: u64, arg6: 0x1::string::String) : UpdateRequest<T0> {
        UpdateRequest<T0>{
            vault_id        : arg0,
            account         : arg1,
            deposit         : arg2,
            borrow_amount   : arg3,
            repayment       : arg4,
            withdraw_amount : arg5,
            witnesses       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            memo            : arg6,
        }
    }

    public fun repay_amount<T0>(arg0: &UpdateRequest<T0>) : u64 {
        0x2::coin::value<0x94c1beb34be4677052e1989cc16c4cddf8b97c706532d2136c33df6c2f5656fa::usdb::USDB>(&arg0.repayment)
    }

    public fun vault_id<T0>(arg0: &UpdateRequest<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun withdraw_amount<T0>(arg0: &UpdateRequest<T0>) : u64 {
        arg0.withdraw_amount
    }

    public fun witnesses<T0>(arg0: &UpdateRequest<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.witnesses
    }

    // decompiled from Move bytecode v6
}

