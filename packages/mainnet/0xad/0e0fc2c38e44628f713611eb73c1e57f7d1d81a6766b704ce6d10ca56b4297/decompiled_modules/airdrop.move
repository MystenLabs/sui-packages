module 0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::airdrop {
    struct Request has store {
        dummy_field: bool,
    }

    struct Ticket has store, key {
        id: 0x2::object::UID,
        amount: u64,
    }

    struct Airdrop has key {
        id: 0x2::object::UID,
        supply: u64,
    }

    public fun claim(arg0: Ticket, arg1: &mut Airdrop, arg2: &mut 0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::mazu::Vault, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::mazu::MAZU> {
        assert!(arg1.supply > 0, 0);
        let Ticket {
            id     : v0,
            amount : v1,
        } = arg0;
        0x2::object::delete(v0);
        let v2 = if (arg1.supply < v1) {
            arg1.supply
        } else {
            v1
        };
        arg1.supply = arg1.supply - v2;
        0x2::coin::mint<0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::mazu::MAZU>(0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::mazu::cap_mut(arg2), v2, arg3)
    }

    public fun complete(arg0: Request) {
        let Request {  } = arg0;
    }

    public fun drop(arg0: &Request, arg1: u64, arg2: vector<address>, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg2) != 0) {
            let v0 = Ticket{
                id     : 0x2::object::new(arg3),
                amount : arg1,
            };
            0x2::transfer::public_transfer<Ticket>(v0, 0x1::vector::pop_back<address>(&mut arg2));
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Airdrop{
            id     : 0x2::object::new(arg0),
            supply : 8888888888888888,
        };
        0x2::transfer::share_object<Airdrop>(v0);
    }

    public fun propose(arg0: &mut 0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::multisig::Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Request{dummy_field: false};
        0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::multisig::create_proposal<Request>(arg0, arg1, v0, arg2);
    }

    public fun start(arg0: 0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::multisig::Proposal) : Request {
        0xad0e0fc2c38e44628f713611eb73c1e57f7d1d81a6766b704ce6d10ca56b4297::multisig::get_request<Request>(arg0)
    }

    // decompiled from Move bytecode v6
}

