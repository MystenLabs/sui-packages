module 0x3791884e7ad6cf1cc9e773deaf488770e5a73c32b26e511876f6cc27cc79f6cf::teller {
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

    public fun mint_lp_token_with_ticket<T0>(arg0: &mut Teller<T0>, arg1: &mut 0x3791884e7ad6cf1cc9e773deaf488770e5a73c32b26e511876f6cc27cc79f6cf::lotus_lp_farm::LotusLPFarmCreatePoolTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.treasury, 0x3791884e7ad6cf1cc9e773deaf488770e5a73c32b26e511876f6cc27cc79f6cf::lotus_lp_farm::lp_token_receipt_mark_on_ticket<T0>(arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

