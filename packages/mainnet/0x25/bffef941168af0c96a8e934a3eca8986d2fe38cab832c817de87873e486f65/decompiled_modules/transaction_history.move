module 0x25bffef941168af0c96a8e934a3eca8986d2fe38cab832c817de87873e486f65::transaction_history {
    struct TransactionRecord has store, key {
        id: 0x2::object::UID,
        owner: address,
        transaction_type: u8,
        from_asset: 0x1::string::String,
        to_asset: 0x1::string::String,
        from_amount: u64,
        to_amount: u64,
        recipient: 0x1::string::String,
        sender_addr: 0x1::string::String,
        bank_name: 0x1::string::String,
        account_number: 0x1::string::String,
        transaction_id: 0x1::string::String,
        timestamp: u64,
        status: u8,
        gas_used: u64,
    }

    struct TransactionRegistry has key {
        id: 0x2::object::UID,
        user_transactions: 0x2::table::Table<address, vector<address>>,
    }

    struct TransactionRecorded has copy, drop {
        transaction_id: address,
        owner: address,
        transaction_type: u8,
        from_asset: 0x1::string::String,
        to_asset: 0x1::string::String,
        from_amount: u64,
        to_amount: u64,
        timestamp: u64,
    }

    public fun get_account_number(arg0: &TransactionRecord) : 0x1::string::String {
        arg0.account_number
    }

    public fun get_bank_name(arg0: &TransactionRecord) : 0x1::string::String {
        arg0.bank_name
    }

    public fun get_from_amount(arg0: &TransactionRecord) : u64 {
        arg0.from_amount
    }

    public fun get_from_asset(arg0: &TransactionRecord) : 0x1::string::String {
        arg0.from_asset
    }

    public fun get_owner(arg0: &TransactionRecord) : address {
        arg0.owner
    }

    public fun get_recipient(arg0: &TransactionRecord) : 0x1::string::String {
        arg0.recipient
    }

    public fun get_status(arg0: &TransactionRecord) : u8 {
        arg0.status
    }

    public fun get_timestamp(arg0: &TransactionRecord) : u64 {
        arg0.timestamp
    }

    public fun get_to_amount(arg0: &TransactionRecord) : u64 {
        arg0.to_amount
    }

    public fun get_to_asset(arg0: &TransactionRecord) : 0x1::string::String {
        arg0.to_asset
    }

    public fun get_transaction_id(arg0: &TransactionRecord) : 0x1::string::String {
        arg0.transaction_id
    }

    public fun get_type(arg0: &TransactionRecord) : u8 {
        arg0.transaction_type
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = TransactionRegistry{
            id                : 0x2::object::new(arg0),
            user_transactions : 0x2::table::new<address, vector<address>>(arg0),
        };
        0x2::transfer::share_object<TransactionRegistry>(v0);
    }

    public entry fun record_transaction(arg0: &mut TransactionRegistry, arg1: &0x2::clock::Clock, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: 0x1::string::String, arg12: u8, arg13: u64, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        let v2 = TransactionRecord{
            id               : 0x2::object::new(arg14),
            owner            : v0,
            transaction_type : arg2,
            from_asset       : arg3,
            to_asset         : arg4,
            from_amount      : arg5,
            to_amount        : arg6,
            recipient        : arg7,
            sender_addr      : arg8,
            bank_name        : arg9,
            account_number   : arg10,
            transaction_id   : arg11,
            timestamp        : v1,
            status           : arg12,
            gas_used         : arg13,
        };
        let v3 = 0x2::object::uid_to_address(&v2.id);
        if (!0x2::table::contains<address, vector<address>>(&arg0.user_transactions, v0)) {
            0x2::table::add<address, vector<address>>(&mut arg0.user_transactions, v0, 0x1::vector::empty<address>());
        };
        0x1::vector::push_back<address>(0x2::table::borrow_mut<address, vector<address>>(&mut arg0.user_transactions, v0), v3);
        let v4 = TransactionRecorded{
            transaction_id   : v3,
            owner            : v0,
            transaction_type : arg2,
            from_asset       : arg3,
            to_asset         : arg4,
            from_amount      : arg5,
            to_amount        : arg6,
            timestamp        : v1,
        };
        0x2::event::emit<TransactionRecorded>(v4);
        0x2::transfer::transfer<TransactionRecord>(v2, v0);
    }

    public entry fun update_status(arg0: &mut TransactionRecord, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        arg0.status = arg1;
    }

    // decompiled from Move bytecode v6
}

