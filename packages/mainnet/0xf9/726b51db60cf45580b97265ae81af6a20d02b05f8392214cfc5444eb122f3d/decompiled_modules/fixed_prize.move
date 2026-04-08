module 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::fixed_prize {
    public(friend) fun finalize_end_lotto<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: 0x2::vec_set::VecSet<address>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_state<T0>(arg0, 0);
        let v0 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_balance_value<T0>(arg0);
        let v1 = 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg0);
        let v2 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_total_tickets_sold<T0>(arg0);
        if (v2 == 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg0, v0), arg2), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_creator<T0>(arg0));
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_lotto_ended<T0>(v1, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_fixed_prize(), 0x2::vec_set::empty<address>(), 0, v0, 0, v0, 0);
            return
        };
        let v3 = v2 * 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_ticket_price<T0>(arg0);
        let v4 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_balance_value<T0>(arg0);
        assert!(v4 >= v3, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_insufficient_funds_error());
        let v5 = v3 / 10;
        let v6 = v3 - v5;
        let v7 = v4 - v3;
        let v8 = 0x2::vec_set::length<address>(&arg1);
        let v9 = v7 / v8;
        let v10 = 0x2::vec_set::keys<address>(&arg1);
        let v11 = 0;
        while (v11 < 0x1::vector::length<address>(v10)) {
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::add_winner_claim<T0>(arg0, *0x1::vector::borrow<address>(v10, v11), v9);
            v11 = v11 + 1;
        };
        let v12 = v7 - v9 * v8;
        if (v6 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg0, v6), arg2), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_creator<T0>(arg0));
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg0, v5), arg2), 0x2::tx_context::sender(arg2));
        };
        if (v12 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg0, v12), arg2), 0x2::tx_context::sender(arg2));
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_dust_collected(v1, v12);
        };
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_lotto_ended<T0>(v1, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_fixed_prize(), arg1, v9, v6, v5, v0, v2);
    }

    // decompiled from Move bytecode v6
}

