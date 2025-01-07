module 0x947ee4490bfbf0742d4d7a6600b210bb213315f1722c2c0d02eac2909f53e3cf::offer {
    struct Offer has store, key {
        id: 0x2::object::UID,
        applicant: address,
        desc: 0x1::string::String,
        publisher: address,
    }

    struct Contract has store, key {
        id: 0x2::object::UID,
        desc: 0x1::string::String,
        applicant: address,
    }

    struct ContractEvent has copy, drop {
        desc: 0x1::string::String,
        employer: address,
        employee: address,
    }

    public entry fun offer(arg0: address, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Offer{
            id        : 0x2::object::new(arg2),
            applicant : arg0,
            desc      : arg1,
            publisher : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<Offer>(v0, arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun sign_offer(arg0: &Offer, arg1: &0x52e42b171229db14d8cee617bd480f9ee6998a00802ff0438611e2a7393deee1::cfa::CFACertificate, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Contract{
            id        : 0x2::object::new(arg2),
            desc      : arg0.desc,
            applicant : 0x2::tx_context::sender(arg2),
        };
        let v1 = Contract{
            id        : 0x2::object::new(arg2),
            desc      : arg0.desc,
            applicant : 0x2::tx_context::sender(arg2),
        };
        0x2::transfer::transfer<Contract>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<Contract>(v1, arg0.publisher);
        let v2 = ContractEvent{
            desc     : arg0.desc,
            employer : arg0.publisher,
            employee : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ContractEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

