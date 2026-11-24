module 0xe263620419acbd9db99af8c74fea5a59247b6a475f15748e05ced8799cc8c963::registry {
    struct OracleRegistry has key {
        id: 0x2::object::UID,
        feeds: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    public(friend) fun deregister(arg0: &mut OracleRegistry, arg1: vector<u8>) {
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.feeds, arg1), 1);
        0x2::table::remove<vector<u8>, 0x2::object::ID>(&mut arg0.feeds, arg1);
    }

    public fun feed_id(arg0: &OracleRegistry, arg1: vector<u8>) : 0x2::object::ID {
        *0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg0.feeds, arg1)
    }

    public fun has_feed(arg0: &OracleRegistry, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.feeds, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OracleRegistry{
            id    : 0x2::object::new(arg0),
            feeds : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<OracleRegistry>(v0);
    }

    public(friend) fun register(arg0: &mut OracleRegistry, arg1: vector<u8>, arg2: 0x2::object::ID) {
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.feeds, arg1), 0);
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.feeds, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

