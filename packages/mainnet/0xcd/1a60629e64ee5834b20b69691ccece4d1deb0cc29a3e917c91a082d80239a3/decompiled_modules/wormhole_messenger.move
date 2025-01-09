module 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger {
    struct WormholeMessenger has key {
        id: 0x2::object::UID,
        emitter_cap: 0x1::option::Option<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>,
        received_messages: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>,
        sent_messages: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>,
        other_wormhole_messengers: 0x2::table::Table<u16, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>,
        other_chain_ids: vector<bool>,
        gas_usage: 0x2::table::Table<u8, u64>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public(friend) fun gas_balance_value(arg0: &WormholeMessenger) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance)
    }

    public(friend) fun get_gas_usage(arg0: &WormholeMessenger) : &0x2::table::Table<u8, u64> {
        &arg0.gas_usage
    }

    public(friend) fun get_id(arg0: &WormholeMessenger) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun get_other_chain_ids(arg0: &WormholeMessenger) : &vector<bool> {
        &arg0.other_chain_ids
    }

    public(friend) fun get_other_wormhole_messengers(arg0: &WormholeMessenger) : &0x2::table::Table<u16, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32> {
        &arg0.other_wormhole_messengers
    }

    public(friend) fun get_received_messages(arg0: &WormholeMessenger) : &0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message> {
        &arg0.received_messages
    }

    public(friend) fun get_sent_messages(arg0: &WormholeMessenger) : &0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::Set<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message> {
        &arg0.sent_messages
    }

    public(friend) fun get_transaction_cost(arg0: &WormholeMessenger, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: u8) : u64 {
        0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle_interface::get_transaction_gas_cost_in_native_token(arg2, arg3, *0x2::table::borrow<u8, u64>(&arg0.gas_usage, arg3)) + 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg1)
    }

    public(friend) fun get_version() : u64 {
        1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::new(arg0);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::init_version<AdminCap>(&v0, &mut v1, 1);
        let v2 = WormholeMessenger{
            id                        : v1,
            emitter_cap               : 0x1::option::none<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(),
            received_messages         : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(arg0),
            sent_messages             : 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::new<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(arg0),
            other_wormhole_messengers : 0x2::table::new<u16, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(arg0),
            other_chain_ids           : vector[],
            gas_usage                 : 0x2::table::new<u8, u64>(arg0),
            gas_balance               : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<WormholeMessenger>(v2);
    }

    public(friend) fun init_emitter(arg0: &mut WormholeMessenger, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::option::fill<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&mut arg0.emitter_cap, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::new(arg1, arg2));
    }

    public(friend) fun migrate(arg0: &AdminCap, arg1: &mut WormholeMessenger) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::migrate_version<AdminCap>(arg0, &mut arg1.id, 1);
    }

    public(friend) fun receive_message(arg0: &mut WormholeMessenger, arg1: vector<u8>, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0x2::clock::Clock) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<AdminCap>(&arg0.id, 1);
        let v0 = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::parse_and_verify(arg2, arg1, arg3);
        let (v1, v2, v3) = 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::take_emitter_info_and_payload(v0);
        receive_message_inner(arg0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::vaa::sequence(&v0), v1, v2, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::from_bytes(v3));
    }

    public(friend) fun receive_message_inner(arg0: &mut WormholeMessenger, arg1: u64, arg2: u16, arg3: 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::ExternalAddress, arg4: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) {
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.received_messages, arg4), 7);
        assert!(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_to(&arg4) == 13, 0);
        assert!(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::data(0x2::table::borrow<u16, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(&arg0.other_wormhole_messengers, arg2)) == 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::external_address::to_bytes(arg3), 3);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.received_messages, arg4);
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::events::message_received_event(arg4, arg1);
    }

    public(friend) fun register_wormhole_messenger(arg0: &mut WormholeMessenger, arg1: u16, arg2: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x2::table::add<u16, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(&mut arg0.other_wormhole_messengers, arg1, arg2);
    }

    public(friend) fun send_message(arg0: &mut WormholeMessenger, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg4: &0x2::object::UID, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<AdminCap>(&arg0.id, 1);
        assert!(0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_from(&arg3) == 13, 0);
        assert!(*0x1::vector::borrow<bool>(&arg0.other_chain_ids, (0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_to(&arg3) as u64)), 1);
        assert!(0x1::option::is_some<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&arg0.emitter_cap), 6);
        let v0 = 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::add_sender(&arg3, 0x2::object::uid_as_inner(arg4));
        assert!(!0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&arg0.sent_messages, v0), 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= get_transaction_cost(arg0, arg1, arg2, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::chain_to(&arg3)), 5);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.gas_balance, arg6);
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::add<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(&mut arg0.sent_messages, v0);
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::events::message_sent_event(v0, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::publish_message(arg1, 0x2::coin::split<0x2::sui::SUI>(&mut arg6, 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::message_fee(arg1), arg7), 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::publish_message::prepare_message(0x1::option::borrow_mut<0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::emitter::EmitterCap>(&mut arg0.emitter_cap), 0, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::data(&v0)), arg5));
    }

    public(friend) fun set_gas_usage(arg0: &mut WormholeMessenger, arg1: u8, arg2: u64) {
        if (0x2::table::contains<u8, u64>(&arg0.gas_usage, arg1)) {
            *0x2::table::borrow_mut<u8, u64>(&mut arg0.gas_usage, arg1) = arg2;
        } else {
            0x2::table::add<u8, u64>(&mut arg0.gas_usage, arg1, arg2);
        };
    }

    public(friend) fun set_other_chains(arg0: &mut WormholeMessenger, arg1: vector<bool>) {
        assert!(0x1::vector::length<bool>(&arg1) == 32, 4);
        arg0.other_chain_ids = arg1;
    }

    public(friend) fun unregister_wormhole_messenger(arg0: &mut WormholeMessenger, arg1: u16) {
        0x2::table::remove<u16, 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32>(&mut arg0.other_wormhole_messengers, arg1);
    }

    public(friend) fun withdraw_fee(arg0: &mut WormholeMessenger, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, arg1), arg2)
    }

    // decompiled from Move bytecode v6
}

