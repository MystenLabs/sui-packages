module 0x71d0935bc2d91e918726a5434849418f97bef9ee5f62f2aa7e9a6e2d870df628::locker_cap {
    struct LOCKER_CAP has drop {
        dummy_field: bool,
    }

    struct CreateCap has store, key {
        id: 0x2::object::UID,
    }

    struct LockerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_locker_cap(arg0: &CreateCap, arg1: &mut 0x2::tx_context::TxContext) : LockerCap {
        LockerCap{id: 0x2::object::new(arg1)}
    }

    public fun grant_create_cap(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<CreateCap>(arg0), 923752748582334234);
        let v0 = CreateCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<CreateCap>(v0, arg1);
    }

    fun init(arg0: LOCKER_CAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<LOCKER_CAP>(arg0, arg1);
        let v0 = CreateCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<CreateCap>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

