module 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::harvest {
    public fun harvest<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x2::clock::Clock, arg3: u64) : vector<u64> {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg1, arg0);
        let (v1, v2) = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::harvest<T0>(&v0, arg0, arg1, arg3);
        credit_rows<T0>(&v0, arg0, arg1, arg2, v2);
        v1
    }

    fun credit_rows<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg3: &0x2::clock::Clock, arg4: vector<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::HarvestFeeCredit>) {
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::game_paused(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::HarvestFeeCredit>(&arg4)) {
            let v3 = 0x1::vector::borrow<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::HarvestFeeCredit>(&arg4, v2);
            let v4 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::fee_credit_amount(v3);
            let v5 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::fee_credit_owner(v3);
            if (v4 > 0) {
                0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_fee_credit(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), v5, v4);
            };
            let v6 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::fee_credit_refund(v3);
            if (v6 > 0) {
                0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::note_harvest_gain(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), v5, v6, !v0, v1);
            };
            if (0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::fee_credit_settle(v3) && !v0) {
                0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book::settle_fee_achievement(arg0, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg1), 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid(arg2), v5, v1);
            };
            v2 = v2 + 1;
        };
    }

    public fun emergency_drain<T0>(arg0: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg1: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg3: &0x2::clock::Clock, arg4: u64) : vector<u64> {
        let v0 = 0x72d5ddc667e01a4355d3fc3bb3fa524643d3c9b23ba0a601009268991dcccc04::auth::issue_on<T0>(arg1, arg0);
        let (v1, v2) = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::emergency_drain<T0>(&v0, arg0, arg1, arg2, arg4);
        credit_rows<T0>(&v0, arg0, arg1, arg3, v2);
        v1
    }

    // decompiled from Move bytecode v7
}

