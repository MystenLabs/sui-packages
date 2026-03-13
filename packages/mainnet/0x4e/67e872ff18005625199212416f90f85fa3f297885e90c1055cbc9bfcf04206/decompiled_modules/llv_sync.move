module 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_sync {
    public(friend) fun sync_balances<T0, T1>(arg0: &mut 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: vector<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>(&arg1)) {
            let v2 = 0x1::vector::borrow<0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::ProtocolAmount>(&arg1, v1);
            let v3 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::protocol_id(v2);
            let v4 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_allocation_plan::amount(v2);
            let v5 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_protocol_balance<T0, T1>(arg0, v3);
            0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::update_protocol_balance<T0, T1>(arg0, v3, v4, v0);
            if (v4 != v5) {
                let v6 = if (v4 > v5) {
                    v4 - v5
                } else {
                    0
                };
                0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_events::emit_accrue_interest(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::id<T0, T1>(arg0), v3, v5, v4, v6, v0);
            };
            v1 = v1 + 1;
        };
        0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_events::emit_balances_synced(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::id<T0, T1>(arg0), arg1, 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_total_assets<T0, T1>(arg0), v0);
    }

    public(friend) fun sync_protocol_balance<T0, T1>(arg0: &mut 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::update_protocol_balance<T0, T1>(arg0, arg1, arg2, v1);
        if (arg2 != v0) {
            let v2 = if (arg2 > v0) {
                arg2 - v0
            } else {
                0
            };
            0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_events::emit_accrue_interest(0x4e67e872ff18005625199212416f90f85fa3f297885e90c1055cbc9bfcf04206::llv_pool::id<T0, T1>(arg0), arg1, v0, arg2, v2, v1);
        };
    }

    // decompiled from Move bytecode v6
}

