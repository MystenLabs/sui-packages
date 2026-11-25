module 0x875d7415d034da410f25e6b9726663352fedee8769447ef77b23bef56e8be6de::recording_share {
    struct RecordingShare has key {
        id: 0x2::object::UID,
    }

    struct InitializeCurrencyTicket has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InitializeCurrencyTicket{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<InitializeCurrencyTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initialize_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: InitializeCurrencyTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<RecordingShare> {
        let InitializeCurrencyTicket { id: v0 } = arg1;
        0x2::object::delete(v0);
        let (v1, v2) = 0x2::coin_registry::new_currency<RecordingShare>(arg0, 6, 0x1::string::utf8(b"RSHARE"), 0x1::string::utf8(b"Recording Share"), 0x1::string::utf8(b""), 0x1::string::utf8(b""), arg2);
        0x2::coin_registry::finalize_and_delete_metadata_cap<RecordingShare>(v1, arg2);
        v2
    }

    // decompiled from Move bytecode v7
}

