module 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Config {
    struct Config has store, key {
        id: 0x2::object::UID,
        protocol_payee: address,
        protocol_fee: u64,
    }

    struct CONFIG has drop {
        dummy_field: bool,
    }

    public fun get_id(arg0: &Config) : 0x2::object::ID {
        0x2::object::id<Config>(arg0)
    }

    public fun get_protocol_fee(arg0: &Config) : u64 {
        arg0.protocol_fee
    }

    public fun get_protocol_payee(arg0: &Config) : address {
        arg0.protocol_payee
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CONFIG>(arg0, arg1);
        let v0 = Config{
            id             : 0x2::object::new(arg1),
            protocol_payee : 0x2::tx_context::sender(arg1),
            protocol_fee   : 2000,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun manage_protocol_fee(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x2::package::Publisher, arg2: &mut Config, arg3: u64) {
        let v0 = 0x1::type_name::get<CONFIG>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(0x2::package::from_module<CONFIG>(arg1), 1);
        arg2.protocol_fee = arg3;
    }

    public entry fun manage_protocol_payee(arg0: &0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::Version, arg1: &0x2::package::Publisher, arg2: &mut Config, arg3: address) {
        let v0 = 0x1::type_name::get<CONFIG>();
        let v1 = 0x1::type_name::get_address(&v0);
        assert!(0x56714d6578dafaaec566c1483ac0fc5fb206b506455a8d59b043d67d243243eb::version::get(arg0, 0x2::address::from_bytes(0x2::hex::decode(*0x1::ascii::as_bytes(&v1)))) == 0xd96d9bc7a8c2d6e18c5dfa07ea66f8bc290c63f4d26d2ab4bc030d315510f454::Version::get_version(), 13);
        assert!(0x2::package::from_module<CONFIG>(arg1), 1);
        arg2.protocol_payee = arg3;
    }

    // decompiled from Move bytecode v6
}

