module 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Messenger has key {
        id: 0x2::object::UID,
        primary_validator: vector<u8>,
        secondary_validators: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<vector<u8>>,
        received_messages: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>,
        sent_messages: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>,
        other_chain_ids: vector<bool>,
        gas_usage: 0x2::table::Table<u8, u64>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public(friend) fun add_secondary_validator(arg0: &mut Messenger, arg1: vector<u8>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<vector<u8>>(&mut arg0.secondary_validators, arg1);
    }

    public(friend) fun gas_balance_value(arg0: &Messenger) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance)
    }

    public(friend) fun get_gas_usage(arg0: &Messenger) : &0x2::table::Table<u8, u64> {
        &arg0.gas_usage
    }

    public(friend) fun get_id(arg0: &Messenger) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_other_chain_ids(arg0: &Messenger) : &vector<bool> {
        &arg0.other_chain_ids
    }

    public(friend) fun get_received_messages(arg0: &Messenger) : &0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message> {
        &arg0.received_messages
    }

    public(friend) fun get_sent_messages(arg0: &Messenger) : &0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message> {
        &arg0.sent_messages
    }

    public(friend) fun get_transaction_cost(arg0: &Messenger, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::get_transaction_gas_cost_in_native_token(arg1, arg2, *0x2::table::borrow<u8, u64>(get_gas_usage(arg0), arg2))
    }

    public(friend) fun get_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::init_version<AdminCap>(&v0, &mut v1, 1);
        let v2 = Messenger{
            id                   : v1,
            primary_validator    : b"",
            secondary_validators : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<vector<u8>>(arg0),
            received_messages    : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(arg0),
            sent_messages        : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(arg0),
            other_chain_ids      : vector[],
            gas_usage            : 0x2::table::new<u8, u64>(arg0),
            gas_balance          : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Messenger>(v2);
    }

    public(friend) fun migrate(arg0: &AdminCap, arg1: &mut Messenger) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::migrate_version<AdminCap>(arg0, &mut arg1.id, 1);
    }

    public(friend) fun receive_message(arg0: &mut Messenger, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.received_messages, arg1), 7);
        assert!(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_to(&arg1) == 13, 0);
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::data(&arg1);
        assert!(arg0.primary_validator == 0x2::ecdsa_k1::secp256k1_ecrecover(&arg2, &v0, 0), 3);
        let v1 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::data(&arg1);
        assert!(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<vector<u8>>(&arg0.secondary_validators, 0x2::ecdsa_k1::secp256k1_ecrecover(&arg3, &v1, 0)), 4);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.received_messages, arg1);
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::events::message_received_event(arg1);
    }

    public(friend) fun remove_secondary_validator(arg0: &mut Messenger, arg1: vector<u8>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::remove<vector<u8>>(&mut arg0.secondary_validators, arg1);
    }

    public(friend) fun send_message(arg0: &mut Messenger, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg4: &0x2::object::UID) {
        assert!(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_from(&arg3) == 13, 0);
        assert!(*0x1::vector::borrow<bool>(&arg0.other_chain_ids, (0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_to(&arg3) as u64)), 1);
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::add_sender(&arg3, 0x2::object::uid_as_inner(arg4));
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.sent_messages, v0), 2);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.sent_messages, v0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= get_transaction_cost(arg0, arg1, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_to(&arg3)), 5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.gas_balance, arg2);
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::events::message_sent_event(v0);
    }

    public(friend) fun set_gas_usage(arg0: &mut Messenger, arg1: u8, arg2: u64) {
        if (0x2::table::contains<u8, u64>(&arg0.gas_usage, arg1)) {
            *0x2::table::borrow_mut<u8, u64>(&mut arg0.gas_usage, arg1) = arg2;
        } else {
            0x2::table::add<u8, u64>(&mut arg0.gas_usage, arg1, arg2);
        };
    }

    public(friend) fun set_other_chains(arg0: &mut Messenger, arg1: vector<bool>) {
        assert!(0x1::vector::length<bool>(&arg1) == 32, 6);
        arg0.other_chain_ids = arg1;
    }

    public(friend) fun set_primary_validator(arg0: &mut Messenger, arg1: vector<u8>) {
        arg0.primary_validator = arg1;
    }

    public(friend) fun withdraw_fee(arg0: &mut Messenger, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

