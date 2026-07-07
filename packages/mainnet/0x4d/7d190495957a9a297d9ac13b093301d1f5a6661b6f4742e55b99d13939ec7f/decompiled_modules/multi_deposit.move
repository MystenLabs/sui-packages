module 0x4d7d190495957a9a297d9ac13b093301d1f5a6661b6f4742e55b99d13939ec7f::multi_deposit {
    public fun send_sui_to_one_address(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: address, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u64>(&arg2) > 0, 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, *0x1::vector::borrow<u64>(&arg2, v0), arg3), arg1);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

