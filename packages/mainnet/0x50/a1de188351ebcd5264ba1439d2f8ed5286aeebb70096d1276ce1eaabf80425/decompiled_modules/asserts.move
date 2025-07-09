module 0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::asserts {
    public(friend) fun address_is_whitelisted(arg0: bool) {
        assert!(arg0, 105);
    }

    public(friend) fun loan_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::get_coin_amount<T0>(arg0) == arg1, 101);
    }

    public(friend) fun payout_amount<T0>(arg0: &0x2::coin::Coin<T0>) {
        assert!(0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::get_coin_amount<T0>(arg0) > 0, 107);
    }

    public(friend) fun profit_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::get_coin_amount<T0>(arg0) >= arg1, 102);
    }

    public(friend) fun sender_is_admin(arg0: &0x2::tx_context::TxContext) {
        assert!(0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::get_sender(arg0) == 0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::admin::get_address(), 104);
    }

    public(friend) fun sender_is_whitelisted(arg0: bool) {
        assert!(arg0, 106);
    }

    public(friend) fun total_amount<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x50a1de188351ebcd5264ba1439d2f8ed5286aeebb70096d1276ce1eaabf80425::tools::get_coin_amount<T0>(arg0) >= arg1, 103);
    }

    // decompiled from Move bytecode v6
}

