module 0x94e8cb8df7796c7ea57f747f330ef61aedd8f48d48f7ac21bc975708a6ca6a1a::ledger_token {
    struct LedgerToken<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        deny_cap: 0x2::coin::DenyCapV2<T0>,
        metadata_cap: 0x2::coin_registry::MetadataCap<T0>,
        valid_recipients: 0x2::table::Table<address, bool>,
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: 0x2::coin::DenyCapV2<T0>, arg2: 0x2::coin_registry::MetadataCap<T0>, arg3: &mut 0x2::tx_context::TxContext) : LedgerToken<T0> {
        LedgerToken<T0>{
            id               : 0x2::object::new(arg3),
            treasury_cap     : arg0,
            deny_cap         : arg1,
            metadata_cap     : arg2,
            valid_recipients : 0x2::table::new<address, bool>(arg3),
        }
    }

    public(friend) fun deny_cap_mut<T0>(arg0: &mut LedgerToken<T0>) : &mut 0x2::coin::DenyCapV2<T0> {
        &mut arg0.deny_cap
    }

    public(friend) fun treasury_cap_mut<T0>(arg0: &mut LedgerToken<T0>) : &mut 0x2::coin::TreasuryCap<T0> {
        &mut arg0.treasury_cap
    }

    public(friend) fun valid_recipients_mut<T0>(arg0: &mut LedgerToken<T0>) : &mut 0x2::table::Table<address, bool> {
        &mut arg0.valid_recipients
    }

    // decompiled from Move bytecode v6
}

