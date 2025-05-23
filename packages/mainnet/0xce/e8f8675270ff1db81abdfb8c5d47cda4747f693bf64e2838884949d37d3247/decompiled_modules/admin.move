module 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::admin {
    public(friend) fun assert_is_authorized(arg0: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::AccessControl, arg1: &0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::Admin) {
        assert!(0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::has_role(arg1, arg0, b"TREASURER_ROLE"), 9223372169998827522);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::new(arg0);
        let v2 = v1;
        let v3 = v0;
        0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::add(&v2, &mut v3, b"TREASURER_ROLE");
        0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::grant(&v2, &mut v3, b"TREASURER_ROLE", 0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::addy(&v2));
        0x2::transfer::public_share_object<0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::AccessControl>(v3);
        0x2::transfer::public_transfer<0xcee8f8675270ff1db81abdfb8c5d47cda4747f693bf64e2838884949d37d3247::access_control::Admin>(v2, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

