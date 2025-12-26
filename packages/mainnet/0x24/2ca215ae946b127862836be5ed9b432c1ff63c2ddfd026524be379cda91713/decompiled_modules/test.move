module 0x242ca215ae946b127862836be5ed9b432c1ff63c2ddfd026524be379cda91713::test {
    struct Test has copy, drop {
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

