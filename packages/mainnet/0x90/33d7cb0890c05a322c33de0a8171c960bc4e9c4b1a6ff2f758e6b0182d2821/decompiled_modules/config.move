module 0x9033d7cb0890c05a322c33de0a8171c960bc4e9c4b1a6ff2f758e6b0182d2821::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has store, key {
        id: 0x2::object::UID,
        paused: bool,
        version: u64,
    }

    public fun get_version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    public fun grant_operator_cap(arg0: &GlobalConfig, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = OperatorCap{id: 0x2::object::new(arg0)};
        let v2 = GlobalConfig{
            id      : 0x2::object::new(arg0),
            paused  : false,
            version : 2,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<OperatorCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalConfig>(v2);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun set_paused(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public fun update_package_version(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        arg0.version = arg2;
    }

    // decompiled from Move bytecode v6
}

