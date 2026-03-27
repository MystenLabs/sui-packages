module 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_sync {
    public(friend) fun sync_balances<T0, T1>(arg0: &mut 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::LLVPool<T0, T1>, arg1: vector<0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_allocation_plan::ProtocolAmount>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_allocation_plan::ProtocolAmount>(&arg1)) {
            let v1 = 0x1::vector::borrow<0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_allocation_plan::ProtocolAmount>(&arg1, v0);
            sync_protocol_balance<T0, T1>(arg0, 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_allocation_plan::protocol_id(v1), 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_allocation_plan::amount(v1), arg2);
            v0 = v0 + 1;
        };
        0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_events::emit_balances_synced(0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::id<T0, T1>(arg0), arg1, 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::get_total_assets<T0, T1>(arg0), 0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun sync_protocol_balance<T0, T1>(arg0: &mut 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::LLVPool<T0, T1>, arg1: u8, arg2: u128, arg3: &0x2::clock::Clock) {
        let v0 = 0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::get_protocol_balance<T0, T1>(arg0, arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::update_protocol_balance<T0, T1>(arg0, arg1, arg2, v1);
        if (arg2 != v0) {
            let v2 = if (arg2 > v0) {
                arg2 - v0
            } else {
                0
            };
            0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_events::emit_accrue_interest(0xecfc0a19eec03f6347dd0f5d5cede2552b0a0e7a7a5742a9294159e868a486ca::llv_pool::id<T0, T1>(arg0), arg1, v0, arg2, v2, v1);
        };
    }

    // decompiled from Move bytecode v6
}

