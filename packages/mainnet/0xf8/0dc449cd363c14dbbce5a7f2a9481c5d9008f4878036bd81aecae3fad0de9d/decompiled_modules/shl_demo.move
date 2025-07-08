module 0xf80dc449cd363c14dbbce5a7f2a9481c5d9008f4878036bd81aecae3fad0de9d::shl_demo {
    struct DemoStruct has store, key {
        id: 0x2::object::UID,
        value: u64,
        shift_amount: u8,
    }

    struct ShiftLeftEvent has copy, drop {
        value: u64,
        shift_amount: u8,
        result: u64,
    }

    struct GenericShiftLeftEvent<T0: copy + drop> has copy, drop {
        value: u64,
        shift_amount: u8,
        result: u64,
        generic_value: T0,
    }

    public entry fun create_owned_demo_struct(arg0: u64, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = new_demo_struct(arg0, arg1, arg2);
        0x2::transfer::transfer<DemoStruct>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun create_shared_demo_struct(arg0: u64, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DemoStruct>(new_demo_struct(arg0, arg1, arg2));
    }

    public entry fun generic_shl<T0: copy + drop>(arg0: u64, arg1: u8, arg2: T0) {
        let v0 = GenericShiftLeftEvent<T0>{
            value         : arg0,
            shift_amount  : arg1,
            result        : arg0 << arg1,
            generic_value : arg2,
        };
        0x2::event::emit<GenericShiftLeftEvent<T0>>(v0);
    }

    public fun get_shift_amount(arg0: &DemoStruct) : u8 {
        arg0.shift_amount
    }

    public fun get_value(arg0: &DemoStruct) : u64 {
        arg0.value
    }

    public entry fun immutable_shared_struct_shl(arg0: &DemoStruct) {
        let v0 = ShiftLeftEvent{
            value        : arg0.value,
            shift_amount : arg0.shift_amount,
            result       : arg0.value << arg0.shift_amount,
        };
        0x2::event::emit<ShiftLeftEvent>(v0);
    }

    public entry fun integer_shl(arg0: u64, arg1: u8) {
        let v0 = ShiftLeftEvent{
            value        : arg0,
            shift_amount : arg1,
            result       : arg0 << arg1,
        };
        0x2::event::emit<ShiftLeftEvent>(v0);
    }

    public entry fun mutable_shared_struct_shl(arg0: &mut DemoStruct) {
        let v0 = ShiftLeftEvent{
            value        : arg0.value,
            shift_amount : arg0.shift_amount,
            result       : arg0.value << arg0.shift_amount,
        };
        0x2::event::emit<ShiftLeftEvent>(v0);
        arg0.value = arg0.value + 1;
    }

    public fun new_demo_struct(arg0: u64, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : DemoStruct {
        DemoStruct{
            id           : 0x2::object::new(arg2),
            value        : arg0,
            shift_amount : arg1,
        }
    }

    public entry fun owned_struct_shl(arg0: DemoStruct, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = ShiftLeftEvent{
            value        : arg0.value,
            shift_amount : arg0.shift_amount,
            result       : arg0.value << arg0.shift_amount,
        };
        0x2::event::emit<ShiftLeftEvent>(v0);
        let DemoStruct {
            id           : v1,
            value        : _,
            shift_amount : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun set_shift_amount(arg0: &mut DemoStruct, arg1: u8) {
        arg0.shift_amount = arg1;
    }

    public fun set_value(arg0: &mut DemoStruct, arg1: u64) {
        arg0.value = arg1;
    }

    public entry fun vector_shl(arg0: vector<u32>) {
        assert!(0x1::vector::length<u32>(&arg0) >= 2, 2);
        let v0 = *0x1::vector::borrow<u32>(&arg0, 0);
        let v1 = (*0x1::vector::borrow<u32>(&arg0, 1) as u8);
        let v2 = ShiftLeftEvent{
            value        : (v0 as u64),
            shift_amount : v1,
            result       : (v0 as u64) << v1,
        };
        0x2::event::emit<ShiftLeftEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

