module 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::airdrop {
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

    public fun claim(arg0: Ticket, arg1: &mut Airdrop, arg2: &mut 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::mazu::Vault, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::mazu::MAZU> {
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
        0x2::coin::mint<0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::mazu::MAZU>(0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::mazu::cap_mut(arg2), v2, arg3)
    }

    public fun complete(arg0: Request) {
        let Request {  } = arg0;
    }

    public fun drop(arg0: &Request, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Ticket{
            id     : 0x2::object::new(arg3),
            amount : arg1,
        };
        0x2::transfer::public_transfer<Ticket>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Airdrop{
            id     : 0x2::object::new(arg0),
            supply : 8888888888888888,
        };
        0x2::transfer::share_object<Airdrop>(v0);
    }

    public fun propose(arg0: &mut 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Request{dummy_field: false};
        0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::create_proposal<Request>(arg0, arg1, v0, arg2);
    }

    public fun start(arg0: 0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::Proposal) : Request {
        0x65bad95497f72a10852730a121db4dc32f1f210225a9704806089b9400e840fd::multisig::get_request<Request>(arg0)
    }

    // decompiled from Move bytecode v6
}

