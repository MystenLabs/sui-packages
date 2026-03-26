module 0x2e6a1a0a6f1202beb97fe15c527ba0146336d3d5e62bf014cd64a71b4c21df57::config {
    struct Config has store, key {
        id: 0x2::object::UID,
        admin: address,
        version: u64,
    }

    public fun assert_version(arg0: &Config) {
        assert!(arg0.version == 1, 100);
    }

    public fun init_version(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x58e50d7f8f4cb0411d3ceb34f0251cf409dd213820c160beded983e9a0b60fd3, 101);
        let v0 = Config{
            id      : 0x2::object::new(arg0),
            admin   : 0x2::tx_context::sender(arg0),
            version : 1,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun migrate(arg0: &mut Config, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg1), 101);
        arg0.version = 1;
    }

    // decompiled from Move bytecode v6
}

