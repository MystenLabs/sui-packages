module 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::upgrade_protocol {
    struct ProtocolUpgradeWish has copy, drop, store {
        policy: u8,
        digest: vector<u8>,
    }

    public fun authorize_protocol_upgrade(arg0: &mut 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_can_summon_shenron(arg0);
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::take_locked_update<0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>());
        assert!(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::is_active<ProtocolUpgradeWish>(&v0, arg1), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::errors::time_locked_not_active());
        let ProtocolUpgradeWish {
            policy : v1,
            digest : v2,
        } = 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::into_inner<ProtocolUpgradeWish>(v0);
        0x2::package::authorize_upgrade(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::lending_package_upgrade_cap(arg0), v1, v2)
    }

    public fun commit_protocol_upgrade(arg0: &mut 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: 0x2::package::UpgradeReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_can_summon_shenron(arg0);
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg2));
        0x2::package::commit_upgrade(0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::lending_package_upgrade_cap(arg0), arg1);
    }

    public fun wish_authorize_protocol_upgrade(arg0: &mut 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::DragonBallCollector, arg1: u8, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_can_summon_shenron(arg0);
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::ensure_param_modifier_allowed(arg0, 0x2::tx_context::sender(arg4));
        let v0 = ProtocolUpgradeWish{
            policy : arg1,
            digest : arg2,
        };
        0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::store_locked_update<0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::TimeLock<ProtocolUpgradeWish>>(arg0, 0x1::type_name::with_defining_ids<ProtocolUpgradeWish>(), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::time_lock::new_time_locked<ProtocolUpgradeWish>(v0, arg3, 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::time_lock_duration_seconds(arg0), 0xaeef8dc5d5296574702aad6e94c2b1dae419937611ac6f92403fa46938fd47c4::governance::time_lock_expriration_seconds(arg0)));
    }

    // decompiled from Move bytecode v6
}

