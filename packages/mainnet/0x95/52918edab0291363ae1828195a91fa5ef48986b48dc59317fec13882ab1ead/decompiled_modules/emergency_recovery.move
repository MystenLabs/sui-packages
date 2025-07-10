module 0x9552918edab0291363ae1828195a91fa5ef48986b48dc59317fec13882ab1ead::emergency_recovery {
    struct LegacyAuction has store, key {
        id: 0x2::object::UID,
        nft_id: 0x2::object::ID,
        kiosk_id: 0x2::object::ID,
        starting_bid: u64,
        current_bid: u64,
        highest_bidder: address,
        seller: address,
        end_time: u64,
        status: u8,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public entry fun recover_funds(arg0: &mut LegacyAuction, arg1: &mut 0x2::tx_context::TxContext) {
        arg0.status = 1;
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        if (v0 > 0 && arg0.highest_bidder != @0x0) {
            let v1 = v0 / 100;
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0 - v1, arg1), arg0.seller);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v1, arg1), @0x8cfed3962605beacf459a4bab2830a7c8e95bab8e60c228e65b2837565bd5fb8);
        };
        0x2::balance::destroy_zero<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, 0));
    }

    // decompiled from Move bytecode v6
}

