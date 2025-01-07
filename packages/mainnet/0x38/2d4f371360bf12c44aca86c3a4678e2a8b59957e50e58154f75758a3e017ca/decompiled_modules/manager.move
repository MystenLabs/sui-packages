module 0x382d4f371360bf12c44aca86c3a4678e2a8b59957e50e58154f75758a3e017ca::manager {
    struct MANAGER has drop {
        dummy_field: bool,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
        owner: address,
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

    public entry fun mint(arg0: &OwnerCap, arg1: &mut 0x934692a74595c4f5a0c026130eb2143eea6fc313742f5d7dd9e45fd6ddbb00f1::suime::Global, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x934692a74595c4f5a0c026130eb2143eea6fc313742f5d7dd9e45fd6ddbb00f1::suime::mint(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

