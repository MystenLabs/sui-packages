module 0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::wallet {
    struct Vault<phantom T0: store> has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<T0>,
    }

    public fun create_vault<T0: store>(arg0: &mut 0x2::tx_context::TxContext) {
        0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::asserts::sender_is_admin(arg0);
        let v0 = Vault<T0>{
            id   : 0x2::object::new(arg0),
            coin : 0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::zero<T0>(arg0),
        };
        0x2::transfer::share_object<Vault<T0>>(v0);
    }

    public fun deposit_or_destroy<T0: store>(arg0: &mut Vault<T0>, arg1: 0x2::coin::Coin<T0>) {
        if (0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::get_coin_amount<T0>(&arg1) == 0) {
            0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::destroy_zero<T0>(arg1);
        } else {
            0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::join_coin<T0>(&mut arg0.coin, arg1);
        };
    }

    public fun withdraw_all<T0: store>(arg0: &mut Vault<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::asserts::sender_is_admin(arg2);
        0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::asserts::payout_amount<T0>(&arg0.coin);
        0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::send_coin<T0>(0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::split_coin<T0>(&mut arg0.coin, arg1, arg2), 0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::admin::get_address());
    }

    // decompiled from Move bytecode v6
}

