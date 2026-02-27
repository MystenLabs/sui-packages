module 0xb10113bc6a6c86cae3953334db6f81d0476b4d2b04993b6fc4862d96da74f3f0::ticketgusd4 {
    struct TICKETGUSD4 has drop {
        dummy_field: bool,
    }

    public fun finalize_registration(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<TICKETGUSD4>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<TICKETGUSD4>(arg0, arg1, arg2);
    }

    fun init(arg0: TICKETGUSD4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TICKETGUSD4>(arg0, 9, 0x1::string::utf8(b"TICKETGUSD4"), 0x1::string::utf8(b"Ticket-Only GUSD4"), 0x1::string::utf8(b"Ticket-only GUSD4 vault token"), 0x1::string::utf8(b"https://aftermath.finance/gusd.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKETGUSD4>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TICKETGUSD4>>(0x2::coin_registry::finalize<TICKETGUSD4>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

