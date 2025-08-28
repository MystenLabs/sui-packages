module 0xe8f612c2b8e0d4c08f0bbbba150508962d8eb70629fb43e7a5bbe9f6edc80369::transaction_storage {
    struct TransactionRecord has store, key {
        id: 0x2::object::UID,
        token_type: 0x1::string::String,
        sender: address,
        receiver: address,
        amount: u64,
        timestamp: u64,
        tx_digest: vector<u8>,
    }

    public fun get_amount(arg0: &TransactionRecord) : u64 {
        arg0.amount
    }

    public fun get_receiver(arg0: &TransactionRecord) : address {
        arg0.receiver
    }

    public fun get_sender(arg0: &TransactionRecord) : address {
        arg0.sender
    }

    public fun store_transaction<T0>(arg0: &0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TransactionRecord{
            id         : 0x2::object::new(arg4),
            token_type : 0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))),
            sender     : 0x2::tx_context::sender(arg4),
            receiver   : arg1,
            amount     : 0x2::coin::value<T0>(arg0),
            timestamp  : 0x2::tx_context::epoch_timestamp_ms(arg4),
            tx_digest  : *0x2::tx_context::digest(arg4),
        };
        0x2::kiosk::place<TransactionRecord>(arg2, arg3, v0);
    }

    // decompiled from Move bytecode v6
}

