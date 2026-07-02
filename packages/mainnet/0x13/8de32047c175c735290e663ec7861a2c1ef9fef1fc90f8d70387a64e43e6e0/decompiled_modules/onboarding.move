module 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::onboarding {
    public fun onboard_deposit_and_join<T0>(arg0: &mut 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::PlayerRegistry, arg1: &mut 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::table_anchor::TableAnchor<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::create_account_inner(arg0, b"", arg7, arg8);
        let v2 = 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::treasury_vault::open_vault_inner<T0>(&mut v1, arg8);
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::treasury_vault::deposit_inner<T0>(&mut v2, arg2);
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::table_anchor::join_table<T0>(arg1, &v1, &mut v2, arg3, arg4, arg7, arg8);
        if (!0x1::vector::is_empty<u8>(&arg5)) {
            0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::session_cap::create_session_cap(&mut v1, arg5, arg6, arg7, arg8);
        };
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::give_account(v1, v0);
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::treasury_vault::give_vault<T0>(v2, v0);
    }

    public fun open_vault_deposit_and_join<T0>(arg0: &mut 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::player_account::PlayerAccount, arg1: &mut 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::table_anchor::TableAnchor<T0>, arg2: 0x2::coin::Coin<T0>, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::treasury_vault::open_vault_inner<T0>(arg0, arg6);
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::treasury_vault::deposit_inner<T0>(&mut v0, arg2);
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::table_anchor::join_table<T0>(arg1, arg0, &mut v0, arg3, arg4, arg5, arg6);
        0x138de32047c175c735290e663ec7861a2c1ef9fef1fc90f8d70387a64e43e6e0::treasury_vault::give_vault<T0>(v0, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

