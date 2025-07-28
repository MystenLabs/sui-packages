module 0xb5209b88c73ccbc551d2b7a313aab7502ea0beec252a50f19901c49ea8f27f85::new_ticket {
    struct WinnerTicket has key {
        id: 0x2::object::UID,
        round: u64,
        rank: u64,
        amount: u64,
        expire_time: u64,
        claimed: bool,
    }

    public entry fun mint_ticket(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WinnerTicket{
            id          : 0x2::object::new(arg0),
            round       : 60,
            rank        : 1,
            amount      : 4786751055,
            expire_time : 1785139200,
            claimed     : false,
        };
        0x2::transfer::transfer<WinnerTicket>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

