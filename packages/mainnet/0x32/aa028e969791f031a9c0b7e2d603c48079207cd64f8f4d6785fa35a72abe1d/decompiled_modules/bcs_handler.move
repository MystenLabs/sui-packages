module 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::bcs_handler {
    struct Trade has copy, drop {
        maker_order_signature: vector<u8>,
        taker_order_signature: vector<u8>,
        quantity: u64,
        timestamp: u64,
    }

    struct Deposit has copy, drop {
        id: address,
        asset: 0x1::string::String,
        from: address,
        to: address,
        amount: u64,
        nonce: u128,
        tainted: bool,
    }

    struct OperatorUpdate has copy, drop {
        operator_type: 0x1::string::String,
        previous_operator: address,
        new_operator: address,
    }

    public fun dec_adjust_leverage(arg0: vector<u8>) : (address, address, 0x1::string::String, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_adjust_margin(arg0: vector<u8>) : (address, address, 0x1::string::String, bool, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_adl(arg0: vector<u8>) : (vector<u8>, address, address, address, bool, bool, 0x1::string::String, u64, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_apply_funding_rate(arg0: vector<u8>) : (address, u64, vector<address>, u64, u64, 0x1::string::String) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_vec_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)))
    }

    public fun dec_authorization(arg0: vector<u8>) : (address, address, address, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_authorize_liquidator(arg0: vector<u8>) : (vector<u8>, address, address, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_close_position(arg0: vector<u8>) : (address, address, 0x1::string::String, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_liquidation(arg0: vector<u8>) : (vector<u8>, address, address, address, 0x1::string::String, u64, bool, bool, bool, u64, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_market_details(arg0: vector<u8>) : (0x1::string::String, u64, bool, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_order(arg0: vector<u8>) : (vector<u8>, address, address, 0x1::string::String, u64, u64, u64, bool, bool, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::hash::blake2b256(&arg0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_long(), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)) == 0xe74481697f432ddee8dd6f9bd13b9d0297a5b63d55f3db25c4d3b5d34dad85b7::constants::position_isolated(), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_prune_table(arg0: vector<u8>) : (vector<u8>, address, vector<vector<u8>>, u8, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_vec_vec_u8(&mut v0), 0x2::bcs::peel_u8(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_set_account_type(arg0: vector<u8>) : (vector<u8>, address, address, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_set_fee_tier(arg0: vector<u8>) : (vector<u8>, address, address, u64, u64, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_set_funding_rate(arg0: vector<u8>) : (vector<u8>, address, u64, vector<vector<u8>>, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_vec_vec_u8(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_set_gas_fee(arg0: vector<u8>) : (vector<u8>, address, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_set_gas_pool(arg0: vector<u8>) : (vector<u8>, address, address, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_tee_update_assets(arg0: vector<u8>) : (vector<u8>, address, address, 0x1::string::String, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_tee_update_authorized_account(arg0: vector<u8>) : (vector<u8>, address, address, vector<address>, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_vec_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_tee_update_position(arg0: vector<u8>) : (vector<u8>, address, address, 0x1::string::String, u64, u64, u64, u64, bool, bool, 0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<bool>, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_option_u64(&mut v0), 0x2::bcs::peel_option_u64(&mut v0), 0x2::bcs::peel_option_u64(&mut v0), 0x2::bcs::peel_option_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_tee_update_user_trade_fee(arg0: vector<u8>) : (vector<u8>, address, address, u64, u64, bool, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_u8(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_bool(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dec_trades_batch(arg0: vector<u8>) : (vector<vector<u8>>, vector<vector<u8>>, vector<vector<u8>>, vector<vector<u8>>, vector<u64>) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_vec_vec_u8(&mut v0), 0x2::bcs::peel_vec_vec_u8(&mut v0), 0x2::bcs::peel_vec_vec_u8(&mut v0), 0x2::bcs::peel_vec_vec_u8(&mut v0), 0x2::bcs::peel_vec_u64(&mut v0))
    }

    public fun dec_withdrawal(arg0: vector<u8>) : (address, 0x1::string::String, address, u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        (0x2::bcs::peel_address(&mut v0), 0x1::string::utf8(0x2::bcs::peel_vec_u8(&mut v0)), 0x2::bcs::peel_address(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun enc_deposit(arg0: address, arg1: 0x1::string::String, arg2: address, arg3: address, arg4: u64, arg5: u128, arg6: bool) : vector<u8> {
        let v0 = Deposit{
            id      : arg0,
            asset   : arg1,
            from    : arg2,
            to      : arg3,
            amount  : arg4,
            nonce   : arg5,
            tainted : arg6,
        };
        0x2::bcs::to_bytes<Deposit>(&v0)
    }

    public fun enc_operator_update(arg0: 0x1::string::String, arg1: address, arg2: address) : vector<u8> {
        let v0 = OperatorUpdate{
            operator_type     : arg0,
            previous_operator : arg1,
            new_operator      : arg2,
        };
        0x2::bcs::to_bytes<OperatorUpdate>(&v0)
    }

    public fun enc_trade(arg0: vector<u8>, arg1: vector<u8>, arg2: u64, arg3: u64) : vector<u8> {
        let v0 = Trade{
            maker_order_signature : arg0,
            taker_order_signature : arg1,
            quantity              : arg2,
            timestamp             : arg3,
        };
        0x2::bcs::to_bytes<Trade>(&v0)
    }

    // decompiled from Move bytecode v6
}

