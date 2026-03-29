module 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_fee_state {
    struct DappFeeState has copy, drop, store {
        base_fee: u256,
        byte_fee: u256,
        free_credit: u256,
        total_bytes_size: u256,
        total_recharged: u256,
        total_paid: u256,
        total_set_count: u256,
    }

    public fun new(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : DappFeeState {
        DappFeeState{
            base_fee         : arg0,
            byte_fee         : arg1,
            free_credit      : arg2,
            total_bytes_size : arg3,
            total_recharged  : arg4,
            total_paid       : arg5,
            total_set_count  : arg6,
        }
    }

    public fun base_fee(arg0: &DappFeeState) : u256 {
        arg0.base_fee
    }

    public fun byte_fee(arg0: &DappFeeState) : u256 {
        arg0.byte_fee
    }

    public fun decode(arg0: vector<u8>) : DappFeeState {
        let v0 = 0x2::bcs::new(arg0);
        DappFeeState{
            base_fee         : 0x2::bcs::peel_u256(&mut v0),
            byte_fee         : 0x2::bcs::peel_u256(&mut v0),
            free_credit      : 0x2::bcs::peel_u256(&mut v0),
            total_bytes_size : 0x2::bcs::peel_u256(&mut v0),
            total_recharged  : 0x2::bcs::peel_u256(&mut v0),
            total_paid       : 0x2::bcs::peel_u256(&mut v0),
            total_set_count  : 0x2::bcs::peel_u256(&mut v0),
        }
    }

    public(friend) fun delete(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::delete_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, arg1);
    }

    public fun encode(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256) : vector<vector<u8>> {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg0));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg1));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg2));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg3));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg4));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg5));
        0x1::vector::push_back<vector<u8>>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg6));
        v0
    }

    public fun encode_struct(arg0: DappFeeState) : vector<vector<u8>> {
        encode(arg0.base_fee, arg0.byte_fee, arg0.free_credit, arg0.total_bytes_size, arg0.total_recharged, arg0.total_paid, arg0.total_set_count)
    }

    public fun ensure_has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0);
    }

    public fun ensure_has_not(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::ensure_has_not_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0);
    }

    public fun free_credit(arg0: &DappFeeState) : u256 {
        arg0.free_credit
    }

    public fun get(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : (u256, u256, u256, u256, u256, u256, u256) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0));
        (0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1), 0x2::bcs::peel_u256(&mut v1))
    }

    public fun get_base_fee(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 0));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_byte_fee(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 1));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_free_credit(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 2));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_struct(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : DappFeeState {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        decode(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0))
    }

    public fun get_total_bytes_size(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 3));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_total_paid(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 5));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_total_recharged(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 4));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun get_total_set_count(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : u256 {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        let v1 = 0x2::bcs::new(0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::get_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0, 6));
        0x2::bcs::peel_u256(&mut v1)
    }

    public fun has(arg0: &0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String) : bool {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::has_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, arg1, v0)
    }

    public(friend) fun set(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode(arg2, arg3, arg4, arg5, arg6, arg7, arg8), arg1, false, arg9);
    }

    public(friend) fun set_base_fee(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 0, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public(friend) fun set_byte_fee(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 1, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public(friend) fun set_free_credit(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 2, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public(friend) fun set_struct(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: DappFeeState, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_record<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), v0, encode_struct(arg2), arg1, false, arg3);
    }

    public(friend) fun set_total_bytes_size(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 3, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public(friend) fun set_total_paid(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 5, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public(friend) fun set_total_recharged(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 4, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public(friend) fun set_total_set_count(arg0: &mut 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::DappHub, arg1: 0x1::ascii::String, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        0x1::vector::push_back<vector<u8>>(&mut v0, b"dapp_fee_state");
        0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_service::set_field<0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::DappKey>(arg0, 0x635cf664078d2dad3e09f5c7968034b10d151dba3a409d4b5ffe2dd1f7e9850f::dapp_key::new(), arg1, v0, 6, 0x2::bcs::to_bytes<u256>(&arg2), arg3);
    }

    public fun total_bytes_size(arg0: &DappFeeState) : u256 {
        arg0.total_bytes_size
    }

    public fun total_paid(arg0: &DappFeeState) : u256 {
        arg0.total_paid
    }

    public fun total_recharged(arg0: &DappFeeState) : u256 {
        arg0.total_recharged
    }

    public fun total_set_count(arg0: &DappFeeState) : u256 {
        arg0.total_set_count
    }

    public fun update_base_fee(arg0: &mut DappFeeState, arg1: u256) {
        arg0.base_fee = arg1;
    }

    public fun update_byte_fee(arg0: &mut DappFeeState, arg1: u256) {
        arg0.byte_fee = arg1;
    }

    public fun update_free_credit(arg0: &mut DappFeeState, arg1: u256) {
        arg0.free_credit = arg1;
    }

    public fun update_total_bytes_size(arg0: &mut DappFeeState, arg1: u256) {
        arg0.total_bytes_size = arg1;
    }

    public fun update_total_paid(arg0: &mut DappFeeState, arg1: u256) {
        arg0.total_paid = arg1;
    }

    public fun update_total_recharged(arg0: &mut DappFeeState, arg1: u256) {
        arg0.total_recharged = arg1;
    }

    public fun update_total_set_count(arg0: &mut DappFeeState, arg1: u256) {
        arg0.total_set_count = arg1;
    }

    // decompiled from Move bytecode v6
}

