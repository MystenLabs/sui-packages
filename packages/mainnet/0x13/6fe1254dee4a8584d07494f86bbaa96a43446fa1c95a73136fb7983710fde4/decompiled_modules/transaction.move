module 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::transaction {
    struct Transaction has copy, drop, store {
        transaction_type: 0x1::string::String,
        amount: u64,
    }

    public fun amount(arg0: &Transaction) : u64 {
        arg0.amount
    }

    public fun bet(arg0: u64) : Transaction {
        Transaction{
            transaction_type : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants::tx_type_bet(),
            amount           : arg0,
        }
    }

    public fun is_credit(arg0: &Transaction) : bool {
        if (arg0.transaction_type == 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants::tx_type_win()) {
            return true
        };
        assert!(arg0.transaction_type == 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants::tx_type_bet(), 1);
        false
    }

    public fun is_debit(arg0: &Transaction) : bool {
        !is_credit(arg0)
    }

    public fun win(arg0: u64) : Transaction {
        Transaction{
            transaction_type : 0x136fe1254dee4a8584d07494f86bbaa96a43446fa1c95a73136fb7983710fde4::constants::tx_type_win(),
            amount           : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

