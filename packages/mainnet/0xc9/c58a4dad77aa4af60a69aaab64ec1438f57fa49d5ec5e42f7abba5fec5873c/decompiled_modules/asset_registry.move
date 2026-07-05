module 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::asset_registry {
    struct XOracleAssetRegistry<phantom T0: store> has store {
        assets: 0x2::table::Table<0x1::type_name::TypeName, T0>,
    }

    public(friend) fun borrow<T0: store>(arg0: &XOracleAssetRegistry<T0>, arg1: 0x1::type_name::TypeName) : &T0 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, T0>(&arg0.assets, arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::asset_not_registered());
        0x2::table::borrow<0x1::type_name::TypeName, T0>(&arg0.assets, arg1)
    }

    public(friend) fun borrow_mut<T0: store>(arg0: &mut XOracleAssetRegistry<T0>, arg1: 0x1::type_name::TypeName) : &mut T0 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, T0>(&arg0.assets, arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::asset_not_registered());
        0x2::table::borrow_mut<0x1::type_name::TypeName, T0>(&mut arg0.assets, arg1)
    }

    public(friend) fun has_asset<T0: store>(arg0: &XOracleAssetRegistry<T0>, arg1: 0x1::type_name::TypeName) : bool {
        0x2::table::contains<0x1::type_name::TypeName, T0>(&arg0.assets, arg1)
    }

    public(friend) fun new_registry<T0: store>(arg0: &mut 0x2::tx_context::TxContext) : XOracleAssetRegistry<T0> {
        XOracleAssetRegistry<T0>{assets: 0x2::table::new<0x1::type_name::TypeName, T0>(arg0)}
    }

    public(friend) fun set<T0: store>(arg0: &mut XOracleAssetRegistry<T0>, arg1: 0x1::type_name::TypeName, arg2: T0) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, T0>(&arg0.assets, arg1), 0x3ab32fb563444cc2269cb3516e93ee8a6917f9ef1b7f7f9dd98d61c66d425245::oracle_error::asset_already_registered());
        0x2::table::add<0x1::type_name::TypeName, T0>(&mut arg0.assets, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

