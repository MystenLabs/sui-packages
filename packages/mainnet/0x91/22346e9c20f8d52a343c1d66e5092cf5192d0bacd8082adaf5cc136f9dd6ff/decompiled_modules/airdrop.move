module 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::airdrop {
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

    public fun claim(arg0: Ticket, arg1: &mut Airdrop, arg2: &mut 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::Vault, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU> {
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
        0x2::coin::mint<0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::MAZU>(0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::mazu::cap_mut(arg2), v2, arg3)
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
            supply : 17777777777777776,
        };
        0x2::transfer::share_object<Airdrop>(v0);
    }

    public fun propose(arg0: &mut 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::Multisig, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Request{dummy_field: false};
        0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::create_proposal<Request>(arg0, arg1, v0, arg2);
    }

    public fun start(arg0: 0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::Proposal) : Request {
        0x9122346e9c20f8d52a343c1d66e5092cf5192d0bacd8082adaf5cc136f9dd6ff::multisig::get_request<Request>(arg0)
    }

    // decompiled from Move bytecode v6
}

