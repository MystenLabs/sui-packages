module 0x49d525986b52160298166c58009937c1d63f361c298579cd061e8d778e410532::cap_demo_vuln {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Treasury has key {
        id: 0x2::object::UID,
        value: u64,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id    : 0x2::object::new(arg0),
            value : 0,
        };
        0x2::transfer::share_object<Treasury>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun mint_admin(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg0)}
    }

    public fun set_value(arg0: &AdminCap, arg1: &mut Treasury, arg2: u64) {
        arg1.value = arg2;
    }

    public fun value(arg0: &Treasury) : u64 {
        arg0.value
    }

    // decompiled from Move bytecode v7
}

