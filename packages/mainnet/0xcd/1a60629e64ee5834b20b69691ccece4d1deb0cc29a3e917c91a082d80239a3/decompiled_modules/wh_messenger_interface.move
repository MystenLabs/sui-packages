module 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wh_messenger_interface {
    public fun gas_balance_value(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger) : u64 {
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::gas_balance_value(arg0)
    }

    public fun get_gas_usage(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg1: u8) : u64 {
        *0x2::table::borrow<u8, u64>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_gas_usage(arg0), arg1)
    }

    public fun get_other_chain_ids(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger) : &vector<bool> {
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_other_chain_ids(arg0)
    }

    public fun get_transaction_cost(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg1: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: u8) : u64 {
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_transaction_cost(arg0, arg1, arg2, arg3)
    }

    public fun has_received_message(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) : bool {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_received_messages(arg0), arg1)
    }

    public fun has_sent_messages(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) : bool {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_sent_messages(arg0), arg1)
    }

    public fun init_emitter(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: &0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg1), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::init_emitter(arg1, arg2, arg3);
    }

    public fun migrate(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger) {
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::migrate(arg0, arg1);
    }

    public fun receive_message(arg0: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg1: vector<u8>, arg2: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg3: &0x2::clock::Clock) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg0), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::receive_message(arg0, arg1, arg2, arg3);
    }

    public fun register_wormhole_messenger(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: u16, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::bytes32::Bytes32) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg1), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::register_wormhole_messenger(arg1, arg2, arg3);
    }

    public fun send_message(arg0: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg1: &mut 0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::state::State, arg2: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg4: &0x2::object::UID, arg5: &0x2::clock::Clock, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg0), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::send_message(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public fun set_gas_usage(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: u8, arg3: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg1), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::set_gas_usage(arg1, arg2, arg3);
    }

    public fun set_other_chains(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: vector<bool>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg1), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::set_other_chains(arg1, arg2);
    }

    public fun unregister_wormhole_messenger(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: u16) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg1), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::unregister_wormhole_messenger(arg1, arg2);
    }

    public fun withdraw_fee(arg0: &0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap, arg1: &mut 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::WormholeMessenger, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::AdminCap>(0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_id(arg1), 0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::get_version());
        0xcd1a60629e64ee5834b20b69691ccece4d1deb0cc29a3e917c91a082d80239a3::wormhole_messenger::withdraw_fee(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

