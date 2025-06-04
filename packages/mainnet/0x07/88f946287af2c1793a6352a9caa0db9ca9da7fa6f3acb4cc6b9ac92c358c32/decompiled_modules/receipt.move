module 0x788f946287af2c1793a6352a9caa0db9ca9da7fa6f3acb4cc6b9ac92c358c32::receipt {
    struct SingleAssetReceipt has copy, drop, store {
        vault_id: 0x2::object::ID,
        amount: u64,
        asset_type: 0x1::type_name::TypeName,
    }

    struct MultiAssetReceipt has copy, drop, store {
        vault_id: 0x2::object::ID,
        amounts: vector<u64>,
        asset_types: vector<0x1::type_name::TypeName>,
    }

    struct EmptyReceipt has copy, drop, store {
        vault_id: 0x2::object::ID,
    }

    public fun add_multiple_receipt_amount(arg0: &mut MultiAssetReceipt, arg1: u64) {
        0x1::vector::push_back<u64>(&mut arg0.amounts, arg1);
    }

    public fun add_multiple_receipt_asset_type(arg0: &mut MultiAssetReceipt, arg1: 0x1::type_name::TypeName) {
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg0.asset_types, arg1);
    }

    public(friend) fun drop_empty_receipt(arg0: EmptyReceipt) {
        let EmptyReceipt {  } = arg0;
    }

    public(friend) fun drop_multiple_receipt(arg0: MultiAssetReceipt) {
        let MultiAssetReceipt {
            vault_id    : _,
            amounts     : v1,
            asset_types : v2,
        } = arg0;
        let v3 = v2;
        let v4 = v1;
        if (0x1::vector::length<u64>(&v4) != 0) {
            err_receipt_existed_value();
        };
        if (0x1::vector::length<0x1::type_name::TypeName>(&v3) != 0) {
            err_receipt_existed_value();
        };
    }

    public(friend) fun drop_single_receipt(arg0: SingleAssetReceipt) {
        let SingleAssetReceipt {
            vault_id   : _,
            amount     : _,
            asset_type : _,
        } = arg0;
    }

    public fun empty_receipt_vault_id(arg0: EmptyReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    fun err_receipt_existed_value() {
        abort 0
    }

    public fun multiple_asset_receipt_amounts(arg0: MultiAssetReceipt) : vector<u64> {
        arg0.amounts
    }

    public fun multiple_asset_receipt_asset_type(arg0: MultiAssetReceipt) : vector<0x1::type_name::TypeName> {
        arg0.asset_types
    }

    public fun multiple_asset_receipt_vault_id(arg0: MultiAssetReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    public(friend) fun new_empty_receipt(arg0: 0x2::object::ID) : EmptyReceipt {
        EmptyReceipt{vault_id: arg0}
    }

    public(friend) fun new_multiple_asset_receipt(arg0: 0x2::object::ID, arg1: 0x1::option::Option<vector<0x1::type_name::TypeName>>, arg2: 0x1::option::Option<vector<u64>>) : MultiAssetReceipt {
        let v0 = MultiAssetReceipt{
            vault_id    : arg0,
            amounts     : 0x1::vector::empty<u64>(),
            asset_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        if (0x1::option::is_some<vector<u64>>(&arg2)) {
            v0.amounts = 0x1::option::destroy_some<vector<u64>>(arg2);
        };
        if (0x1::option::is_some<vector<0x1::type_name::TypeName>>(&arg1)) {
            v0.asset_types = 0x1::option::destroy_some<vector<0x1::type_name::TypeName>>(arg1);
        };
        v0
    }

    public(friend) fun new_single_asset_receipt(arg0: 0x2::object::ID, arg1: 0x1::type_name::TypeName, arg2: 0x1::option::Option<u64>) : SingleAssetReceipt {
        let v0 = SingleAssetReceipt{
            vault_id   : arg0,
            amount     : 0,
            asset_type : arg1,
        };
        if (0x1::option::is_some<u64>(&arg2)) {
            v0.amount = 0x1::option::destroy_some<u64>(arg2);
        };
        v0
    }

    public fun set_multiple_receipt_vault_id(arg0: &mut MultiAssetReceipt, arg1: 0x2::object::ID) {
        arg0.vault_id = arg1;
    }

    public fun set_single_receipt_amount(arg0: &mut SingleAssetReceipt, arg1: u64) {
        arg0.amount = arg1;
    }

    public fun set_single_receipt_asset_type(arg0: &mut SingleAssetReceipt, arg1: 0x1::type_name::TypeName) {
        arg0.asset_type = arg1;
    }

    public fun set_single_receipt_vault_id(arg0: &mut SingleAssetReceipt, arg1: 0x2::object::ID) {
        arg0.vault_id = arg1;
    }

    public fun single_asset_receipt_amount(arg0: SingleAssetReceipt) : u64 {
        arg0.amount
    }

    public fun single_asset_receipt_asset_type(arg0: SingleAssetReceipt) : 0x1::type_name::TypeName {
        arg0.asset_type
    }

    public fun single_asset_receipt_vault_id(arg0: SingleAssetReceipt) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

