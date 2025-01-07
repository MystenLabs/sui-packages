module 0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::interface {
    public entry fun buy_token(arg0: &mut 0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::VestingStorage, arg1: &mut 0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::ReferenceStorage, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::buy_csc(arg5, arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun claim_commission(arg0: &mut 0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::ReferenceStorage, arg1: &mut 0x2::tx_context::TxContext) {
        0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::claim_commission(arg1, arg0);
    }

    public entry fun release(arg0: &mut 0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::VestingStorage, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0xa76f21972aeaf9575f2d7df445af0c0dcf6134b3e25fbc5d623f56a3cf85d795::vesting::release(arg2, arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

