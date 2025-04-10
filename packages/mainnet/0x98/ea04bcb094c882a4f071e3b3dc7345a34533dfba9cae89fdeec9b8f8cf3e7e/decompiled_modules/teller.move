module 0x98ea04bcb094c882a4f071e3b3dc7345a34533dfba9cae89fdeec9b8f8cf3e7e::teller {
    struct Teller<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<T0>,
    }

    public fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Teller<T0>{
            id       : 0x2::object::new(arg1),
            treasury : arg0,
        };
        0x2::transfer::share_object<Teller<T0>>(v0);
    }

    public fun mint_lp_token_with_ticket<T0>(arg0: &mut Teller<T0>, arg1: &mut 0x98ea04bcb094c882a4f071e3b3dc7345a34533dfba9cae89fdeec9b8f8cf3e7e::lotus_lp_farm::LotusLPFarmCreatePoolTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.treasury, 0x98ea04bcb094c882a4f071e3b3dc7345a34533dfba9cae89fdeec9b8f8cf3e7e::lotus_lp_farm::lp_token_receipt_mark_on_ticket<T0>(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

