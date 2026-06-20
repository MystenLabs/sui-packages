module 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::manage {
    public fun batch_import_user_base_data<T0, T1>(arg0: &0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::owner::OwnerCap, arg1: &mut 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::Contract<T0, T1>, arg2: vector<address>, arg3: vector<address>, arg4: vector<vector<address>>, arg5: vector<u8>, arg6: &0x2::tx_context::TxContext) {
        0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::batch_import_user_base_data<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun init_contract<T0, T1>(arg0: &0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::owner::OwnerCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::init_contract<T0, T1>(arg1, arg2);
    }

    public fun set_admin<T0, T1>(arg0: &0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::owner::OwnerCap, arg1: &mut 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::Contract<T0, T1>, arg2: address) {
        0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::set_admin<T0, T1>(arg1, arg2);
    }

    public fun set_price_oracle_rebot(arg0: &0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::owner::OwnerCap, arg1: &mut 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::price_oracle::PriceOracle, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::price_oracle::update_rebot(arg1, arg2);
    }

    public fun set_sunset_rebot<T0, T1>(arg0: &0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::owner::OwnerCap, arg1: &mut 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::Contract<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::set_rebot<T0, T1>(arg1, arg2);
    }

    public fun set_withdraw_fee_recipient<T0, T1>(arg0: &0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::owner::OwnerCap, arg1: &mut 0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::Contract<T0, T1>, arg2: address) {
        0xb4d655e7d6cfe525bba14215811b532478d4c78c94ab500543861f1437666331::sunset::set_withdraw_fee_recipient<T0, T1>(arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

