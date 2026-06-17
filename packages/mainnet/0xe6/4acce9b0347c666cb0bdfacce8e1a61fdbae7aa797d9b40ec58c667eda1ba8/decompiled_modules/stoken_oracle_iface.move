module 0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_oracle_iface {
    public fun accept_price<T0, T1>(arg0: &mut 0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::Vault<T0, T1>, arg1: &0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::accept_price<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun get_price<T0, T1>(arg0: &0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::Vault<T0, T1>) : u64 {
        0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::get_price<T0, T1>(arg0)
    }

    public fun has_pending_price<T0, T1>(arg0: &0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::Vault<T0, T1>) : bool {
        0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::has_pending_price<T0, T1>(arg0)
    }

    public fun reject_price<T0, T1>(arg0: &mut 0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::Vault<T0, T1>, arg1: &0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::ManagerCap, arg2: &0x2::tx_context::TxContext) {
        0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::reject_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_price<T0, T1>(arg0: &mut 0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::Vault<T0, T1>, arg1: &0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::OracleCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0xe64acce9b0347c666cb0bdfacce8e1a61fdbae7aa797d9b40ec58c667eda1ba8::stoken_vault::update_price<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

