module 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::xswap {
    struct XSWAP has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct Digest has copy, drop, store {
        pos0: u8,
        pos1: vector<u8>,
    }

    struct Request has key {
        id: 0x2::object::UID,
        user: address,
        wallet_key: u64,
        source_address: vector<u8>,
        source_chain: u8,
        source_token: vector<u8>,
        source_amount: u256,
        destination_chain: u8,
        destination_token: vector<u8>,
        destination_address: vector<u8>,
        min_destination_amount: u256,
        min_confirmations: u8,
        created_at: u64,
        deadline: u64,
        status: u8,
        relayer_sender: vector<u8>,
        relayer_recipient: vector<u8>,
        deposit_digest: vector<u8>,
        settle_digest: 0x1::option::Option<vector<u8>>,
        settle_destination_amount: 0x1::option::Option<u256>,
        settled_at: 0x1::option::Option<u64>,
        signature_request_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct XSwap has key {
        id: 0x2::object::UID,
        wallet_keys: 0x2::vec_set::VecSet<u64>,
        relayers: 0x2::table::Table<vector<u8>, bool>,
        chains: 0x2::vec_set::VecSet<u8>,
        version: u64,
        paused: bool,
        digests: 0x2::table::Table<Digest, bool>,
    }

    public fun add_wallet(arg0: &mut XSwap, arg1: &mut 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::Ledger, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg4: 0x2::object::ID, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: vector<u8>, arg9: u32, arg10: u32, arg11: u32, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        let (v1, _) = 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::add_wallet<Witness>(arg1, arg2, v0, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::vec_set::insert<u64>(&mut arg0.wallet_keys, v1);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_wallet_added(v1);
    }

    public fun init_app(arg0: &mut 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::Ledger, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Witness{dummy_field: false};
        0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::init_app<Witness>(arg0, v0, arg1);
    }

    public fun add_chain(arg0: &mut XSwap, arg1: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::insert<u8>(&mut arg0.chains, arg2);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_chain_added(arg2);
    }

    public fun add_relayer(arg0: &mut XSwap, arg1: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::add<vector<u8>, bool>(&mut arg0.relayers, arg2, true);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_relayer_added(arg2);
    }

    public fun cancel_request(arg0: &mut XSwap, arg1: &0x2::clock::Clock, arg2: &0x9375630f3095f2217994c9ae791ad73244e1bf72bd537c9f715cba0de1de51da::registry::Registry, arg3: &mut Request, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg0.version == 1, 3);
        assert!(arg3.status == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg3.deadline, 10);
        assert!(sui_address(arg2, arg3.source_chain, arg3.relayer_sender) == 0x2::tx_context::sender(arg4), 17);
        arg3.status = 2;
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_request_cancelled(0x2::object::uid_to_inner(&arg3.id));
    }

    public fun expire_request(arg0: &mut XSwap, arg1: &0x2::clock::Clock, arg2: &mut Request, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.paused, 2);
        assert!(arg0.version == 1, 3);
        assert!(arg2.status == 0, 8);
        assert!(0x2::clock::timestamp_ms(arg1) > arg2.deadline, 14);
        arg2.status = 3;
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_request_expired(0x2::object::uid_to_inner(&arg2.id));
    }

    fun init(arg0: XSWAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::new_cap<XSWAP>(arg0, arg1);
        0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::new_config<XSWAP>(&v0, 0x1::string::utf8(b"XSwap"), x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", x"000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000", arg1);
        let v1 = XSwap{
            id          : 0x2::object::new(arg1),
            wallet_keys : 0x2::vec_set::empty<u64>(),
            relayers    : 0x2::table::new<vector<u8>, bool>(arg1),
            chains      : 0x2::vec_set::empty<u8>(),
            version     : 1,
            paused      : true,
            digests     : 0x2::table::new<Digest, bool>(arg1),
        };
        0x2::transfer::share_object<XSwap>(v1);
        0x2::transfer::public_transfer<0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::EnclaveCap<XSWAP>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun new_request(arg0: &mut XSwap, arg1: &0x2::clock::Clock, arg2: &mut 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::Ledger, arg3: &0x9375630f3095f2217994c9ae791ad73244e1bf72bd537c9f715cba0de1de51da::registry::Registry, arg4: &0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::Enclave<XSWAP>, arg5: 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::RequestParams, arg6: &mut 0x2::tx_context::TxContext) : Request {
        assert!(!arg0.paused, 2);
        assert!(arg0.version == 1, 3);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_deadline(&arg5) > v0, 11);
        let v1 = &arg5;
        let v2 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_chain(v1);
        assert!(0x2::vec_set::contains<u8>(&arg0.chains, &v2), 4);
        let v3 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_destination_chain(v1);
        assert!(0x2::vec_set::contains<u8>(&arg0.chains, &v3), 4);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg0.relayers, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_relayer_sender(v1)), 6);
        assert!(0x2::table::contains<vector<u8>, bool>(&arg0.relayers, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_relayer_recipient(v1)), 6);
        let v4 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_wallet_key(v1);
        assert!(0x2::vec_set::contains<u64>(&arg0.wallet_keys, &v4), 5);
        let v5 = sui_address(arg3, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_chain(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_address(&arg5));
        assert!(v5 == 0x2::tx_context::sender(arg6), 7);
        let v6 = Digest{
            pos0 : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_chain(&arg5),
            pos1 : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_digest(&arg5),
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.digests, v6), 12);
        0x2::table::add<Digest, bool>(&mut arg0.digests, v6, true);
        let v7 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_signature(&arg5);
        verify<0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::DepositResponse>(arg4, 0, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_timestamp_ms(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_to_response(&arg5), &v7);
        let v8 = 0x2::object::new(arg6);
        let v9 = Witness{dummy_field: false};
        0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::increment_balance<Witness>(arg2, v9, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_digest(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_wallet_key(&arg5), 0x2::object::uid_to_address(&v8), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_chain(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_token(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_amount(&arg5), arg6);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_request_created(&arg5, 0x2::object::uid_to_inner(&v8), v5);
        Request{
            id                        : v8,
            user                      : v5,
            wallet_key                : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_wallet_key(&arg5),
            source_address            : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_address(&arg5),
            source_chain              : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_chain(&arg5),
            source_token              : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_token(&arg5),
            source_amount             : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_source_amount(&arg5),
            destination_chain         : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_destination_chain(&arg5),
            destination_token         : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_destination_token(&arg5),
            destination_address       : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_destination_address(&arg5),
            min_destination_amount    : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_min_destination_amount(&arg5),
            min_confirmations         : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_min_confirmations(&arg5),
            created_at                : v0,
            deadline                  : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_deadline(&arg5),
            status                    : 0,
            relayer_sender            : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_relayer_sender(&arg5),
            relayer_recipient         : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_relayer_recipient(&arg5),
            deposit_digest            : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::request_params_digest(&arg5),
            settle_digest             : 0x1::option::none<vector<u8>>(),
            settle_destination_amount : 0x1::option::none<u256>(),
            settled_at                : 0x1::option::none<u64>(),
            signature_request_id      : 0x1::option::none<0x2::object::ID>(),
        }
    }

    public fun pause(arg0: &mut XSwap, arg1: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = true;
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_paused();
    }

    public fun remove_chain(arg0: &mut XSwap, arg1: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::vec_set::remove<u8>(&mut arg0.chains, &arg2);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_chain_removed(arg2);
    }

    public fun remove_relayer(arg0: &mut XSwap, arg1: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::table::remove<vector<u8>, bool>(&mut arg0.relayers, arg2);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_relayer_removed(arg2);
    }

    public fun settle_request(arg0: &mut XSwap, arg1: &0x2::clock::Clock, arg2: &mut 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::Ledger, arg3: &0x9375630f3095f2217994c9ae791ad73244e1bf72bd537c9f715cba0de1de51da::registry::Registry, arg4: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg5: &mut Request, arg6: &0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::Enclave<XSWAP>, arg7: 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::SettleParams, arg8: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 2);
        assert!(arg0.version == 1, 3);
        assert!(arg5.status == 0, 8);
        assert!(sui_address(arg3, arg5.destination_chain, arg5.relayer_sender) == 0x2::tx_context::sender(arg8), 17);
        let v0 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_message_centralized_signature(&arg7);
        assert!(!0x1::vector::is_empty<u8>(&v0), 18);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 <= arg5.deadline, 10);
        assert!(0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_destination_amount(&arg7) >= arg5.min_destination_amount, 9);
        assert!(0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_confirmations(&arg7) >= arg5.min_confirmations, 13);
        let v2 = Digest{
            pos0 : arg5.destination_chain,
            pos1 : 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_digest(&arg7),
        };
        assert!(!0x2::table::contains<Digest, bool>(&arg0.digests, v2), 12);
        let v3 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_signature(&arg7);
        verify<0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::SettleResponse>(arg6, 1, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_timestamp_ms(&arg7), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_to_response(&arg7, arg5.destination_chain, arg5.destination_address, arg5.destination_token, arg5.relayer_sender, arg5.source_chain, arg5.wallet_key, arg5.relayer_recipient, arg5.source_token, arg5.source_amount), &v3);
        0x2::table::add<Digest, bool>(&mut arg0.digests, v2, true);
        arg5.settle_digest = 0x1::option::some<vector<u8>>(0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_digest(&arg7));
        arg5.settle_destination_amount = 0x1::option::some<u256>(0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_destination_amount(&arg7));
        arg5.status = 1;
        arg5.settled_at = 0x1::option::some<u64>(v1);
        let v4 = Witness{dummy_field: false};
        let (_, v6) = 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::decrement_balance<Witness>(arg2, arg4, v4, arg5.wallet_key, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_message_centralized_signature(&arg7), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_message(&arg7), 0x2::object::uid_to_address(&arg5.id), arg5.source_chain, arg5.source_token, arg5.source_amount, arg8);
        arg5.signature_request_id = 0x1::option::some<0x2::object::ID>(v6);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_request_settled(0x2::object::uid_to_inner(&arg5.id), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_digest(&arg7), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::settle_params_destination_amount(&arg7), arg5.source_amount, v6);
        v6
    }

    public fun share_request(arg0: Request) {
        0x2::transfer::share_object<Request>(arg0);
    }

    fun sui_address(arg0: &0x9375630f3095f2217994c9ae791ad73244e1bf72bd537c9f715cba0de1de51da::registry::Registry, arg1: u8, arg2: vector<u8>) : address {
        let v0 = &arg1;
        if (*v0 == 1) {
            let v2 = 0x9375630f3095f2217994c9ae791ad73244e1bf72bd537c9f715cba0de1de51da::registry::get_sui_for_solana(arg0, arg2);
            0x1::option::extract<address>(&mut v2)
        } else if (*v0 == 2) {
            let v3 = 0x9375630f3095f2217994c9ae791ad73244e1bf72bd537c9f715cba0de1de51da::registry::get_sui_for_evm(arg0, arg2);
            0x1::option::extract<address>(&mut v3)
        } else {
            assert!(*v0 == 3, 1);
            0x2::address::from_bytes(arg2)
        }
    }

    public fun unpause(arg0: &mut XSwap, arg1: &0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::admin::AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.paused = false;
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_unpaused();
    }

    fun verify<T0: copy + drop>(arg0: &0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::Enclave<XSWAP>, arg1: u8, arg2: u64, arg3: T0, arg4: &vector<u8>) {
        assert!(0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::verify_signature<XSWAP, T0>(arg0, arg1, arg2, arg3, arg4), 0);
    }

    public fun withdraw_request(arg0: &mut XSwap, arg1: &mut 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::Ledger, arg2: &mut 0xdd24c62739923fbf582f49ef190b4a007f981ca6eb209ca94f3a8eaf7c611317::coordinator::DWalletCoordinator, arg3: &mut Request, arg4: &0x2e91396d5becde091f46d03112c979d985561167423adab6e5281856d088d6e8::enclave::Enclave<XSWAP>, arg5: 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::WithdrawParams, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(!arg0.paused, 2);
        assert!(arg0.version == 1, 3);
        let v0 = arg3.status;
        assert!(v0 == 2 || v0 == 3, 15);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg3.signature_request_id), 16);
        let v1 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::withdraw_params_message_centralized_signature(&arg5);
        assert!(!0x1::vector::is_empty<u8>(&v1), 18);
        let v2 = 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::withdraw_params_signature(&arg5);
        verify<0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::WithdrawResponse>(arg4, 2, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::withdraw_params_timestamp_ms(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::withdraw_params_to_response(&arg5, arg3.source_chain, arg3.wallet_key, arg3.source_address, arg3.source_token, arg3.source_amount), &v2);
        let v3 = Witness{dummy_field: false};
        let (_, v5) = 0x277230eb2abcd712b9036fb2f9fbf04e1c0e6dda58ef9e736c04383d2e70990f::ledger::decrement_balance<Witness>(arg1, arg2, v3, arg3.wallet_key, 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::withdraw_params_message_centralized_signature(&arg5), 0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::withdraw_params_message(&arg5), 0x2::object::uid_to_address(&arg3.id), arg3.source_chain, arg3.source_token, arg3.source_amount, arg6);
        arg3.signature_request_id = 0x1::option::some<0x2::object::ID>(v5);
        0xb97718502f45c4db29488422b208fa5e7efc919002da988e47fd3276bfc9e684::structs::emit_request_withdrawn(0x2::object::uid_to_inner(&arg3.id), arg3.source_amount, v5);
        v5
    }

    // decompiled from Move bytecode v6
}

