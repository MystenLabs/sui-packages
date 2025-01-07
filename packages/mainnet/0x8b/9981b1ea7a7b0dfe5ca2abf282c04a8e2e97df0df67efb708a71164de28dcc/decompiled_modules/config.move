module 0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        aftermath_pk: vector<u8>,
    }

    public fun aftermath_pk(arg0: &Config) : vector<u8> {
        arg0.aftermath_pk
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun assert_public_key_corresponds_to_tx_sender(arg0: &vector<u8>, arg1: address) {
        assert!(arg1 == 0x2::address::from_bytes(0x2::hash::blake2b256(arg0)), 2);
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 1);
        let v0 = Config{
            id           : 0x2::object::new(arg1),
            version      : 1,
            aftermath_pk : x"00a6698d05dbff3c19903a3c83dc7815f2cdf77225be97df88f53abd1ccbb43f20",
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun derive_multisig_address(arg0: &Config, arg1: vector<u8>) : address {
        assert_interacting_with_most_up_to_date_package(arg0);
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::append<u8>(&mut v0, x"0100");
        0x1::vector::append<u8>(&mut v0, arg0.aftermath_pk);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        create_config(&arg0, arg1);
        0x2::transfer::public_transfer<0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::admin::AdminCap>(0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::admin::create_admin_cap<CONFIG>(&arg0, arg1), v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<CONFIG>(arg0, arg1), v0);
    }

    public fun update_aftermath_pk(arg0: &0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::admin::AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_interacting_with_most_up_to_date_package(arg1);
        0xce8245f6a3fb68f78dafe4d5f7ea7608b31292a6d43b4b7d4825861bd1295320::events::emit_updated_aftermath_pk_event(arg1.aftermath_pk, arg2);
        arg1.aftermath_pk = arg2;
    }

    // decompiled from Move bytecode v6
}

