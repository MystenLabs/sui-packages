module 0x6093e91a80abf3610d1de52a764c10873035a329e18e1440f0c345c8eb12b0ce::flash_rebate {
    struct TempData has store, key {
        id: 0x2::object::UID,
        bytes: vector<u8>,
    }

    public fun flash(arg0: &mut 0x2::tx_context::TxContext, arg1: u64) {
        let v0 = 0x1::vector::empty<u8>();
        if (arg1 > 0) {
            0x1::vector::push_back<u8>(&mut v0, 0);
        };
        let v1 = TempData{
            id    : 0x2::object::new(arg0),
            bytes : v0,
        };
        let TempData {
            id    : v2,
            bytes : _,
        } = v1;
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v6
}

