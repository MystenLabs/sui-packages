module 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::tip_operations {
    public entry fun send_tip(arg0: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem, arg1: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg2: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::profile_address(arg2);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v3 = 0x1::string::utf8(arg4);
        validate_tip(v0, arg1, arg2, v2);
        update_statistics(arg0, arg1, arg2, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::create_tip(v0, v1, v2, v3, 0x2::tx_context::epoch_timestamp_ms(arg5)), v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, v1);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::events::emit_tip_sent(v0, v1, v2, v3);
    }

    public entry fun send_tip_no_profile(arg0: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        let v2 = 0x1::string::utf8(arg3);
        assert!(v1 > 0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::invalid_value());
        assert!(v0 != arg1, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::same_user());
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::add_tip_to_history(arg0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::create_tip(v0, arg1, v1, v2, 0x2::tx_context::epoch_timestamp_ms(arg4)));
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_tips(arg0);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_volume(arg0, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::events::emit_tip_sent(v0, arg1, v1, v2);
    }

    public entry fun send_tip_with_profile_address(arg0: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem, arg1: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg2: address, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        let v2 = 0x1::string::utf8(arg4);
        assert!(v1 > 0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::invalid_value());
        assert!(v0 == 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::profile_address(arg1), 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::profile_not_exists());
        assert!(v0 != arg2, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::same_user());
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::add_tip_to_history(arg0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::create_tip(v0, arg2, v1, v2, 0x2::tx_context::epoch_timestamp_ms(arg5)));
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_tips(arg0);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_volume(arg0, v1);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_sent(arg1, v1);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_tips_sent(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg2);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::events::emit_tip_sent(v0, arg2, v1, v2);
    }

    public entry fun update_receiver_stats(arg0: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::profile_address(arg0), 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::profile_not_exists());
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_received(arg0, arg1);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_tips_received(arg0);
    }

    fun update_statistics(arg0: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::TippingSystem, arg1: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg2: &mut 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg3: 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::Tip, arg4: u64) {
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::add_tip_to_history(arg0, arg3);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_tips(arg0);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_volume(arg0, arg4);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_sent(arg1, arg4);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_tips_sent(arg1);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_total_received(arg2, arg4);
        0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::increment_tips_received(arg2);
    }

    fun validate_tip(arg0: address, arg1: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg2: &0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::UserProfile, arg3: u64) {
        let v0 = 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::profile_address(arg1);
        assert!(arg3 > 0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::invalid_value());
        assert!(arg0 == v0, 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::profile_not_exists());
        assert!(v0 != 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::types::profile_address(arg2), 0x8cfc70c099cd1b4ee44aaa45c48acf80c217064f767f30bb97bc8cd5ddc87e48::errors::same_user());
    }

    // decompiled from Move bytecode v6
}

