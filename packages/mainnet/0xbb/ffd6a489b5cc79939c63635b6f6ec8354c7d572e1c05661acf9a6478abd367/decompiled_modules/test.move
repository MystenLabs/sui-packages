module 0xbbffd6a489b5cc79939c63635b6f6ec8354c7d572e1c05661acf9a6478abd367::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    struct Test has key {
        id: 0x2::object::UID,
        x: u64,
        y: u64,
        z: u64,
        a: u64,
        b: u64,
    }

    struct UpdateEvent has copy, drop {
        x: u64,
        y: u64,
        z: u64,
        a: u64,
        b: u64,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Test{
            id : 0x2::object::new(arg1),
            x  : 0,
            y  : 0,
            z  : 0,
            a  : 0,
            b  : 0,
        };
        0x2::transfer::share_object<Test>(v0);
    }

    public fun update(arg0: &mut Test, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg0.x = arg1;
        arg0.y = arg2;
        arg0.z = arg3;
        arg0.a = arg4;
        arg0.b = arg5;
        let v0 = UpdateEvent{
            x : arg1,
            y : arg2,
            z : arg3,
            a : arg4,
            b : arg5,
        };
        0x2::event::emit<UpdateEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

