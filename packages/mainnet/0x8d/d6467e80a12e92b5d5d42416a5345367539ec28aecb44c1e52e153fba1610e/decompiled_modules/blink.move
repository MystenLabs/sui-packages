module 0x8dd6467e80a12e92b5d5d42416a5345367539ec28aecb44c1e52e153fba1610e::blink {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Escrow has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: address,
        voucher_signers: vector<vector<u8>>,
        deposits: 0x2::bag::Bag,
        voucher_float: 0x2::bag::Bag,
        settled: 0x2::table::Table<vector<u8>, u64>,
        vouchers: 0x2::table::Table<vector<u8>, bool>,
    }

    struct SwapExecutorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SourceSwapSponsorKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SwapFunding has drop {
        dummy_field: bool,
    }

    struct SourceSwapFunding has drop {
        dummy_field: bool,
    }

    struct SourceSwapIntent<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        quote_hash: vector<u8>,
        funder: address,
        src_amount: u64,
        min_bridge_out: u64,
        expires_at_ms: u64,
    }

    struct SourceSwap<phantom T0> {
        quote_hash: vector<u8>,
        funder: address,
        src_coin_type: 0x1::ascii::String,
        src_amount: u64,
        min_bridge_out: u64,
    }

    struct Deposit has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        from: address,
    }

    struct Fulfilled has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        recipient: address,
        gas_drop: u64,
    }

    struct SwapDeposit has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        from: address,
        src_coin_type: 0x1::ascii::String,
        src_amount: u64,
    }

    struct SourceSwapOpened has copy, drop {
        intent: 0x2::object::ID,
        quote_hash: vector<u8>,
        funder: address,
        src_coin_type: 0x1::ascii::String,
        src_amount: u64,
        coin_type: 0x1::ascii::String,
        min_bridge_out: u64,
        expires_at_ms: u64,
    }

    struct SwapFulfilled has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        swap_out: u64,
        recipient: address,
        gas_drop: u64,
    }

    struct Refunded has copy, drop {
        quote_hash: vector<u8>,
        coin_type: 0x1::ascii::String,
        amount: u64,
        recipient: address,
    }

    struct Released has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct VoucherRedeemed has copy, drop {
        id: vector<u8>,
        coin_type: 0x1::ascii::String,
        referrer: address,
        amount: u64,
    }

    public fun add_voucher_signer(arg0: &AdminCap, arg1: &mut Escrow, arg2: vector<u8>) {
        assert_current_version(arg1);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        0x1::vector::push_back<vector<u8>>(&mut arg1.voucher_signers, arg2);
    }

    fun assert_current_version(arg0: &Escrow) {
        assert!(arg0.version == 1, 10);
    }

    fun assert_swap_fill(arg0: &Escrow, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sponsor(arg1) == 0x1::option::some<address>(arg0.treasury), 0);
        assert!(is_swap_executor(arg0, 0x2::tx_context::sender(arg1)), 0);
    }

    public fun begin_source_swap<T0, T1>(arg0: &Escrow, arg1: SourceSwapIntent<T0, T1>, arg2: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg3: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, SourceSwap<T1>) {
        assert_current_version(arg0);
        assert!(is_swap_executor(arg0, 0x2::tx_context::sender(arg5)), 0);
        assert!(is_source_swap_sponsor(arg0, 0x2::tx_context::sponsor(arg5)), 0);
        let SourceSwapIntent {
            id             : v0,
            quote_hash     : v1,
            funder         : v2,
            src_amount     : v3,
            min_bridge_out : v4,
            expires_at_ms  : v5,
        } = arg1;
        0x2::object::delete(v0);
        assert!(0x2::clock::timestamp_ms(arg4) < v5, 9);
        let v6 = 0x2::allowance::allowance_settings<0x2::balance::Balance<T0>>(arg2);
        assert!(0x2::allowance::funder(v6) == v2, 8);
        assert!(0x2::allowance::lifetime_cap(v6) == 0x1::option::some<u256>((v3 as u256)), 8);
        assert!(0x2::allowance::expiration_timestamp_ms(v6) == 0x1::option::some<u64>(v5), 8);
        assert!(0x2::allowance::allowance_current_spend<0x2::balance::Balance<T0>>(arg2) == 0, 8);
        let v7 = 0x2::allowance::app_balance_spend<T0, SourceSwapFunding>(arg2, 0x2::allowance::spend_permit<SourceSwapFunding>(0x1::internal::permit<SourceSwapFunding>()), arg3, arg4, arg5);
        assert!(0x2::balance::value<T0>(&v7) == v3, 8);
        let v8 = SourceSwap<T1>{
            quote_hash     : v1,
            funder         : v2,
            src_coin_type  : coin_type_string<T0>(),
            src_amount     : v3,
            min_bridge_out : v4,
        };
        (0x2::coin::from_balance<T0>(v7, arg5), v8)
    }

    fun coin_type_string<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>())
    }

    fun credit<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::bag::contains<0x1::type_name::TypeName>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
    }

    fun debit<T0>(arg0: &mut 0x2::bag::Bag, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(0x2::bag::borrow_mut<0x1::type_name::TypeName, 0x2::balance::Balance<T0>>(arg0, 0x1::type_name::with_defining_ids<T0>()), arg1)
    }

    public fun defund_vouchers<T0>(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        let v0 = &mut arg0.voucher_float;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v0, arg1), arg2), arg0.treasury);
    }

    public fun deposit<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        let v0 = &mut arg0.deposits;
        credit<T0>(v0, 0x2::coin::into_balance<T0>(arg2));
        let v1 = Deposit{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : 0x2::coin::value<T0>(&arg2),
            from       : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Deposit>(v1);
    }

    public fun draw_swap_funds<T0>(arg0: &Escrow, arg1: &mut 0x2::allowance::Allowance<0x2::balance::Balance<T0>>, arg2: 0x2::allowance::AllowanceWithdrawal<0x2::balance::Balance<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_current_version(arg0);
        assert_swap_fill(arg0, arg4);
        0x2::coin::from_balance<T0>(0x2::allowance::app_balance_spend<T0, SwapFunding>(arg1, 0x2::allowance::spend_permit<SwapFunding>(0x1::internal::permit<SwapFunding>()), arg2, arg3, arg4), arg4)
    }

    public fun finish_source_swap<T0>(arg0: &mut Escrow, arg1: SourceSwap<T0>, arg2: 0x2::coin::Coin<T0>) {
        assert_current_version(arg0);
        let SourceSwap {
            quote_hash     : v0,
            funder         : v1,
            src_coin_type  : v2,
            src_amount     : v3,
            min_bridge_out : v4,
        } = arg1;
        let v5 = 0x2::coin::value<T0>(&arg2);
        assert!(v5 >= v4, 6);
        let v6 = &mut arg0.deposits;
        credit<T0>(v6, 0x2::coin::into_balance<T0>(arg2));
        let v7 = SwapDeposit{
            quote_hash    : v0,
            coin_type     : coin_type_string<T0>(),
            amount        : v5,
            from          : v1,
            src_coin_type : v2,
            src_amount    : v3,
        };
        0x2::event::emit<SwapDeposit>(v7);
    }

    public fun fulfill<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: address, arg5: &0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg5) == arg0.treasury, 0);
        mark_settled(arg0, arg1, arg5);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, arg4);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg4);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg3);
        };
        let v1 = Fulfilled{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : 0x2::coin::value<T0>(&arg2),
            recipient  : arg4,
            gas_drop   : v0,
        };
        0x2::event::emit<Fulfilled>(v1);
    }

    public fun fulfill_swap<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert_swap_fill(arg0, arg7);
        mark_settled(arg0, arg1, arg7);
        let v0 = 0x2::coin::value<T0>(&arg2);
        assert!(v0 >= arg4, 6);
        let v1 = 0x1::u64::min(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut arg2, v1, arg7), arg6);
        if (0x2::coin::value<T0>(&arg2) > 0) {
            0x2::coin::send_funds<T0>(arg2, arg0.treasury);
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg5);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, arg6);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg5);
        };
        let v3 = SwapFulfilled{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : v1,
            swap_out   : v0,
            recipient  : arg6,
            gas_drop   : v2,
        };
        0x2::event::emit<SwapFulfilled>(v3);
    }

    public fun fund_vouchers<T0>(arg0: &mut Escrow, arg1: 0x2::coin::Coin<T0>) {
        assert_current_version(arg0);
        let v0 = &mut arg0.voucher_float;
        credit<T0>(v0, 0x2::coin::into_balance<T0>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Escrow{
            id              : 0x2::object::new(arg0),
            version         : 1,
            treasury        : 0x2::tx_context::sender(arg0),
            voucher_signers : vector[],
            deposits        : 0x2::bag::new(arg0),
            voucher_float   : 0x2::bag::new(arg0),
            settled         : 0x2::table::new<vector<u8>, u64>(arg0),
            vouchers        : 0x2::table::new<vector<u8>, bool>(arg0),
        };
        0x2::transfer::share_object<Escrow>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    fun is_source_swap_sponsor(arg0: &Escrow, arg1: 0x1::option::Option<address>) : bool {
        let v0 = SourceSwapSponsorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SourceSwapSponsorKey>(&arg0.id, v0)) {
            let v2 = SourceSwapSponsorKey{dummy_field: false};
            arg1 == 0x1::option::some<address>(*0x2::dynamic_field::borrow<SourceSwapSponsorKey, address>(&arg0.id, v2))
        } else {
            false
        }
    }

    fun is_swap_executor(arg0: &Escrow, arg1: address) : bool {
        let v0 = SwapExecutorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SwapExecutorKey>(&arg0.id, v0)) {
            let v2 = SwapExecutorKey{dummy_field: false};
            *0x2::dynamic_field::borrow<SwapExecutorKey, address>(&arg0.id, v2) == arg1
        } else {
            false
        }
    }

    public fun issue_swap_allowance<T0>(arg0: &Escrow, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        0x2::allowance::issue<0x2::balance::Balance<T0>, SwapFunding>(arg1, 0x2::allowance::settings_permit<SwapFunding>(0x1::internal::permit<SwapFunding>()), arg2);
    }

    fun mark_settled(arg0: &mut Escrow, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.settled, arg1), 1);
        0x2::table::add<vector<u8>, u64>(&mut arg0.settled, arg1, 0x2::tx_context::epoch(arg2));
    }

    public fun migrate(arg0: &AdminCap, arg1: &mut Escrow) {
        assert!(arg1.version < 1, 11);
        arg1.version = 1;
    }

    public fun open_source_swap<T0, T1>(arg0: &Escrow, arg1: 0x2::allowance::AllowanceProposal<0x2::balance::Balance<T0>>, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 4);
        let v0 = 0x2::allowance::allowance_proposal_settings<0x2::balance::Balance<T0>>(&arg1);
        assert!(is_swap_executor(arg0, 0x1::option::destroy_some<address>(0x2::allowance::spender(v0))), 0);
        let (v1, v2) = source_swap_terms(v0, arg4);
        0x2::allowance::issue<0x2::balance::Balance<T0>, SourceSwapFunding>(arg1, 0x2::allowance::settings_permit<SourceSwapFunding>(0x1::internal::permit<SourceSwapFunding>()), arg5);
        let v3 = SourceSwapIntent<T0, T1>{
            id             : 0x2::object::new(arg5),
            quote_hash     : arg2,
            funder         : 0x2::tx_context::sender(arg5),
            src_amount     : v1,
            min_bridge_out : arg3,
            expires_at_ms  : v2,
        };
        let v4 = SourceSwapOpened{
            intent         : 0x2::object::id<SourceSwapIntent<T0, T1>>(&v3),
            quote_hash     : arg2,
            funder         : 0x2::tx_context::sender(arg5),
            src_coin_type  : coin_type_string<T0>(),
            src_amount     : v1,
            coin_type      : coin_type_string<T1>(),
            min_bridge_out : arg3,
            expires_at_ms  : v2,
        };
        0x2::event::emit<SourceSwapOpened>(v4);
        0x2::transfer::share_object<SourceSwapIntent<T0, T1>>(v3);
    }

    public fun prune(arg0: &mut Escrow, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::epoch(arg2) >= *0x2::table::borrow<vector<u8>, u64>(&arg0.settled, arg1) + 180, 5);
        0x2::table::remove<vector<u8>, u64>(&mut arg0.settled, arg1);
    }

    public fun redeem_voucher<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 4);
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.vouchers, arg1), 2);
        0x2::table::add<vector<u8>, bool>(&mut arg0.vouchers, arg1, true);
        let v0 = voucher_message<T0>(arg0, arg1, arg2, arg3);
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(&arg0.voucher_signers)) {
            if (0x2::ed25519::ed25519_verify(&arg4, 0x1::vector::borrow<vector<u8>>(&arg0.voucher_signers, v2), &v0)) {
                v1 = true;
                break
            };
            v2 = v2 + 1;
        };
        assert!(v1, 3);
        let v3 = &mut arg0.voucher_float;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v3, arg3), arg5), arg2);
        let v4 = VoucherRedeemed{
            id        : arg1,
            coin_type : coin_type_string<T0>(),
            referrer  : arg2,
            amount    : arg3,
        };
        0x2::event::emit<VoucherRedeemed>(v4);
    }

    public fun refund<T0>(arg0: &mut Escrow, arg1: vector<u8>, arg2: vector<u8>, arg3: u32, arg4: u64, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg6) == arg0.treasury, 0);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 4);
        assert!(!0x2::table::contains<vector<u8>, u64>(&arg0.settled, arg1), 7);
        mark_settled(arg0, refund_marker(arg2, arg3), arg6);
        let v0 = &mut arg0.deposits;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v0, arg4), arg6), arg5);
        let v1 = Refunded{
            quote_hash : arg1,
            coin_type  : coin_type_string<T0>(),
            amount     : arg4,
            recipient  : arg5,
        };
        0x2::event::emit<Refunded>(v1);
    }

    fun refund_marker(arg0: vector<u8>, arg1: u32) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 4);
        let v0 = b"blink-refund";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u32>(&arg1));
        0x2::hash::blake2b256(&v0)
    }

    public fun release<T0>(arg0: &mut Escrow, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        let v0 = &mut arg0.deposits;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(debit<T0>(v0, arg1), arg2), arg0.treasury);
        let v1 = Released{
            coin_type : coin_type_string<T0>(),
            amount    : arg1,
        };
        0x2::event::emit<Released>(v1);
    }

    public fun set_source_swap_sponsor(arg0: &AdminCap, arg1: &mut Escrow, arg2: address) {
        assert_current_version(arg1);
        let v0 = SourceSwapSponsorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SourceSwapSponsorKey>(&arg1.id, v0)) {
            let v1 = SourceSwapSponsorKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SourceSwapSponsorKey, address>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = SourceSwapSponsorKey{dummy_field: false};
            0x2::dynamic_field::add<SourceSwapSponsorKey, address>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_swap_executor(arg0: &AdminCap, arg1: &mut Escrow, arg2: address) {
        assert_current_version(arg1);
        let v0 = SwapExecutorKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SwapExecutorKey>(&arg1.id, v0)) {
            let v1 = SwapExecutorKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<SwapExecutorKey, address>(&mut arg1.id, v1) = arg2;
        } else {
            let v2 = SwapExecutorKey{dummy_field: false};
            0x2::dynamic_field::add<SwapExecutorKey, address>(&mut arg1.id, v2, arg2);
        };
    }

    public fun set_treasury(arg0: &AdminCap, arg1: &mut Escrow, arg2: address) {
        assert_current_version(arg1);
        arg1.treasury = arg2;
    }

    fun source_swap_terms(arg0: &0x2::allowance::Settings, arg1: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x2::allowance::rate_limit(arg0);
        assert!(0x1::option::is_none<0x2::allowance::RateLimit>(&v0), 8);
        let v1 = 0x2::allowance::start_timestamp_ms(arg0);
        assert!(0x1::option::is_none<u64>(&v1), 8);
        let v2 = 0x1::option::destroy_some<u256>(0x2::allowance::lifetime_cap(arg0));
        let v3 = 0x1::option::destroy_some<u64>(0x2::allowance::expiration_timestamp_ms(arg0));
        let v4 = 0x2::clock::timestamp_ms(arg1);
        assert!(v2 <= 18446744073709551615, 8);
        assert!(v3 > v4, 8);
        assert!(v3 - v4 <= 300000, 8);
        ((v2 as u64), v3)
    }

    fun void_marker(arg0: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 4);
        let v0 = b"blink-void";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x2::hash::blake2b256(&v0)
    }

    public fun void_quote(arg0: &mut Escrow, arg1: vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(0x2::tx_context::sender(arg2) == arg0.treasury, 0);
        let v0 = void_marker(arg1);
        if (0x2::table::contains<vector<u8>, u64>(&arg0.settled, v0)) {
            return
        };
        mark_settled(arg0, arg1, arg2);
        0x2::table::add<vector<u8>, u64>(&mut arg0.settled, v0, 0x2::tx_context::epoch(arg2));
    }

    fun voucher_message<T0>(arg0: &Escrow, arg1: vector<u8>, arg2: address, arg3: u64) : vector<u8> {
        let v0 = b"sui";
        let v1 = b"blink-voucher";
        0x1::vector::push_back<u8>(&mut v1, (0x1::vector::length<u8>(&v0) as u8));
        0x1::vector::append<u8>(&mut v1, v0);
        0x1::vector::append<u8>(&mut v1, 0x2::object::uid_to_bytes(&arg0.id));
        0x1::vector::append<u8>(&mut v1, arg1);
        let v2 = 0x1::ascii::into_bytes(coin_type_string<T0>());
        let v3 = (0x1::vector::length<u8>(&v2) as u16);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u16>(&v3));
        0x1::vector::append<u8>(&mut v1, v2);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        v1
    }

    // decompiled from Move bytecode v7
}

