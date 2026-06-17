module 0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_oracle_iface {
    public fun accept_price<T0, T1>(arg0: &mut 0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::Vault<T0, T1>, arg1: &0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::ManagerCap, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::accept_price<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun get_price<T0, T1>(arg0: &0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::Vault<T0, T1>) : u64 {
        0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::get_price<T0, T1>(arg0)
    }

    public fun has_pending_price<T0, T1>(arg0: &0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::Vault<T0, T1>) : bool {
        0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::has_pending_price<T0, T1>(arg0)
    }

    public fun reject_price<T0, T1>(arg0: &mut 0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::Vault<T0, T1>, arg1: &0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::ManagerCap, arg2: &0x2::tx_context::TxContext) {
        0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::reject_price<T0, T1>(arg0, arg1, arg2);
    }

    public fun update_price<T0, T1>(arg0: &mut 0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::Vault<T0, T1>, arg1: &0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::OracleCap, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x94463e1f559f5613df01e8267d477d5cb6433fb9fc7423feb868019d8adc9c7b::stoken_vault::update_price<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

