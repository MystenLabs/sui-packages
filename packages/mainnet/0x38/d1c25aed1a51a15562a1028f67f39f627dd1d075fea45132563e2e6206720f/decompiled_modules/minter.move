module 0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::minter {
    public fun mint_and_send_funds(arg0: &mut 0x2::coin::TreasuryCap<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::send_funds<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>(0x2::coin::mint<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>(arg0, arg1, arg3), arg2);
    }

    public fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>>(0x2::coin::mint<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>(arg0, arg1, arg3), arg2);
    }

    public fun mint_for_sender(arg0: &mut 0x2::coin::TreasuryCap<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>>(0x2::coin::mint<0x38d1c25aed1a51a15562a1028f67f39f627dd1d075fea45132563e2e6206720f::usdc::USDC>(arg0, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

