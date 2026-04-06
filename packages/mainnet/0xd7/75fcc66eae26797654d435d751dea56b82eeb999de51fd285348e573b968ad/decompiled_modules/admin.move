module 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::admin {
    public fun cancel_fee_change(arg0: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg1: &mut 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::assert_version(arg1);
        let v0 = 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::fee_change_effective_at(arg1);
        assert!(0x1::option::is_some<u64>(&v0), 9);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::clear_pending_fees(arg1);
    }

    public fun execute_fee_change(arg0: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg1: &mut 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::assert_version(arg1);
        let v0 = 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::fee_change_effective_at(arg1);
        assert!(0x1::option::is_some<u64>(&v0), 9);
        assert!(0x2::clock::timestamp_ms(arg2) >= *0x1::option::borrow<u64>(&v0), 8);
        let v1 = 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::pending_save_fee_bps(arg1);
        let v2 = *0x1::option::borrow<u64>(&v1);
        let v3 = 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::pending_swap_fee_bps(arg1);
        let v4 = *0x1::option::borrow<u64>(&v3);
        let v5 = 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::pending_borrow_fee_bps(arg1);
        let v6 = *0x1::option::borrow<u64>(&v5);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_save_fee_bps(arg1, v2);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_swap_fee_bps(arg1, v4);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_borrow_fee_bps(arg1, v6);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::clear_pending_fees(arg1);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_config_updated(b"save_fee_bps", 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::fee_rate(arg1, 0), v2, 0x2::tx_context::sender(arg3));
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_config_updated(b"swap_fee_bps", 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::fee_rate(arg1, 1), v4, 0x2::tx_context::sender(arg3));
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_config_updated(b"borrow_fee_bps", 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::fee_rate(arg1, 2), v6, 0x2::tx_context::sender(arg3));
    }

    public fun migrate_config(arg0: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg1: &mut 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config) {
        assert!(0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::version(arg1) < 1, 10);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_version(arg1, 1);
    }

    public fun pause(arg0: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg1: &mut 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::assert_version(arg1);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_paused(arg1, true);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_protocol_paused(0x2::tx_context::sender(arg2));
    }

    public fun propose_fee_change(arg0: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg1: &mut 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::assert_version(arg1);
        assert!(arg2 <= 500, 4);
        assert!(arg3 <= 500, 4);
        assert!(arg4 <= 500, 4);
        let v0 = 0x2::clock::timestamp_ms(arg5) + 604800000;
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_pending_fees(arg1, arg2, arg3, arg4, v0);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_fee_change_proposed(arg2, arg3, arg4, v0);
    }

    public fun unpause(arg0: &0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::AdminCap, arg1: &mut 0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::Config, arg2: &mut 0x2::tx_context::TxContext) {
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::assert_version(arg1);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::core::set_paused(arg1, false);
        0xd775fcc66eae26797654d435d751dea56b82eeb999de51fd285348e573b968ad::events::emit_protocol_unpaused(0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

