module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::proposals {
    struct Proposals has store {
        active: 0x2::object_bag::ObjectBag,
        executed: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun active(arg0: &Proposals) : &0x2::object_bag::ObjectBag {
        &arg0.active
    }

    public(friend) fun active_mut(arg0: &mut Proposals) : &mut 0x2::object_bag::ObjectBag {
        &mut arg0.active
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : Proposals {
        Proposals{
            active   : 0x2::object_bag::new(arg0),
            executed : 0x2::object_bag::new(arg0),
        }
    }

    public(friend) fun executed(arg0: &Proposals) : &0x2::object_bag::ObjectBag {
        &arg0.executed
    }

    public(friend) fun executed_mut(arg0: &mut Proposals) : &mut 0x2::object_bag::ObjectBag {
        &mut arg0.executed
    }

    // decompiled from Move bytecode v7
}

