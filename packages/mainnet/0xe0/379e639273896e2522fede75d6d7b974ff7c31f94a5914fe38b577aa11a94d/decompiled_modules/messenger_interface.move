module 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger_interface {
    public fun add_secondary_validator(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: vector<u8>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg1), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::add_secondary_validator(arg1, arg2);
    }

    public fun gas_balance_value(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger) : u64 {
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::gas_balance_value(arg0)
    }

    public fun get_gas_usage(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg1: u8) : u64 {
        *0x2::table::borrow<u8, u64>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_gas_usage(arg0), arg1)
    }

    public fun get_other_chain_ids(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger) : &vector<bool> {
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_other_chain_ids(arg0)
    }

    public fun get_transaction_cost(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: u8) : u64 {
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_transaction_cost(arg0, arg1, arg2)
    }

    public fun migrate(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger) {
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::migrate(arg0, arg1);
    }

    public fun receive_message(arg0: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg2: vector<u8>, arg3: vector<u8>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg0), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::receive_message(arg0, arg1, arg2, arg3);
    }

    public fun remove_secondary_validator(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: vector<u8>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg1), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::remove_secondary_validator(arg1, arg2);
    }

    public fun send_message(arg0: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg1: &0xadfe831a90bc86f1b3cdf073ba4e2c20546e1dc88139e70fe2bbfe55164e3387::gas_oracle::GasOracle, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message, arg4: &0x2::object::UID) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg0), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::send_message(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set_gas_usage(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: u8, arg3: u64) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg1), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::set_gas_usage(arg1, arg2, arg3);
    }

    public fun set_other_chains(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: vector<bool>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg1), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::set_other_chains(arg1, arg2);
    }

    public fun set_primary_validator(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: vector<u8>) {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg1), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::set_primary_validator(arg1, arg2);
    }

    public fun withdraw_fee(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap, arg1: &mut 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::version::assert_version<0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::AdminCap>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_id(arg1), 0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_version());
        0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::withdraw_fee(arg1, arg2, arg3)
    }

    public fun has_received_message(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) : bool {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_received_messages(arg0), arg1)
    }

    public fun has_sent_messages(arg0: &0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::Messenger, arg1: 0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message) : bool {
        0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::set::contains<0x954b21497d350ad9d06a16dba1b5d7b95a15e56733d43da256ba5f2a5ea254b0::message::Message>(0xe0379e639273896e2522fede75d6d7b974ff7c31f94a5914fe38b577aa11a94d::messenger::get_sent_messages(arg0), arg1)
    }

    // decompiled from Move bytecode v6
}

