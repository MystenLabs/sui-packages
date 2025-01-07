module 0xac0b20e78ba51499810a29ee8491d789ef62702853f7779da60a83ee99e3d0ed::PebbleCityBasecamp {
    struct PEBBLECITYBASECAMP has drop {
        dummy_field: bool,
    }

    struct LotteryTicket {
        dummy_field: bool,
    }

    fun init(arg0: PEBBLECITYBASECAMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0 == 0) {
            0x1::option::none<u32>()
        } else {
            0x1::option::some<u32>(0)
        };
        0x2::transfer::public_transfer<0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::nonfungible::NftTicket<LotteryTicket>>(0xc89ee1f8383c8964d6ff20b11688a489c3a4209da1b80499297a06072b8b548a::nonfungible::claim_ticket<PEBBLECITYBASECAMP, LotteryTicket>(arg0, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

