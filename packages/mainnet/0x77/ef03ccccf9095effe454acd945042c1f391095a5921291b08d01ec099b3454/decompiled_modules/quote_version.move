module 0x75ff5c395edcae3b2f3dd503b8d611e692dd98bc43c0935d111b7a306f8df419::quote_version {
    struct QuoteVersion has store {
        versions: 0x2::table::Table<address, u64>,
    }

    public fun increment_quote_version(arg0: &mut QuoteVersion, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::table::contains<address, u64>(&arg0.versions, 0x2::tx_context::sender(arg2))) {
            let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.versions, 0x2::tx_context::sender(arg2));
            assert!(arg1 > *v0, 0x75ff5c395edcae3b2f3dd503b8d611e692dd98bc43c0935d111b7a306f8df419::errors::err_quote_version_lte_last_version());
            *v0 = arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.versions, 0x2::tx_context::sender(arg2), arg1);
        };
    }

    public fun new_quote_version(arg0: &mut 0x2::tx_context::TxContext) : QuoteVersion {
        QuoteVersion{versions: 0x2::table::new<address, u64>(arg0)}
    }

    // decompiled from Move bytecode v6
}

