module 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::settlement {
    struct TransferSettled has copy, drop {
        sender_account: 0x2::object::ID,
        recipient: address,
        amount: u64,
        sequence_number: u64,
    }

    public fun account_transfer<T0>(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::sequence_number(arg0), 100);
        assert!(arg2 > 0, 101);
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::credit<T0>(arg1, 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::debit<T0>(arg0, arg2));
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::increment_sequence(arg0);
        let v0 = 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::account_id(arg1);
        let v1 = TransferSettled{
            sender_account  : 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::account_id(arg0),
            recipient       : 0x2::object::id_to_address(&v0),
            amount          : arg2,
            sequence_number : arg3,
        };
        0x2::event::emit<TransferSettled>(v1);
    }

    public fun deposit_and_send<T0>(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::deposit<T0>(arg0, arg1);
        direct_send<T0>(arg0, arg2, arg3, arg4, arg5);
    }

    public fun direct_send<T0>(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::sequence_number(arg0), 100);
        assert!(arg1 > 0, 101);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::debit<T0>(arg0, arg1), arg4), arg2);
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::increment_sequence(arg0);
        let v0 = TransferSettled{
            sender_account  : 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::account_id(arg0),
            recipient       : arg2,
            amount          : arg1,
            sequence_number : arg3,
        };
        0x2::event::emit<TransferSettled>(v0);
    }

    public fun policy_send<T0>(arg0: &mut 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::ArvaAccount, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 == 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::sequence_number(arg0), 100);
        assert!(arg1 > 0, 101);
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::policy::check_and_record(arg0, arg1, arg2, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::debit<T0>(arg0, arg1), arg5), arg2);
        0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::increment_sequence(arg0);
        let v0 = TransferSettled{
            sender_account  : 0x8b106e9d2dc6ccd8ea5b7131abbf4895a9db6f42df3872d41daa69b9ceb84f64::account::account_id(arg0),
            recipient       : arg2,
            amount          : arg1,
            sequence_number : arg3,
        };
        0x2::event::emit<TransferSettled>(v0);
    }

    // decompiled from Move bytecode v6
}

