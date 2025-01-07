module 0x43f1145e14467660ab70465c4a836439f8f791bab697ad79071362e4a6dd7c5d::PebbleCityBonusRound {
    struct PEBBLECITYBONUSROUND has drop {
        dummy_field: bool,
    }

    struct LotteryTicket {
        dummy_field: bool,
    }

    fun init(arg0: PEBBLECITYBONUSROUND, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::nonfungible::NftTicket<LotteryTicket>>(0x97bd7f73494471339e9e9f55de2f7036e93d293ee0189ec652f1752ccdd22a62::nonfungible::claim_ticket<PEBBLECITYBONUSROUND, LotteryTicket>(arg0, 0x1::option::none<u32>(), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

