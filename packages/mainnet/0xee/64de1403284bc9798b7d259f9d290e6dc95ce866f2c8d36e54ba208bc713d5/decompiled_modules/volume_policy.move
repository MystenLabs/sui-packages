module 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_policy {
    struct Key has copy, drop, store {
        dummy_field: bool,
    }

    struct UnpricedKey has copy, drop, store {
        dummy_field: bool,
    }

    struct Unpriced has copy, drop, store {
        at_ms: u64,
    }

    public(friend) fun record_quote(arg0: &mut 0x2::object::UID, arg1: &0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::Rules, arg2: u64, arg3: u256, arg4: u256, arg5: u64) {
        sync(arg0, arg1, arg5);
        let v0 = Key{dummy_field: false};
        0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::record(0x2::dynamic_field::borrow_mut<Key, 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::State>(arg0, v0), 0x2ec50cc9740fa5cf75dd7d57e0cb3e1394f3b5cb153806b2168e8e3be681e8c1::share_math::collateral_usd_e6(arg2, arg3, arg4, false), arg5);
    }

    public(friend) fun record_unpriced(arg0: &mut 0x2::object::UID, arg1: u64) {
        let v0 = UnpricedKey{dummy_field: false};
        if (0x2::dynamic_field::exists<UnpricedKey>(arg0, v0)) {
            let v1 = UnpricedKey{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow_mut<UnpricedKey, Unpriced>(arg0, v1);
            v2.at_ms = 0x1::u64::max(v2.at_ms, arg1);
        } else {
            let v3 = UnpricedKey{dummy_field: false};
            let v4 = Unpriced{at_ms: arg1};
            0x2::dynamic_field::add<UnpricedKey, Unpriced>(arg0, v3, v4);
        };
    }

    public(friend) fun status(arg0: &0x2::object::UID, arg1: &0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::Rules, arg2: u64) : (bool, bool, u128, u64, u64) {
        let v0 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists<Key>(arg0, v0)) {
            return (false, false, 0, 0, 0)
        };
        let v1 = Key{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow<Key, 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::State>(arg0, v1);
        let (v3, v4) = 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::values(arg1);
        if (0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::horizon_ms(v2) != v3) {
            return (false, false, 0, 0, 0)
        };
        (true, 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::ready(v2, arg2, v4), 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::daily_volume(v2, arg2), 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::started_ms(v2), 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::updated_ms(v2))
    }

    public(friend) fun sync(arg0: &mut 0x2::object::UID, arg1: &0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::Rules, arg2: u64) {
        let (v0, _) = 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::values(arg1);
        let v2 = Key{dummy_field: false};
        if (!0x2::dynamic_field::exists<Key>(arg0, v2)) {
            let v3 = Key{dummy_field: false};
            0x2::dynamic_field::add<Key, 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::State>(arg0, v3, 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::new(arg2, v0));
        } else {
            let v4 = Key{dummy_field: false};
            0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::reset_horizon(0x2::dynamic_field::borrow_mut<Key, 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::volume_ema::State>(arg0, v4), arg2, v0);
        };
    }

    public(friend) fun winddown_ready(arg0: &0x2::object::UID, arg1: &0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::Rules, arg2: u64) : bool {
        let (_, v1, _, _, _) = status(arg0, arg1, arg2);
        if (!v1) {
            return false
        };
        let v5 = UnpricedKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<UnpricedKey>(arg0, v5)) {
            return true
        };
        let v6 = UnpricedKey{dummy_field: false};
        let v7 = 0x2::dynamic_field::borrow<UnpricedKey, Unpriced>(arg0, v6);
        let (_, v9) = 0xee64de1403284bc9798b7d259f9d290e6dc95ce866f2c8d36e54ba208bc713d5::hibernation_rules::values(arg1);
        arg2 >= v7.at_ms && arg2 - v7.at_ms >= v9
    }

    // decompiled from Move bytecode v7
}

