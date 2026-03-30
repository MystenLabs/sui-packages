module 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::pooled_prize {
    public(friend) fun finalize_end_lotto<T0>(arg0: &mut 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::Lotto<T0>, arg1: 0x2::vec_set::VecSet<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::set_state<T0>(arg0, 0);
        let v0 = 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::get_balance_value<T0>(arg0);
        let v1 = 0x2::object::id<0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::Lotto<T0>>(arg0);
        let v2 = 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::get_total_tickets_sold<T0>(arg0);
        if (v2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::take_from_balance<T0>(arg0, v0), arg2), 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::get_creator<T0>(arg0));
            0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::events::emit_lotto_ended<T0>(v1, 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::lotto_type_pooled_prize(), 0x2::vec_set::empty<address>(), 0, v0, 0, v0, 0);
            return
        };
        let v3 = v0 * 2 / 100;
        let v4 = v0 * 3 / 100;
        let v5 = v0 - v3 - v4;
        let v6 = 0x2::vec_set::length<address>(&arg1);
        let v7 = v5 / v6;
        let v8 = 0x2::vec_set::keys<address>(&arg1);
        let v9 = 0;
        while (v9 < 0x1::vector::length<address>(v8)) {
            0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::winner_selection::add_winner_claim<T0>(arg0, *0x1::vector::borrow<address>(v8, v9), v7);
            v9 = v9 + 1;
        };
        let v10 = v5 - v7 * v6;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::take_from_balance<T0>(arg0, v4), arg2), 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::get_creator<T0>(arg0));
        };
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::take_from_balance<T0>(arg0, v3), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v10 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::take_from_balance<T0>(arg0, v10), arg2), 0x2::tx_context::sender(arg2));
            0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::events::emit_dust_collected(v1, v10);
        };
        0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::events::emit_lotto_ended<T0>(v1, 0x5c5549cdf61942f8cba3ca12d3f87f88c3eb1c38b56b4eea44e35c68afac74ae::types::lotto_type_pooled_prize(), arg1, v7, v4, v3, v0, v2);
    }

    // decompiled from Move bytecode v6
}

