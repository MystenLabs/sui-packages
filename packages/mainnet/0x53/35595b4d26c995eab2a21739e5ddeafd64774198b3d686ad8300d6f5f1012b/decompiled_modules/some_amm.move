module 0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::some_amm {
    struct DEVPASS has drop {
        dummy_field: bool,
    }

    entry fun swap<T0, T1>() {
    }

    public fun dev_swap<T0, T1>(arg0: 0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::SingleUse<DEVPASS>) : bool {
        let v0 = DEVPASS{dummy_field: false};
        0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::confirm_use<DEVPASS>(v0, arg0);
        true
    }

    public fun purchase_pass(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DEVPASS{dummy_field: false};
        let v1 = DEVPASS{dummy_field: false};
        0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::transfer<DEVPASS>(v0, 0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::issue_subscription<DEVPASS>(v1, 100, arg0), 0x2::tx_context::sender(arg0));
    }

    public fun topup_pass(arg0: &mut 0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::Subscription<DEVPASS>) {
        let v0 = DEVPASS{dummy_field: false};
        0x5335595b4d26c995eab2a21739e5ddeafd64774198b3d686ad8300d6f5f1012b::dev_pass::add_uses<DEVPASS>(v0, arg0, 10);
    }

    // decompiled from Move bytecode v6
}

