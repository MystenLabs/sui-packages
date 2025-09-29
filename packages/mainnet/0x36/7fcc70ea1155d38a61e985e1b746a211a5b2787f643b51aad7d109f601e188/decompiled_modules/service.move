module 0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::service {
    struct Sale has copy, drop, store {
        endpoint: 0x1::option::Option<0x1::string::String>,
        price: u64,
        stock: u64,
    }

    public fun ARBITRATION_COUNT(arg0: u64) {
        assert!(arg0 < 8, 2223);
    }

    public fun ARBITRATION_NOT_MATCH(arg0: bool) {
        assert!(arg0, 2225);
    }

    public fun ARB_PENDING(arg0: bool) {
        assert!(arg0, 2226);
    }

    public fun COUNTS(arg0: bool) {
        assert!(arg0, 2217);
    }

    public fun DNT_COUNT(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 200, 2215);
    }

    public fun DNT_TIME(arg0: bool) {
        assert!(arg0, 2214);
    }

    public fun FEE_TRE_NOT_MATCH(arg0: bool) {
        assert!(arg0, 2221);
    }

    public fun GUARD(arg0: bool) {
        assert!(arg0, 2219);
    }

    public fun GUARD_COUNT(arg0: u64) {
        assert!(arg0 < 16, 2200);
    }

    public fun ITEM_COUNT(arg0: u64) {
        assert!(arg0 > 0 && arg0 <= 100, 2227);
    }

    public fun ITEM_EXIST(arg0: bool) {
        assert!(arg0, 2216);
    }

    public fun MACHINE(arg0: bool) {
        assert!(arg0, 2205);
    }

    public fun MACHINE_PUBLISHED(arg0: bool) {
        assert!(arg0, 2218);
    }

    public fun NEED_PUBKEY(arg0: bool) {
        assert!(arg0, 2209);
    }

    public fun NEED_WITHDRAW_GUARD(arg0: bool) {
        assert!(arg0, 2222);
    }

    public fun NOT_FOUND(arg0: bool) {
        assert!(arg0, 2201);
    }

    public fun ORDER(arg0: bool) {
        assert!(arg0, 2208);
    }

    public fun ORD_ARB_NOT_MATCH(arg0: bool) {
        assert!(arg0, 2224);
    }

    public fun PAUSED(arg0: bool) {
        assert!(!arg0, 2212);
    }

    public fun PRICE(arg0: bool) {
        assert!(arg0, 2202);
    }

    public fun PUBKEY_NOT_MATCH(arg0: bool) {
        assert!(arg0, 2213);
    }

    public fun PUBLISHED(arg0: bool) {
        assert!(!arg0, 2203);
    }

    public fun REFUND_DEVISION_ARB() : vector<u8> {
        b"order refund division by Arb"
    }

    public fun REFUND_DEVISION_GUARD() : vector<u8> {
        b"order refund division by Guard"
    }

    public fun REP_COUNT(arg0: u64) {
        assert!(arg0 < 32, 2207);
    }

    public fun REQ(arg0: &0x1::string::String, arg1: &vector<0x1::string::String>) {
        let v0 = 0x1::vector::length<0x1::string::String>(arg1);
        let v1 = 0;
        assert!(v0 <= 16, 2210);
        assert!(0x1::string::length(arg0) <= 3000, 2211);
        if (v0 > 0) {
            assert!(!0x1::string::is_empty(arg0), 2209);
        };
        while (v1 < v0) {
            0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_NAMELEN(0x1::vector::borrow<0x1::string::String>(arg1, v1));
            v1 = v1 + 1;
        };
    }

    public fun STOCK(arg0: bool) {
        assert!(arg0, 2204);
    }

    public fun Sale_endpoint(arg0: &Sale) : &0x1::option::Option<0x1::string::String> {
        &arg0.endpoint
    }

    public fun Sale_endpoint_set(arg0: &mut Sale, arg1: &0x1::option::Option<0x1::string::String>) {
        arg0.endpoint = *arg1;
    }

    public fun Sale_new(arg0: &0x1::option::Option<0x1::string::String>, arg1: u64, arg2: u64) : Sale {
        Sale{
            endpoint : *arg0,
            price    : arg1,
            stock    : arg2,
        }
    }

    public fun Sale_price(arg0: &Sale) : u64 {
        arg0.price
    }

    public fun Sale_price_set(arg0: &mut Sale, arg1: u64) {
        arg0.price = arg1;
    }

    public fun Sale_resolve(arg0: &mut Sale, arg1: u64, arg2: u64, arg3: bool) : (u64, 0x1::option::Option<0x1::string::String>) {
        PRICE(arg0.price <= arg1);
        STOCK(arg0.stock >= arg2);
        if (arg3) {
            arg0.stock = arg0.stock - arg2;
        };
        (arg0.price, arg0.endpoint)
    }

    public fun Sale_stock(arg0: &Sale) : u64 {
        arg0.stock
    }

    public fun Sale_stock_add(arg0: &mut Sale, arg1: u64) {
        0x367fcc70ea1155d38a61e985e1b746a211a5b2787f643b51aad7d109f601e188::common::ASSERT_U64_ADD_UPFLOW(arg0.stock, arg1);
        arg0.stock = arg0.stock + arg1;
    }

    public fun Sale_stock_reduce(arg0: &mut Sale, arg1: u64) {
        if (arg1 >= arg0.stock) {
            arg0.stock = 0;
        } else {
            arg0.stock = arg0.stock - arg1;
        };
    }

    public fun Sale_stock_set(arg0: &mut Sale, arg1: u64) {
        arg0.stock = arg1;
    }

    public fun TRE_COUNT(arg0: u64) {
        assert!(arg0 < 8, 2220);
    }

    public fun UNPUBLISHED(arg0: bool) {
        assert!(arg0, 2206);
    }

    // decompiled from Move bytecode v6
}

