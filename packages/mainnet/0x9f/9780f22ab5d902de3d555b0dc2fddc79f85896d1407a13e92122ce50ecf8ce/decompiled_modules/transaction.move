module 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::transaction {
    struct Transaction has copy, drop, store {
        transaction_type: 0x1::string::String,
        amount: u64,
    }

    public fun amount(arg0: &Transaction) : u64 {
        arg0.amount
    }

    public fun bet(arg0: u64) : Transaction {
        Transaction{
            transaction_type : 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::tx_type_bet(),
            amount           : arg0,
        }
    }

    public fun is_credit(arg0: &Transaction) : bool {
        if (arg0.transaction_type == 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::tx_type_win()) {
            return true
        };
        assert!(arg0.transaction_type == 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::tx_type_bet(), 1);
        false
    }

    public fun is_debit(arg0: &Transaction) : bool {
        !is_credit(arg0)
    }

    public fun win(arg0: u64) : Transaction {
        Transaction{
            transaction_type : 0x9f9780f22ab5d902de3d555b0dc2fddc79f85896d1407a13e92122ce50ecf8ce::constants::tx_type_win(),
            amount           : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

