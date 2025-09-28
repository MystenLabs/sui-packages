module 0xfc9ecd36e3f759064ca0f059106f712da252cae1d1cb7e0eab660f7761c243e4::treasury {
    struct Config has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct EventCheckResult has copy, drop {
        result: bool,
        sender: address,
    }

    public fun check(arg0: &Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 10);
        let v0 = EventCheckResult{
            result : true,
            sender : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<EventCheckResult>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::public_share_object<Config>(v0);
    }

    public fun transfer_ownership(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 10);
        assert!(arg1 != arg0.owner, 11);
        arg0.owner = arg1;
    }

    // decompiled from Move bytecode v6
}

