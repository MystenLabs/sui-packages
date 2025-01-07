module 0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        insidex_pk: vector<u8>,
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
            id         : 0x2::object::new(arg1),
            version    : 1,
            insidex_pk : x"0054ddafa58454c82c36bf39bb3a14568f09cc04a4fb069cc7f73b47c92bd8ff74",
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
        0x1::vector::append<u8>(&mut v0, arg0.insidex_pk);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun insidex_pk(arg0: &Config) : vector<u8> {
        arg0.insidex_pk
    }

    public fun update_insidex_pk(arg0: &0xb7713cbf4963a2045b82ec93c6e346a86a6397277a8e0f24fe8de9902649eb4b::app::AdminCap, arg1: &mut Config, arg2: vector<u8>) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.insidex_pk = arg2;
    }

    // decompiled from Move bytecode v6
}

