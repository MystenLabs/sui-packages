module 0xfa81ff7079a04b1e3395064a4be4c4e8006f15a33af866d02986ed4861296477::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        owner: address,
    }

    public entry fun mint(arg0: &OwnerCap, arg1: &mut 0x934692a74595c4f5a0c026130eb2143eea6fc313742f5d7dd9e45fd6ddbb00f1::suime::Global, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x934692a74595c4f5a0c026130eb2143eea6fc313742f5d7dd9e45fd6ddbb00f1::suime::mint(arg1, arg2, arg3, arg4);
    }

    fun init(arg0: MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::package::claim_and_keep<MANAGER>(arg0, arg1);
        let v1 = OwnerCap{
            id    : 0x2::object::new(arg1),
            owner : v0,
        };
        0x2::transfer::transfer<OwnerCap>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

