module 0x5b859a8617174531b676b8fbc97415fbe2a1921791f1b8ebc2d21eb1457c3ffa::shift_left {
    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    struct ShiftLeftEvent has copy, drop {
        original_value: u64,
        shift_amount: u8,
        result: u64,
    }

    public entry fun shift_left(arg0: &OwnerCap, arg1: u64, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ShiftLeftEvent{
            original_value : arg1,
            shift_amount   : arg2,
            result         : arg1 << arg2,
        };
        0x2::event::emit<ShiftLeftEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

