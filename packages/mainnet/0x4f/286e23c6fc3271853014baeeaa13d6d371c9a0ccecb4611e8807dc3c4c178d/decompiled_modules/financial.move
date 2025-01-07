module 0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::financial {
    struct Beneficiary has store {
        account_type: u8,
        shared: 0x1::option::Option<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account::SharedAccount>,
        locked: 0x1::option::Option<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::locked_account::LockedAccount>,
    }

    public fun create_beneficiary_locked(arg0: u8) : Beneficiary {
        Beneficiary{
            account_type : arg0,
            shared       : 0x1::option::none<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account::SharedAccount>(),
            locked       : 0x1::option::none<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::locked_account::LockedAccount>(),
        }
    }

    public fun create_beneficiary_shared(arg0: u8, arg1: vector<address>, arg2: vector<u64>) : Beneficiary {
        Beneficiary{
            account_type : arg0,
            shared       : 0x1::option::some<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account::SharedAccount>(0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account::create_shared_account(arg1, arg2)),
            locked       : 0x1::option::none<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::locked_account::LockedAccount>(),
        }
    }

    public fun settlement<T0>(arg0: &mut Beneficiary, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.account_type == 1) {
            0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account::disperse<T0>(0x1::option::borrow<0x42de05b8e76db21ee6fe0a1f631d7bb3ea9076241cdc78a8960c0353103fde28::shared_account::SharedAccount>(&arg0.shared), arg1, arg2);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x2::tx_context::sender(arg2));
        };
    }

    // decompiled from Move bytecode v6
}

