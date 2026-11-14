module 0xd88c42bdcc0219a4980f90884265d53cf099fd298790ec31de5b365d8a27bd08::pact {
    struct Pact has key {
        id: 0x2::object::UID,
        agreement_id: vector<u8>,
        creator: address,
        executed: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        pacts: 0x2::table::Table<vector<u8>, 0x2::object::ID>,
    }

    struct AccessToken has key {
        id: 0x2::object::UID,
        pact: 0x2::object::ID,
        agreement_id: vector<u8>,
        role: u8,
    }

    entry fun create_pact(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<address>, arg3: vector<address>, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg0.pacts, arg1), 4);
        let v0 = Pact{
            id           : 0x2::object::new(arg5),
            agreement_id : arg1,
            creator      : 0x2::tx_context::sender(arg5),
            executed     : false,
        };
        0x2::table::add<vector<u8>, 0x2::object::ID>(&mut arg0.pacts, arg1, 0x2::object::id<Pact>(&v0));
        mint_recipients(&v0, arg2, 0, arg5);
        mint_recipients(&v0, arg3, 1, arg5);
        mint_recipients(&v0, arg4, 2, arg5);
        0x2::transfer::share_object<Pact>(v0);
    }

    public entry fun create_pact_entry(arg0: vector<u8>, arg1: vector<address>, arg2: vector<address>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        abort 5
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id    : 0x2::object::new(arg0),
            pacts : 0x2::table::new<vector<u8>, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
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
        abort 5
    }

    entry fun seal_approve_registered(arg0: vector<u8>, arg1: &Registry, arg2: &Pact, arg3: &AccessToken) {
        assert!(0x2::table::contains<vector<u8>, 0x2::object::ID>(&arg1.pacts, arg0), 6);
        assert!(*0x2::table::borrow<vector<u8>, 0x2::object::ID>(&arg1.pacts, arg0) == 0x2::object::id<Pact>(arg2), 3);
        assert!(arg0 == arg2.agreement_id, 3);
        assert!(arg3.agreement_id == arg2.agreement_id, 3);
        assert!(arg3.pact == 0x2::object::id<Pact>(arg2), 3);
        assert!(arg2.executed, 2);
    }

    // decompiled from Move bytecode v7
}

