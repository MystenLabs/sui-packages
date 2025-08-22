module 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot_script {
    public fun create_bot<T0: store + key>(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 != @0x0, 13906834204408152063);
        0x2::transfer::public_transfer<0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Bot<T0>>(0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::create_bot<T0>(arg0, arg2), arg1);
    }

    public fun create_vault<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Bot<T0>, arg2: address, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 != @0x0 && arg3 != @0x0, 13906834260242726911);
        0x2::transfer::public_share_object<0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Vault>(0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::create_vault<T0>(arg0, arg1, arg2, arg3, arg4));
    }

    public fun deposit<T0>(arg0: &mut 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Vault, arg1: 0x2::coin::Coin<T0>) {
        0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
    }

    public fun deposit2<T0, T1>(arg0: &mut 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Vault, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_deposit<T0>(arg0, 0x2::coin::into_balance<T0>(arg1));
        0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_deposit<T1>(arg0, 0x2::coin::into_balance<T1>(arg2));
    }

    public fun init_cex_deposit<T0: store + key, T1, T2>(arg0: &0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Bot<T0>, arg1: &mut 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Vault, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_check_out<T1, T2>(0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::borrow_cap<T0>(arg0), arg1, arg2, arg3);
        if (arg2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg4), 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_cex_deposit_address(arg1));
        } else {
            0x2::balance::destroy_zero<T1>(v0);
        };
        if (arg3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v1, arg4), 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_cex_deposit_address(arg1));
        } else {
            0x2::balance::destroy_zero<T2>(v1);
        };
    }

    public fun withdraw<T0>(arg0: &mut 0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::Vault, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x4b60c67624768773ac5b33049c7f53b4815a85809bdfb75fe0c642b337084f19::bot::vault_withdraw<T0>(arg0, arg1), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

