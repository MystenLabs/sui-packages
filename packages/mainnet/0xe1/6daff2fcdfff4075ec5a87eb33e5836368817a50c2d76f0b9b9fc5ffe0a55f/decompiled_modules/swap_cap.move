module 0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::swap_cap {
    struct SwapCompletedEvent has copy, drop {
        swapper: address,
        type_in: 0x1::ascii::String,
        amount_in: u64,
        type_out: 0x1::ascii::String,
        amount_out: u64,
        router_fee_recipient: address,
        router_fee: u64,
        referrer: 0x1::option::Option<address>,
    }

    struct RouterFeeMetadata has copy, drop {
        recipient: address,
        fee: u64,
    }

    struct SwapMetadata has copy, drop {
        type: vector<u8>,
        amount: u64,
    }

    struct RouterSwapCap<phantom T0> {
        coin_in: 0x2::coin::Coin<T0>,
        min_amount_out: u64,
        first_swap: SwapMetadata,
        previous_swap: SwapMetadata,
        final_swap: SwapMetadata,
        router_fee_metadata: RouterFeeMetadata,
        referrer: 0x1::option::Option<address>,
    }

    public fun assert_valid_swap<T0, T1>(arg0: &RouterSwapCap<T0>, arg1: &0x2::coin::Coin<T1>) {
        assert!(is_valid_swap<T0, T1>(arg0, arg1), 3);
    }

    fun emit_swap_completed_event(arg0: SwapMetadata, arg1: SwapMetadata, arg2: RouterFeeMetadata, arg3: 0x1::option::Option<address>, arg4: &0x2::tx_context::TxContext) {
        let v0 = SwapCompletedEvent{
            swapper              : 0x2::tx_context::sender(arg4),
            type_in              : 0x1::ascii::string(arg0.type),
            amount_in            : arg0.amount,
            type_out             : 0x1::ascii::string(arg1.type),
            amount_out           : arg1.amount,
            router_fee_recipient : arg2.recipient,
            router_fee           : arg2.fee,
            referrer             : arg3,
        };
        0x2::event::emit<SwapCompletedEvent>(v0);
    }

    public fun initiate_path<T0>(arg0: &mut RouterSwapCap<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        update_final_swap_metadata<T0>(arg0);
        update_path_metadata_inner<T0, T0>(arg0, arg1);
        0x2::coin::split<T0>(&mut arg0.coin_in, arg1, arg2)
    }

    fun is_same_type<T0>(arg0: &vector<u8>) : bool {
        let v0 = type_to_bytes<T0>();
        &v0 == arg0
    }

    fun is_valid_swap<T0, T1>(arg0: &RouterSwapCap<T0>, arg1: &0x2::coin::Coin<T1>) : bool {
        is_same_type<T1>(&arg0.previous_swap.type) && 0x2::coin::value<T1>(arg1) == arg0.previous_swap.amount
    }

    public fun obtain_router_cap<T0, T1>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: 0x1::option::Option<address>, arg3: 0x1::option::Option<address>, arg4: 0x1::option::Option<u64>) : RouterSwapCap<T0> {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        let v1 = if (0x1::option::is_some<address>(&arg3) && 0x1::option::is_some<u64>(&arg4)) {
            RouterFeeMetadata{recipient: 0x1::option::extract<address>(&mut arg3), fee: 0x1::option::extract<u64>(&mut arg4)}
        } else {
            RouterFeeMetadata{recipient: @0x0, fee: 0}
        };
        let v2 = SwapMetadata{
            type   : type_to_bytes<T0>(),
            amount : v0,
        };
        let v3 = SwapMetadata{
            type   : b"",
            amount : 0,
        };
        let v4 = SwapMetadata{
            type   : type_to_bytes<T1>(),
            amount : 0,
        };
        RouterSwapCap<T0>{
            coin_in             : arg0,
            min_amount_out      : arg1,
            first_swap          : v2,
            previous_swap       : v3,
            final_swap          : v4,
            router_fee_metadata : v1,
            referrer            : arg2,
        }
    }

    public fun pay_protocol_and_router_fee<T0, T1, T2>(arg0: &0x2::object::UID, arg1: &mut RouterSwapCap<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: &0x50b4040c270ab7a2bd071218814a33f7c97e4d69c280e5132d26f1f4cff08ff0::vault::ProtocolFeeVault, arg4: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg5: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg6: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::admin::is_authorized(arg0), 0);
        pay_protocol_and_router_fee_inner<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        update_path_metadata_inner<T0, T2>(arg1, 0);
    }

    fun pay_protocol_and_router_fee_inner<T0, T1>(arg0: &mut RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0x50b4040c270ab7a2bd071218814a33f7c97e4d69c280e5132d26f1f4cff08ff0::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.min_amount_out <= arg0.final_swap.amount, 5);
        assert!(0 < 0x2::coin::value<T1>(arg1), 6);
        0x50b4040c270ab7a2bd071218814a33f7c97e4d69c280e5132d26f1f4cff08ff0::vault::collect_fees<T1>(arg2, arg3, arg4, arg5, arg1, 0x2::tx_context::sender(arg6), arg6);
        transfer_router_fee<T1>(arg1, arg0.router_fee_metadata, arg6);
    }

    fun previous_swap_was_valid<T0>(arg0: &RouterSwapCap<T0>) : bool {
        arg0.previous_swap.type == arg0.final_swap.type || arg0.previous_swap.amount == 0
    }

    public fun return_router_cap<T0, T1>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::coin::Coin<T1>, arg2: &0x50b4040c270ab7a2bd071218814a33f7c97e4d69c280e5132d26f1f4cff08ff0::vault::ProtocolFeeVault, arg3: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg4: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg5: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        let v1 = &mut arg0;
        pay_protocol_and_router_fee_inner<T0, T1>(v1, arg1, arg2, arg3, arg4, arg5, arg6);
        let RouterSwapCap {
            coin_in             : v2,
            min_amount_out      : _,
            first_swap          : v4,
            previous_swap       : _,
            final_swap          : v6,
            router_fee_metadata : v7,
            referrer            : v8,
        } = arg0;
        0x2::coin::destroy_zero<T0>(v2);
        emit_swap_completed_event(v4, v6, v7, v8, arg6);
    }

    public fun return_router_cap_already_payed_fee<T0>(arg0: RouterSwapCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        update_final_swap_metadata<T0>(v0);
        assert!(arg0.final_swap.amount == 0, 7);
        let RouterSwapCap {
            coin_in             : v1,
            min_amount_out      : _,
            first_swap          : v3,
            previous_swap       : _,
            final_swap          : v5,
            router_fee_metadata : v6,
            referrer            : v7,
        } = arg0;
        0x2::coin::destroy_zero<T0>(v1);
        emit_swap_completed_event(v3, v5, v6, v7, arg1);
    }

    fun transfer_router_fee<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: RouterFeeMetadata, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg1.recipient != @0x0 && arg1.fee != 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, 0x78548ffea3a06853d89dded8c6cdbed1fafc69d89469c4693c2373d6d600f666::fixed::mul_by_fraction(0x2::coin::value<T0>(arg0), arg1.fee), arg2), arg1.recipient);
        };
    }

    fun type_to_bytes<T0>() : vector<u8> {
        let v0 = 0x1::type_name::get<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::borrow_string(&v0))
    }

    fun update_final_swap_metadata<T0>(arg0: &mut RouterSwapCap<T0>) {
        assert!(previous_swap_was_valid<T0>(arg0), 4);
        arg0.final_swap.amount = arg0.final_swap.amount + arg0.previous_swap.amount;
    }

    public fun update_path_metadata<T0, T1>(arg0: &0x2::object::UID, arg1: &mut RouterSwapCap<T0>, arg2: u64) {
        assert!(0xe16daff2fcdfff4075ec5a87eb33e5836368817a50c2d76f0b9b9fc5ffe0a55f::admin::is_authorized(arg0), 0);
        update_path_metadata_inner<T0, T1>(arg1, arg2);
    }

    fun update_path_metadata_inner<T0, T1>(arg0: &mut RouterSwapCap<T0>, arg1: u64) {
        let v0 = SwapMetadata{
            type   : type_to_bytes<T1>(),
            amount : arg1,
        };
        arg0.previous_swap = v0;
    }

    // decompiled from Move bytecode v6
}

