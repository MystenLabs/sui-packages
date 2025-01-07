module 0xc133bfc300c20a8b123c3b27b0da96aa1649b0800b639dce3b067c7e68c5c3d7::admin {
    struct Contract has store, key {
        id: 0x2::object::UID,
        owner: address,
        receiver: address,
        signer: vector<u8>,
        freeze: bool,
    }

    public fun assert_admin(arg0: &Contract, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
    }

    public fun assert_not_freeze(arg0: &Contract) {
        assert!(!arg0.freeze, 1);
    }

    public fun get_receiver(arg0: &Contract) : address {
        arg0.receiver
    }

    public fun get_signer_public_key(arg0: &Contract) : vector<u8> {
        arg0.signer
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Contract{
            id       : 0x2::object::new(arg0),
            owner    : 0x2::tx_context::sender(arg0),
            receiver : 0x2::tx_context::sender(arg0),
            signer   : 0x1::vector::empty<u8>(),
            freeze   : false,
        };
        0x2::transfer::share_object<Contract>(v0);
    }

    public entry fun set_contract_owner(arg0: &mut Contract, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.owner = arg1;
    }

    public entry fun set_contract_receiver(arg0: &mut Contract, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.receiver = arg1;
    }

    public entry fun set_contract_signer_public_key(arg0: &mut Contract, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.signer = arg1;
    }

    public entry fun toggle_contract_freeze(arg0: &mut Contract, arg1: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg0, arg1);
        arg0.freeze = !arg0.freeze;
    }

    // decompiled from Move bytecode v6
}

