module 0x40529984528fb46b602d824b9240038c5e341476b3c3cd564223149019c188cf::house {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct House has store, key {
        id: 0x2::object::UID,
        fee_percentage: u64,
    }

    public entry fun change_percentage(arg0: &AdminCap, arg1: &mut House, arg2: u64) {
        arg1.fee_percentage = arg2;
    }

    public entry fun create_admin_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public(friend) fun get_fee_percentage(arg0: &House) : u64 {
        arg0.fee_percentage
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = House{
            id             : 0x2::object::new(arg0),
            fee_percentage : 20,
        };
        0x2::transfer::public_share_object<House>(v1);
    }

    // decompiled from Move bytecode v6
}

