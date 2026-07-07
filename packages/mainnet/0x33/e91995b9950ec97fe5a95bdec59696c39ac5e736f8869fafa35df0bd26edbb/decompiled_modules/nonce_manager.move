module 0x33e91995b9950ec97fe5a95bdec59696c39ac5e736f8869fafa35df0bd26edbb::nonce_manager {
    struct NonceRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        nonce: u64,
    }

    public fun commit(arg0: &mut NonceRegistry, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(arg1 > arg0.nonce, 1);
        arg0.nonce = arg1;
    }

    public fun current(arg0: &NonceRegistry) : u64 {
        arg0.nonce
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NonceRegistry{
            id    : 0x2::object::new(arg0),
            owner : 0x2::tx_context::sender(arg0),
            nonce : 0,
        };
        0x2::transfer::share_object<NonceRegistry>(v0);
    }

    public fun owner(arg0: &NonceRegistry) : address {
        arg0.owner
    }

    public fun reset(arg0: &mut NonceRegistry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.nonce = 0;
    }

    // decompiled from Move bytecode v6
}

