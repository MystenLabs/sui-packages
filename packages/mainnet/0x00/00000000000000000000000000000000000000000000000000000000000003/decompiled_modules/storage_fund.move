module 0x3::storage_fund {
    struct StorageFund has store {
        total_object_storage_rebates: 0x2::balance::Balance<0x2::sui::SUI>,
        non_refundable_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public(friend) fun advance_epoch(arg0: &mut StorageFund, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: u64, arg5: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.non_refundable_balance, arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.non_refundable_balance, arg3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.total_object_storage_rebates, arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.non_refundable_balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_object_storage_rebates, arg5));
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.total_object_storage_rebates, arg4)
    }

    public(friend) fun new(arg0: 0x2::balance::Balance<0x2::sui::SUI>) : StorageFund {
        StorageFund{
            total_object_storage_rebates : 0x2::balance::zero<0x2::sui::SUI>(),
            non_refundable_balance       : arg0,
        }
    }

    public fun total_balance(arg0: &StorageFund) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_object_storage_rebates) + 0x2::balance::value<0x2::sui::SUI>(&arg0.non_refundable_balance)
    }

    public fun total_object_storage_rebates(arg0: &StorageFund) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.total_object_storage_rebates)
    }

    // decompiled from Move bytecode v6
}

