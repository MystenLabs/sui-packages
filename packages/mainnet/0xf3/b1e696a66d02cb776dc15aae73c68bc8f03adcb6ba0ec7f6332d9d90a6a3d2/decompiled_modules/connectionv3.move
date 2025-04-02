module 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::connectionv3 {
    struct ReceiptKey has copy, drop, store {
        conn_sn: u256,
        chain_id: u256,
    }

    struct State has store, key {
        id: 0x2::object::UID,
        receipts: 0x2::table::Table<ReceiptKey, bool>,
        conn_sn: u256,
        chain_id: u256,
        validators: vector<vector<u8>>,
        validators_threshold: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Message has copy, drop {
        src_chain_id: u256,
        src_address: vector<u8>,
        conn_sn: u256,
        dst_chain_id: u256,
        dst_address: vector<u8>,
        payload: vector<u8>,
    }

    struct CONNECTIONV3 has drop {
        dummy_field: bool,
    }

    struct OTWTicket has store, key {
        id: 0x2::object::UID,
    }

    entry fun configure(arg0: OTWTicket, arg1: u256, arg2: vector<vector<u8>>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = set_validator_inner(arg2, arg3);
        let v2 = State{
            id                   : 0x2::object::new(arg4),
            receipts             : 0x2::table::new<ReceiptKey, bool>(arg4),
            conn_sn              : 0,
            chain_id             : arg1,
            validators           : v0,
            validators_threshold : v1,
        };
        let OTWTicket { id: v3 } = arg0;
        0x2::object::delete(v3);
        0x2::transfer::public_share_object<State>(v2);
    }

    fun create_ticket(arg0: CONNECTIONV3, arg1: &mut 0x2::tx_context::TxContext) : OTWTicket {
        0x2::package::claim_and_keep<CONNECTIONV3>(arg0, arg1);
        OTWTicket{id: 0x2::object::new(arg1)}
    }

    public fun extract_pubkey(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::pop_back<u8>(&mut arg1);
        let v1 = v0;
        let v2 = 27;
        if (v0 >= v2) {
            v1 = v0 - v2;
        };
        0x1::vector::push_back<u8>(&mut arg1, v1);
        let v3 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        0x2::ecdsa_k1::decompress_pubkey(&v3)
    }

    entry fun get_receipt(arg0: &State, arg1: u128, arg2: u128) : bool {
        let v0 = ReceiptKey{
            conn_sn  : (arg2 as u256),
            chain_id : (arg1 as u256),
        };
        0x2::table::contains<ReceiptKey, bool>(&arg0.receipts, v0)
    }

    public fun get_validator_threshold(arg0: &State) : u64 {
        arg0.validators_threshold
    }

    public(friend) fun get_validators(arg0: &State) : vector<vector<u8>> {
        arg0.validators
    }

    fun init(arg0: CONNECTIONV3, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = create_ticket(arg0, arg1);
        0x2::transfer::public_transfer<OTWTicket>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun send_message(arg0: &mut State, arg1: 0x2::object::ID, arg2: &0x2::package::Publisher, arg3: u256, arg4: vector<u8>, arg5: vector<u8>) {
        let v0 = 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::utils::get_package_address(arg2, arg1);
        send_message_inner(arg0, *0x1::string::as_bytes(&v0), arg3, arg4, arg5);
    }

    fun send_message_inner(arg0: &mut State, arg1: vector<u8>, arg2: u256, arg3: vector<u8>, arg4: vector<u8>) {
        arg0.conn_sn = arg0.conn_sn + 1;
        let v0 = Message{
            src_chain_id : arg0.chain_id,
            src_address  : arg1,
            conn_sn      : arg0.conn_sn,
            dst_chain_id : arg2,
            dst_address  : arg3,
            payload      : arg4,
        };
        0x2::event::emit<Message>(v0);
    }

    entry fun send_message_ua(arg0: &mut State, arg1: u256, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        send_message_inner(arg0, 0x2::bcs::to_bytes<address>(&v0), arg1, arg2, arg3);
    }

    fun set_validator_inner(arg0: vector<vector<u8>>, arg1: u64) : (vector<vector<u8>>, u64) {
        assert!(arg1 > 0, 102);
        let v0 = 0x1::vector::empty<vector<u8>>();
        while (0x1::vector::length<vector<u8>>(&arg0) > 0) {
            let v1 = 0x1::vector::pop_back<vector<u8>>(&mut arg0);
            if (0x1::vector::contains<vector<u8>>(&v0, &v1)) {
                continue
            };
            0x1::vector::push_back<vector<u8>>(&mut v0, v1);
        };
        assert!(0x1::vector::length<vector<u8>>(&v0) >= arg1, 105);
        (v0, arg1)
    }

    entry fun set_validator_threshold(arg0: &mut State, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 <= 0x1::vector::length<vector<u8>>(&arg0.validators), 102);
        arg0.validators_threshold = arg2;
    }

    entry fun set_validators(arg0: &mut State, arg1: &AdminCap, arg2: vector<vector<u8>>, arg3: u64) {
        let (v0, v1) = set_validator_inner(arg2, arg3);
        arg0.validators = v0;
        arg0.validators_threshold = v1;
    }

    public fun verify_message(arg0: &mut State, arg1: 0x2::object::ID, arg2: &0x2::package::Publisher, arg3: u256, arg4: vector<u8>, arg5: u256, arg6: vector<u8>, arg7: vector<vector<u8>>) {
        let v0 = ReceiptKey{
            conn_sn  : arg5,
            chain_id : arg3,
        };
        0x2::table::add<ReceiptKey, bool>(&mut arg0.receipts, v0, true);
        let v1 = 0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::utils::get_package_address(arg2, arg1);
        verify_signatures(arg0, arg3, arg4, arg5, arg6, arg0.chain_id, *0x1::string::as_bytes(&v1), arg7);
    }

    public fun verify_signatures(arg0: &State, arg1: u256, arg2: vector<u8>, arg3: u256, arg4: vector<u8>, arg5: u256, arg6: vector<u8>, arg7: vector<vector<u8>>) {
        let v0 = get_validator_threshold(arg0);
        let v1 = get_validators(arg0);
        assert!(0x1::vector::length<vector<u8>>(&arg7) >= v0, 101);
        let v2 = 0;
        let v3 = 0x1::vector::empty<vector<u8>>();
        while (v2 < 0x1::vector::length<vector<u8>>(&arg7)) {
            let v4 = extract_pubkey(0xf3b1e696a66d02cb776dc15aae73c68bc8f03adcb6ba0ec7f6332d9d90a6a3d2::utils::get_message_event_bytes(arg1, arg2, arg3, arg4, arg5, arg6), *0x1::vector::borrow<vector<u8>>(&arg7, v2));
            if (0x1::vector::contains<vector<u8>>(&v1, &v4)) {
                if (!0x1::vector::contains<vector<u8>>(&v3, &v4)) {
                    0x1::vector::push_back<vector<u8>>(&mut v3, v4);
                };
                if (0x1::vector::length<vector<u8>>(&v3) >= v0) {
                    return
                };
            };
            v2 = v2 + 1;
        };
        assert!(0x1::vector::length<vector<u8>>(&v3) >= v0, 104);
    }

    // decompiled from Move bytecode v6
}

