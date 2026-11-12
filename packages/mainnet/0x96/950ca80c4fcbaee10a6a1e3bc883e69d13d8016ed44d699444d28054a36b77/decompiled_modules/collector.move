module 0x96950ca80c4fcbaee10a6a1e3bc883e69d13d8016ed44d699444d28054a36b77::collector {
    struct ReceiveAuth has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        collector: 0x2::object::ID,
    }

    struct ClaimKey has copy, drop, store {
        source_domain: u32,
        nonce: u256,
    }

    struct Claim has copy, drop, store {
        recipient: address,
        amount: u64,
        fee: u64,
    }

    struct Collector has key {
        id: 0x2::object::UID,
        version: u64,
        configured: bool,
        paused: bool,
        message_state: 0x2::object::ID,
        token_state: 0x2::object::ID,
        fee_recipient: address,
        fees: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        total_fees_collected: u128,
        total_fees_withdrawn: u128,
        pending_amount: u128,
        claims: 0x2::table::Table<ClaimKey, Claim>,
    }

    struct ClaimRegistered has copy, drop {
        collector: 0x2::object::ID,
        source_domain: u32,
        nonce: u256,
        recipient: address,
        amount: u64,
        fee: u64,
    }

    struct FundsForwarded has copy, drop {
        collector: 0x2::object::ID,
        source_domain: u32,
        nonce: u256,
        recipient: address,
        total_amount: u64,
        fee_amount: u64,
        user_amount: u64,
    }

    struct FeesWithdrawn has copy, drop {
        collector: 0x2::object::ID,
        to: address,
        amount: u64,
    }

    struct FeeRecipientUpdated has copy, drop {
        collector: 0x2::object::ID,
        old_recipient: address,
        new_recipient: address,
    }

    struct PauseUpdated has copy, drop {
        collector: 0x2::object::ID,
        paused: bool,
    }

    struct Configured has copy, drop {
        collector: 0x2::object::ID,
        message_state: 0x2::object::ID,
        token_state: 0x2::object::ID,
        fee_recipient: address,
    }

    fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : (Collector, AdminCap) {
        let v0 = 0x2::object::new(arg1);
        let v1 = AdminCap{
            id        : 0x2::object::new(arg1),
            collector : 0x2::object::uid_to_inner(&v0),
        };
        let v2 = Collector{
            id                   : v0,
            version              : 1,
            configured           : false,
            paused               : false,
            message_state        : 0x2::object::id_from_address(@0x0),
            token_state          : 0x2::object::id_from_address(@0x0),
            fee_recipient        : arg0,
            fees                 : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            total_fees_collected : 0,
            total_fees_withdrawn : 0,
            pending_amount       : 0,
            claims               : 0x2::table::new<ClaimKey, Claim>(arg1),
        };
        (v2, v1)
    }

    fun assert_address(arg0: &Collector, arg1: address) {
        assert!(arg1 != @0x0 && arg1 != 0x2::object::id_address<Collector>(arg0), 2);
    }

    fun assert_admin(arg0: &Collector, arg1: &AdminCap) {
        assert_version(arg0);
        assert!(arg1.collector == 0x2::object::id<Collector>(arg0), 1);
    }

    fun assert_version(arg0: &Collector) {
        assert!(arg0.version == 1, 12);
    }

    public fun caller_identifier() : address {
        0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::auth::auth_caller_identifier<ReceiveAuth>()
    }

    public fun configure(arg0: &mut Collector, arg1: &AdminCap, arg2: &0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg3: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg4: address) {
        assert_admin(arg0, arg1);
        assert!(!arg0.configured, 10);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::local_domain(arg2) == 8, 9);
        assert_address(arg0, arg4);
        arg0.message_state = 0x2::object::id<0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State>(arg2);
        arg0.token_state = 0x2::object::id<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State>(arg3);
        arg0.fee_recipient = arg4;
        arg0.configured = true;
        let v0 = Configured{
            collector     : 0x2::object::id<Collector>(arg0),
            message_state : arg0.message_state,
            token_state   : arg0.token_state,
            fee_recipient : arg4,
        };
        0x2::event::emit<Configured>(v0);
    }

    public fun fee_balance(arg0: &Collector) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fees)
    }

    public fun has_claim(arg0: &Collector, arg1: u32, arg2: u256) : bool {
        let v0 = ClaimKey{
            source_domain : arg1,
            nonce         : arg2,
        };
        0x2::table::contains<ClaimKey, Claim>(&arg0.claims, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let (v1, v2) = new(v0, arg0);
        0x2::transfer::share_object<Collector>(v1);
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun pending_amount(arg0: &Collector) : u128 {
        arg0.pending_amount
    }

    fun prepare(arg0: &mut Collector, arg1: 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::Receipt, arg2: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg3: &0x2::clock::Clock) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::MintReceipt<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::message_body(&arg1);
        assert!(0x1::vector::length<u8>(v0) == 292, 13);
        let v1 = 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::vector_utils::slice<u8>(v0, 228, 292);
        let (v2, v3) = 0x96950ca80c4fcbaee10a6a1e3bc883e69d13d8016ed44d699444d28054a36b77::fee_payload::decode(&v1);
        let v4 = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::prepare_mint<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, arg3);
        let (_, v6, v7, _) = 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::get_mint_details<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v4);
        assert!(v6 == 0x2::object::id_address<Collector>(arg0), 5);
        register(arg0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::source_domain(&arg1), 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::nonce(&arg1), v2, v7, v3);
        v4
    }

    public fun receive_and_register(arg0: &mut Collector, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State, arg4: &0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State, arg5: &0x2::clock::Clock) : 0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::handle_receive_message::MintReceipt<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        assert_version(arg0);
        assert!(arg0.configured, 11);
        assert!(!arg0.paused, 0);
        assert!(0x2::object::id<0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::state::State>(arg3) == arg0.message_state, 9);
        assert!(0x2::object::id<0xeb14978abfe93a37c5d5bf86a0623b923553a5f0e794daac7724f1e2fdbfb830::state::State>(arg4) == arg0.token_state, 9);
        assert!(0x1::vector::length<u8>(&arg1) == 440, 13);
        assert!(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::deserialize::deserialize_address(&arg1, 108, 32) == caller_identifier(), 8);
        let v0 = ReceiveAuth{dummy_field: false};
        prepare(arg0, 0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::receive_message_with_package_auth<ReceiveAuth>(0x16bcfcfc465f96281663a344641c017de84529370e11aa3879d0dce43ad6db87::receive_message::create_receive_message_ticket<ReceiveAuth>(v0, arg1, arg2), arg3), arg4, arg5)
    }

    fun register(arg0: &mut Collector, arg1: u32, arg2: u256, arg3: address, arg4: u64, arg5: u64) {
        assert_address(arg0, arg3);
        assert!(arg4 > 0, 4);
        assert!(arg5 <= arg4, 3);
        let v0 = ClaimKey{
            source_domain : arg1,
            nonce         : arg2,
        };
        assert!(!0x2::table::contains<ClaimKey, Claim>(&arg0.claims, v0), 6);
        let v1 = Claim{
            recipient : arg3,
            amount    : arg4,
            fee       : arg5,
        };
        0x2::table::add<ClaimKey, Claim>(&mut arg0.claims, v0, v1);
        arg0.pending_amount = arg0.pending_amount + (arg4 as u128);
        let v2 = ClaimRegistered{
            collector     : 0x2::object::id<Collector>(arg0),
            source_domain : arg1,
            nonce         : arg2,
            recipient     : arg3,
            amount        : arg4,
            fee           : arg5,
        };
        0x2::event::emit<ClaimRegistered>(v2);
    }

    public fun set_fee_recipient(arg0: &mut Collector, arg1: &AdminCap, arg2: address) {
        assert_admin(arg0, arg1);
        assert_address(arg0, arg2);
        arg0.fee_recipient = arg2;
        let v0 = FeeRecipientUpdated{
            collector     : 0x2::object::id<Collector>(arg0),
            old_recipient : arg0.fee_recipient,
            new_recipient : arg2,
        };
        0x2::event::emit<FeeRecipientUpdated>(v0);
    }

    public fun set_paused(arg0: &mut Collector, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        assert!(arg0.configured, 11);
        arg0.paused = arg2;
        let v0 = PauseUpdated{
            collector : 0x2::object::id<Collector>(arg0),
            paused    : arg2,
        };
        0x2::event::emit<PauseUpdated>(v0);
    }

    public fun settle(arg0: &mut Collector, arg1: u32, arg2: u256, arg3: 0x2::transfer::Receiving<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(&mut arg0.id, arg3);
        settle_coin(arg0, arg1, arg2, v0, arg4);
    }

    fun settle_coin(arg0: &mut Collector, arg1: u32, arg2: u256, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ClaimKey{
            source_domain : arg1,
            nonce         : arg2,
        };
        assert!(0x2::table::contains<ClaimKey, Claim>(&arg0.claims, v0), 7);
        let Claim {
            recipient : v1,
            amount    : v2,
            fee       : v3,
        } = 0x2::table::remove<ClaimKey, Claim>(&mut arg0.claims, v0);
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3) == v2, 4);
        arg0.pending_amount = arg0.pending_amount - (v2 as u128);
        if (v3 > 0) {
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fees, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::coin::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg3, v3, arg4)));
            arg0.total_fees_collected = arg0.total_fees_collected + (v3 as u128);
        };
        let v4 = v2 - v3;
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(arg3, v1);
        } else {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3);
        };
        let v5 = FundsForwarded{
            collector     : 0x2::object::id<Collector>(arg0),
            source_domain : arg1,
            nonce         : arg2,
            recipient     : v1,
            total_amount  : v2,
            fee_amount    : v3,
            user_amount   : v4,
        };
        0x2::event::emit<FundsForwarded>(v5);
    }

    public fun total_fees_collected(arg0: &Collector) : u128 {
        arg0.total_fees_collected
    }

    public fun total_fees_withdrawn(arg0: &Collector) : u128 {
        arg0.total_fees_withdrawn
    }

    public fun withdraw_fees(arg0: &mut Collector, arg1: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0);
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fees);
        assert!(v0 > 0, 4);
        arg0.total_fees_withdrawn = arg0.total_fees_withdrawn + (v0 as u128);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>>(0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fees), arg1), arg0.fee_recipient);
        let v1 = FeesWithdrawn{
            collector : 0x2::object::id<Collector>(arg0),
            to        : arg0.fee_recipient,
            amount    : v0,
        };
        0x2::event::emit<FeesWithdrawn>(v1);
    }

    // decompiled from Move bytecode v7
}

