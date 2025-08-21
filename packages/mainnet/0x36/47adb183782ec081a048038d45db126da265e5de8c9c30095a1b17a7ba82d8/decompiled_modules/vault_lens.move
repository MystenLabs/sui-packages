module 0x3647adb183782ec081a048038d45db126da265e5de8c9c30095a1b17a7ba82d8::vault_lens {
    public fun get_bluefin_position_liquidities(arg0: &0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::BluefinExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x15d6ceabb34c99ea7c05c8c8bad904649b907102053d660ba91bde13d6f4761::bluefin_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_cetus_position_liquidities(arg0: &0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::CetusConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0x917301f5630f4832e28256a20fc4a0cc92818c82c53ed8356ad20925f4bd3493::cetus_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_mmt_position_liquidities(arg0: &0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::MmtExecutorConfig, arg1: vector<0x2::object::ID>) : (vector<0x2::object::ID>, vector<u128>) {
        0xc36caee804c960d701af2f1eaeeab4e52d0456bc89028cd0fe927b2fa5fedd08::mmt_executor::get_position_liquidities(arg0, arg1)
    }

    public fun get_vault_asset_balances<T0, T1>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_vault_asset_balances<T0, T1>(arg0)
    }

    public fun get_withdraw_asset_balances<T0, T1>(arg0: &0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::Vault<T0, T1>) : (vector<0x1::ascii::String>, vector<u128>) {
        0xa6ce917b3fea8d6b32e7811b555f7d00b4364d0d18ea3dcb2cc340420a220a76::vault::get_withdraw_asset_balances<T0, T1>(arg0)
    }

    // decompiled from Move bytecode v6
}

