module 0x28f01e0e04cf9b211aeca301e808b0445e1a60b569ffcd7c46fd6d16022f52bc::escrow {
    struct ESCROW has drop {
        dummy_field: bool,
    }

    struct SwapOrder has drop, store {
        cctp_nonce: u64,
        sender: address,
        amount: u64,
        output_token: address,
        min_output: u64,
        recipient: address,
        created_at: u64,
    }

    struct EscrowState has key {
        id: 0x2::object::UID,
        oapp_cap: 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call_cap::CallCap,
        orders: 0x2::table::Table<u64, SwapOrder>,
        destination_domain: u32,
        dst_eid: u32,
        order_count: u64,
    }

    public fun borrow_order(arg0: &EscrowState, arg1: u64) : &SwapOrder {
        0x2::table::borrow<u64, SwapOrder>(&arg0.orders, arg1)
    }

    public fun destination_domain(arg0: &EscrowState) : u32 {
        arg0.destination_domain
    }

    public fun dst_eid(arg0: &EscrowState) : u32 {
        arg0.dst_eid
    }

    public fun encode_swap_order(arg0: u64, arg1: address, arg2: u64, arg3: address) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        v0
    }

    fun init(arg0: ESCROW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, _) = 0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::new<ESCROW>(&arg0, arg1);
        let v3 = EscrowState{
            id                 : 0x2::object::new(arg1),
            oapp_cap           : v0,
            orders             : 0x2::table::new<u64, SwapOrder>(arg1),
            destination_domain : 9,
            dst_eid            : 30108,
            order_count        : 0,
        };
        0x2::transfer::share_object<EscrowState>(v3);
        0x2::transfer::public_transfer<0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun initiate_order_with_swap<T0: drop>(arg0: &mut EscrowState, arg1: &0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::OApp, arg2: 0x2::coin::Coin<T0>, arg3: address, arg4: address, arg5: u64, arg6: address, arg7: vector<u8>, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::state::State, arg10: &mut 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::state::State, arg11: &0x2::deny_list::DenyList, arg12: &mut 0xecf47609d7da919ea98e7fd04f6e0648a0a79b337aaad373fa37aac8febf19c8::treasury::Treasury<T0>, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x28de9e8e087a6347001907fb698fdf8ab0467b342229b74b19264067aebc4ae9::call::Call<0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::endpoint_send::SendParam, 0x31beaef889b08b9c3b37d19280fc1f8b75bae5b2de2410fc3120f403e9a36dac::messaging_receipt::MessagingReceipt> {
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 > 0, 0);
        assert!(arg5 > 0, 1);
        let (_, v2) = 0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::deposit_for_burn_with_package_auth<T0, 0x28f01e0e04cf9b211aeca301e808b0445e1a60b569ffcd7c46fd6d16022f52bc::auth::EscrowAuth>(0x2aa6c5d56376c371f88a6cc42e852824994993cb9bab8d3e6450cbe3cb32b94e::deposit_for_burn::create_deposit_for_burn_ticket<T0, 0x28f01e0e04cf9b211aeca301e808b0445e1a60b569ffcd7c46fd6d16022f52bc::auth::EscrowAuth>(0x28f01e0e04cf9b211aeca301e808b0445e1a60b569ffcd7c46fd6d16022f52bc::auth::new(), arg2, arg0.destination_domain, arg3), arg9, arg10, arg11, arg12, arg14);
        let v3 = v2;
        let v4 = 0x8d87d37ba49e785dde270a83f8e979605b03dc552b5548f26fdf2f49bf7ed1b::message::nonce(&v3);
        let v5 = 0x2::clock::timestamp_ms(arg13);
        assert!(!0x2::table::contains<u64, SwapOrder>(&arg0.orders, v4), 2);
        let v6 = SwapOrder{
            cctp_nonce   : v4,
            sender       : 0x2::tx_context::sender(arg14),
            amount       : v0,
            output_token : arg4,
            min_output   : arg5,
            recipient    : arg6,
            created_at   : v5,
        };
        0x2::table::add<u64, SwapOrder>(&mut arg0.orders, v4, v6);
        arg0.order_count = arg0.order_count + 1;
        0x28f01e0e04cf9b211aeca301e808b0445e1a60b569ffcd7c46fd6d16022f52bc::events::emit_swap_order_created(v4, 0x2::tx_context::sender(arg14), v0, arg4, arg5, arg6, v5);
        0xfdc28afc0110cb2edb94e3e57f2b1ce69b5a99c503b06d15e51cfa212de56e24::oapp::lz_send_and_refund(arg1, &arg0.oapp_cap, arg0.dst_eid, encode_swap_order(v4, arg4, arg5, arg6), arg7, arg8, 0x1::option::none<0x2::coin::Coin<0x3de1504cf3fd75762759e353d9d95389618e557d0552697f19b52e4e927c1dee::zro::ZRO>>(), 0x2::tx_context::sender(arg14), arg14)
    }

    public fun order_amount(arg0: &SwapOrder) : u64 {
        arg0.amount
    }

    public fun order_cctp_nonce(arg0: &SwapOrder) : u64 {
        arg0.cctp_nonce
    }

    public fun order_count(arg0: &EscrowState) : u64 {
        arg0.order_count
    }

    public fun order_created_at(arg0: &SwapOrder) : u64 {
        arg0.created_at
    }

    public fun order_exists(arg0: &EscrowState, arg1: u64) : bool {
        0x2::table::contains<u64, SwapOrder>(&arg0.orders, arg1)
    }

    public fun order_min_output(arg0: &SwapOrder) : u64 {
        arg0.min_output
    }

    public fun order_output_token(arg0: &SwapOrder) : address {
        arg0.output_token
    }

    public fun order_recipient(arg0: &SwapOrder) : address {
        arg0.recipient
    }

    public fun order_sender(arg0: &SwapOrder) : address {
        arg0.sender
    }

    // decompiled from Move bytecode v6
}

