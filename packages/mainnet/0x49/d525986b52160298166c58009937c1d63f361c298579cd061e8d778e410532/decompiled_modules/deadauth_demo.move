module 0x49d525986b52160298166c58009937c1d63f361c298579cd061e8d778e410532::deadauth_demo {
    struct Oracle has key {
        id: 0x2::object::UID,
        price: u64,
    }

    struct UpdateAuthority has key {
        id: 0x2::object::UID,
        authority: vector<address>,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Oracle{
            id    : 0x2::object::new(arg0),
            price : 1,
        };
        0x2::transfer::share_object<Oracle>(v0);
        let v1 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v1, 0x2::tx_context::sender(arg0));
        let v2 = UpdateAuthority{
            id        : 0x2::object::new(arg0),
            authority : v1,
        };
        0x2::transfer::share_object<UpdateAuthority>(v2);
    }

    public fun price(arg0: &Oracle) : u64 {
        arg0.price
    }

    public fun update_price_safe(arg0: &mut Oracle, arg1: &UpdateAuthority, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::vector::contains<address>(&arg1.authority, &v0), 1);
        arg0.price = arg2;
    }

    public fun update_price_vuln(arg0: &mut Oracle, arg1: &UpdateAuthority, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        0x1::vector::contains<address>(&arg1.authority, &v0);
        arg0.price = arg2;
    }

    // decompiled from Move bytecode v7
}

