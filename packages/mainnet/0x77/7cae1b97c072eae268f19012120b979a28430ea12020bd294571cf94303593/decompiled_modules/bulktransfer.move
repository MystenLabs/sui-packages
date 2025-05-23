module 0x777cae1b97c072eae268f19012120b979a28430ea12020bd294571cf94303593::bulktransfer {
    struct BulkTransferExecuted has copy, drop {
        sender: address,
        coin_type: 0x1::ascii::String,
        total_recipients: u64,
        total_amount: u64,
    }

    public entry fun bulk_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u64>(&arg2), 1);
        let v1 = sum_amounts(&arg2);
        assert!(0x2::coin::value<T0>(&arg0) >= v1, 2);
        let v2 = 0x2::tx_context::sender(arg3);
        let v3 = 0;
        while (v3 < v0) {
            0x2::pay::split_and_transfer<T0>(&mut arg0, *0x1::vector::borrow<u64>(&arg2, v3), *0x1::vector::borrow<address>(&arg1, v3), arg3);
            v3 = v3 + 1;
        };
        let v4 = BulkTransferExecuted{
            sender           : v2,
            coin_type        : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            total_recipients : v0,
            total_amount     : v1,
        };
        0x2::event::emit<BulkTransferExecuted>(v4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, v2);
    }

    fun sum_amounts(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

