module 0xd7ec2ec47cd628f4c1de314cd5ab526925d8e9621e559740160385c2561b499::pact {
    struct Pact has key {
        id: 0x2::object::UID,
        agreement_id: vector<u8>,
        creator: address,
        executed: bool,
    }

    struct AccessToken has key {
        id: 0x2::object::UID,
        pact: 0x2::object::ID,
        agreement_id: vector<u8>,
        role: u8,
    }

    public entry fun create_pact_entry(arg0: vector<u8>, arg1: vector<address>, arg2: vector<address>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Pact{
            id           : 0x2::object::new(arg4),
            agreement_id : arg0,
            creator      : 0x2::tx_context::sender(arg4),
            executed     : false,
        };
        mint_recipients(&v0, arg1, 0, arg4);
        mint_recipients(&v0, arg2, 1, arg4);
        mint_recipients(&v0, arg3, 2, arg4);
        0x2::transfer::share_object<Pact>(v0);
    }

    public entry fun mark_executed(arg0: &mut Pact, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.creator, 1);
        arg0.executed = true;
    }

    fun mint_recipients(arg0: &Pact, arg1: vector<address>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            mint_token(arg0, *0x1::vector::borrow<address>(&arg1, v0), arg2, arg3);
            v0 = v0 + 1;
        };
    }

    fun mint_token(arg0: &Pact, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AccessToken{
            id           : 0x2::object::new(arg3),
            pact         : 0x2::object::id<Pact>(arg0),
            agreement_id : arg0.agreement_id,
            role         : arg2,
        };
        0x2::transfer::transfer<AccessToken>(v0, arg1);
    }

    public entry fun seal_approve(arg0: vector<u8>, arg1: &Pact, arg2: &AccessToken, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0 == arg1.agreement_id, 3);
        assert!(arg2.agreement_id == arg1.agreement_id, 3);
        assert!(arg2.pact == 0x2::object::id<Pact>(arg1), 3);
        assert!(arg1.executed, 2);
        0x2::tx_context::sender(arg3);
    }

    // decompiled from Move bytecode v7
}

