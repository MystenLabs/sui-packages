module 0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::swap_request {
    struct WithdrawSwapRequestDropped has copy, drop {
        vault_id: address,
        request_id: u64,
        recipient: address,
        target_asset_type: 0x1::ascii::String,
    }

    struct WithdrawSwapRequestDynamicFieldKey has copy, drop, store {
        dummy_field: bool,
    }

    struct WithdrawSwapRequestDynamicField has store {
        withdraw_swap_requests: 0x2::table::Table<u64, WithdrawSwapRequest>,
    }

    struct WithdrawSwapRequest has copy, drop, store {
        vault_id: address,
        request_id: u64,
        recipient: address,
        target_asset_type: 0x1::ascii::String,
        slippage_bps: u64,
    }

    public(friend) fun add_dynamic_field_withdraw_requests<T0>(arg0: &mut 0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::check_version<T0>(arg0);
        let v0 = WithdrawSwapRequestDynamicField{withdraw_swap_requests: 0x2::table::new<u64, WithdrawSwapRequest>(arg1)};
        let v1 = WithdrawSwapRequestDynamicFieldKey{dummy_field: false};
        0x2::dynamic_field::add<WithdrawSwapRequestDynamicFieldKey, WithdrawSwapRequestDynamicField>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_id_mut<T0>(arg0), v1, v0);
    }

    public fun contains_withdraw_swap_request<T0>(arg0: &0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>, arg1: u64) : bool {
        let v0 = WithdrawSwapRequestDynamicFieldKey{dummy_field: false};
        0x2::dynamic_field::exists_with_type<WithdrawSwapRequestDynamicFieldKey, WithdrawSwapRequestDynamicField>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_uid<T0>(arg0), v0) && 0x2::table::contains<u64, WithdrawSwapRequest>(withdraw_swap_requests<T0>(arg0), arg1)
    }

    public(friend) fun delete_withdraw_swap_request<T0>(arg0: &mut 0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>, arg1: u64) : WithdrawSwapRequest {
        let v0 = WithdrawSwapRequestDynamicFieldKey{dummy_field: false};
        0x2::table::remove<u64, WithdrawSwapRequest>(&mut 0x2::dynamic_field::borrow_mut<WithdrawSwapRequestDynamicFieldKey, WithdrawSwapRequestDynamicField>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_id_mut<T0>(arg0), v0).withdraw_swap_requests, arg1)
    }

    public(friend) fun new_withdraw_swap_request(arg0: address, arg1: u64, arg2: address, arg3: 0x1::ascii::String, arg4: u64) : WithdrawSwapRequest {
        WithdrawSwapRequest{
            vault_id          : arg0,
            request_id        : arg1,
            recipient         : arg2,
            target_asset_type : arg3,
            slippage_bps      : arg4,
        }
    }

    public fun recipient(arg0: &WithdrawSwapRequest) : address {
        arg0.recipient
    }

    public fun request_id(arg0: &WithdrawSwapRequest) : u64 {
        arg0.request_id
    }

    public fun slippage_bps(arg0: &WithdrawSwapRequest) : u64 {
        arg0.slippage_bps
    }

    public fun target_asset_type(arg0: &WithdrawSwapRequest) : 0x1::ascii::String {
        arg0.target_asset_type
    }

    public(friend) fun try_delete_withdraw_swap_request<T0>(arg0: &mut 0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>, arg1: u64) {
        let v0 = WithdrawSwapRequestDynamicFieldKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<WithdrawSwapRequestDynamicFieldKey>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_id_mut<T0>(arg0), v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<WithdrawSwapRequestDynamicFieldKey, WithdrawSwapRequestDynamicField>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_id_mut<T0>(arg0), v0);
        if (0x2::table::contains<u64, WithdrawSwapRequest>(&v1.withdraw_swap_requests, arg1)) {
            let v2 = 0x2::table::remove<u64, WithdrawSwapRequest>(&mut v1.withdraw_swap_requests, arg1);
            let v3 = WithdrawSwapRequestDropped{
                vault_id          : v2.vault_id,
                request_id        : v2.request_id,
                recipient         : v2.recipient,
                target_asset_type : v2.target_asset_type,
            };
            0x2::event::emit<WithdrawSwapRequestDropped>(v3);
        };
    }

    public fun vault_id(arg0: &WithdrawSwapRequest) : address {
        arg0.vault_id
    }

    public fun withdraw_swap_request<T0>(arg0: &0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>, arg1: u64) : WithdrawSwapRequest {
        *0x2::table::borrow<u64, WithdrawSwapRequest>(withdraw_swap_requests<T0>(arg0), arg1)
    }

    public(friend) fun withdraw_swap_requests<T0>(arg0: &0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>) : &0x2::table::Table<u64, WithdrawSwapRequest> {
        let v0 = WithdrawSwapRequestDynamicFieldKey{dummy_field: false};
        &0x2::dynamic_field::borrow<WithdrawSwapRequestDynamicFieldKey, WithdrawSwapRequestDynamicField>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_uid<T0>(arg0), v0).withdraw_swap_requests
    }

    public(friend) fun withdraw_swap_requests_mut<T0>(arg0: &mut 0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::Vault<T0>) : &mut 0x2::table::Table<u64, WithdrawSwapRequest> {
        let v0 = WithdrawSwapRequestDynamicFieldKey{dummy_field: false};
        &mut 0x2::dynamic_field::borrow_mut<WithdrawSwapRequestDynamicFieldKey, WithdrawSwapRequestDynamicField>(0x8d0ba2c5200f6d4d09168ed954c87903a759345e3a9f6e509343ee0c0fb0e961::vault::vault_id_mut<T0>(arg0), v0).withdraw_swap_requests
    }

    // decompiled from Move bytecode v7
}

