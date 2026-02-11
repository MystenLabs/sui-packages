module 0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
    }

    public(friend) fun new<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) : Config {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13835339749302337539);
        Config{
            id      : 0x2::object::new(arg1),
            version : 1,
        }
    }

    public fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 13835058514843664385);
    }

    public(friend) fun borrow_mut_id(arg0: &mut Config) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun derive_gas_pool_address_for_owner(arg0: &Config, arg1: address) : address {
        0x2::derived_object::derive_address<address>(0x2::object::uid_to_inner(&arg0.id), arg1)
    }

    public(friend) fun share(arg0: Config) {
        0x2::transfer::share_object<Config>(arg0);
    }

    public fun upgrade_version<T0>(arg0: &mut Config, arg1: &0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::authority::AuthorityCap<0xe4ee060246649366dde65cd5108b80fdb7f8e2165ee29e49bef9cdf6b0b3ebca::authority::PACKAGE, T0>) {
        assert!(arg0.version <= 1 - 1, 13835058467599024129);
        arg0.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

