module 0x21947648b57e81a490f6536f1aca40f836fc08c49e4ef7cc31f24d09cbd1ad42::sentio_test {
    struct Result has store, key {
        id: 0x2::object::UID,
        res: u64,
    }

    struct AddResult has copy, drop {
        num1: u64,
        num2: u64,
        res: u64,
    }

    struct SubResult has copy, drop {
        num1: u64,
        num2: u64,
        res: u64,
    }

    struct MultipleResult has copy, drop {
        num1: u64,
        num2: u64,
        res: u64,
    }

    struct DivisionResult has copy, drop {
        num1: u64,
        num2: u64,
        res: u64,
    }

    public fun add_and_send_res(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Result{
            id  : 0x2::object::new(arg2),
            res : arg0 + arg1,
        };
        let v1 = AddResult{
            num1 : arg0,
            num2 : arg1,
            res  : v0.res,
        };
        0x2::event::emit<AddResult>(v1);
        0x2::transfer::public_transfer<Result>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun div_and_send_res(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Result{
            id  : 0x2::object::new(arg2),
            res : arg0 / arg1,
        };
        let v1 = DivisionResult{
            num1 : arg0,
            num2 : arg1,
            res  : v0.res,
        };
        0x2::event::emit<DivisionResult>(v1);
        0x2::transfer::public_transfer<Result>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun mul_and_send_res(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Result{
            id  : 0x2::object::new(arg2),
            res : arg0 * arg1,
        };
        let v1 = MultipleResult{
            num1 : arg0,
            num2 : arg1,
            res  : v0.res,
        };
        0x2::event::emit<MultipleResult>(v1);
        0x2::transfer::public_transfer<Result>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun sub_and_send_res(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Result{
            id  : 0x2::object::new(arg2),
            res : arg0 - arg1,
        };
        let v1 = SubResult{
            num1 : arg0,
            num2 : arg1,
            res  : v0.res,
        };
        0x2::event::emit<SubResult>(v1);
        0x2::transfer::public_transfer<Result>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

