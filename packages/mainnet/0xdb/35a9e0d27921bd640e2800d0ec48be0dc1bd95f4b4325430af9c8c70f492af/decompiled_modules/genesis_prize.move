module 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::genesis_prize {
    public(friend) fun finalize_end_lotto<T0>(arg0: &mut 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::Lotto<T0>, arg1: 0x2::vec_set::VecSet<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::set_state<T0>(arg0, 0);
        let v0 = 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::get_balance_value<T0>(arg0);
        let v1 = 0x2::object::id<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::Lotto<T0>>(arg0);
        let v2 = 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::get_total_tickets_sold<T0>(arg0);
        if (v2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::take_from_balance<T0>(arg0, v0), arg2), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::get_creator<T0>(arg0));
            0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::events::emit_lotto_ended<T0>(v1, 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::lotto_type_genesis(), 0x2::vec_set::empty<address>(), 0, v0, 0, v0, 0);
            return
        };
        let v3 = 0x2::vec_set::length<address>(&arg1);
        let v4 = v0 / v3;
        let v5 = 0x2::vec_set::keys<address>(&arg1);
        let v6 = 0;
        while (v6 < 0x1::vector::length<address>(v5)) {
            0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::winner_selection::add_winner_claim<T0>(arg0, *0x1::vector::borrow<address>(v5, v6), v4);
            v6 = v6 + 1;
        };
        let v7 = v0 - v4 * v3;
        if (v7 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::take_from_balance<T0>(arg0, v7), arg2), 0x2::tx_context::sender(arg2));
            0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::events::emit_dust_collected(v1, v7);
        };
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::events::emit_lotto_ended<T0>(v1, 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::lotto_type_genesis(), arg1, v4, 0, 0, v0, v2);
    }

    // decompiled from Move bytecode v6
}

