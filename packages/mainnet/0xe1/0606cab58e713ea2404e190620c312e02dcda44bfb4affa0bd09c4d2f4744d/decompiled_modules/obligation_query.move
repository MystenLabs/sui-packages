module 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation_query {
    struct ObligationBorrow has copy, drop {
        asset: 0x1::type_name::TypeName,
        borrow_index: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
        debt: 0xf01bf3d01c8f50247fdf597e3f565b865e00b4a20a01b353d44d71c993f36e9a::float::Decimal,
    }

    struct ObligationDeposit has copy, drop {
        asset: 0x1::type_name::TypeName,
        ctoken_amount: u64,
    }

    struct ObligationDetail has copy, drop {
        emode_group_id: u8,
        borrows: vector<ObligationBorrow>,
        deposits: vector<ObligationDeposit>,
    }

    public fun get_obligation_assets<T0>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg1: 0x2::object::ID) : (vector<0x1::type_name::TypeName>, vector<0x1::type_name::TypeName>) {
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::borrow_obligation<T0>(arg0, arg1);
        (0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::debt_types<T0>(v0), 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::deposit_types<T0>(v0))
    }

    public fun get_obligation_overview<T0>(arg0: &0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::Market<T0>, arg1: 0x2::object::ID) : ObligationDetail {
        let v0 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::market::borrow_obligation<T0>(arg0, arg1);
        let v1 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::deposit_types<T0>(v0);
        let v2 = 0x1::vector::empty<ObligationDeposit>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v3);
            let v5 = ObligationDeposit{
                asset         : v4,
                ctoken_amount : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::ctoken_amount_by_coin<T0>(v0, v4),
            };
            0x1::vector::push_back<ObligationDeposit>(&mut v2, v5);
            v3 = v3 + 1;
        };
        let v6 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::debt_types<T0>(v0);
        let v7 = 0x1::vector::empty<ObligationBorrow>();
        v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v6)) {
            let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v6, v3);
            let v9 = 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::debt<T0>(v0, v8);
            let v10 = ObligationBorrow{
                asset        : v8,
                borrow_index : *0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::debt::borrow_index(v9),
                debt         : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::debt::unsafe_debt_amount(v9),
            };
            0x1::vector::push_back<ObligationBorrow>(&mut v7, v10);
            v3 = v3 + 1;
        };
        ObligationDetail{
            emode_group_id : 0xfeed37bf494357bd6514360ddbeecc820365654ea5fd1461b336cf6595eb3dc2::obligation::emode_group<T0>(v0),
            borrows        : v7,
            deposits       : v2,
        }
    }

    // decompiled from Move bytecode v6
}

