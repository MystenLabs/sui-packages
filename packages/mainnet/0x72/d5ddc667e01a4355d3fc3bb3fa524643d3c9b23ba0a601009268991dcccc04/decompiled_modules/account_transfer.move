module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::account_transfer {
    public fun transfer_account<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>, arg3: 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::AccountCap, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_unpaused(arg1, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::pause_accounts());
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::assert_version<T0>(arg0);
        let v0 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>>(arg0);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::assert_exchange<T0>(arg2, v0);
        assert!(arg4 != @0x0, 13835058261440593921);
        let v1 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg1, arg0);
        let v2 = 0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::Account<T0>>(arg2);
        let (v3, v4) = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::account::transfer_owner<T0>(&v1, arg2, arg3, arg4);
        let v5 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(&v1, arg0);
        let v6 = vector[];
        let v7 = v4;
        0x1::vector::reverse<address>(&mut v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v7)) {
            let v9 = 0x1::vector::pop_back<address>(&mut v7);
            0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::holder_book::remove_delegate(v5, v2, v9);
            if (!0x1::vector::contains<address>(&v6, &v9)) {
                0x1::vector::push_back<address>(&mut v6, v9);
            };
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<address>(v7);
        0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::holder_book::move_holder(v5, v2, v3, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::referral_book::move_bind(&v1, v5, v3, arg4);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::fold_parked<T0>(&v1, arg0, arg4, v2);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::events::emit_account_transferred_event(&v1, v0, v2, v3, arg4, v6);
    }

    // decompiled from Move bytecode v7
}

