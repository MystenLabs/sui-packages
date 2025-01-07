module 0x26bc54dfd98b7d552897531b4dc38eeff15ade647fe7379c09cf5614d13a4520::offer {
    struct Offer has store, key {
        id: 0x2::object::UID,
        desc: 0x1::string::String,
        publisher: address,
        deadline_ms: u64,
    }

    struct Contract has store, key {
        id: 0x2::object::UID,
        employee: address,
        employer: address,
        offer_id: address,
    }

    struct ContractEvent has copy, drop {
        desc: 0x1::string::String,
        employer: address,
        employee: address,
    }

    public entry fun offer(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Offer{
            id          : 0x2::object::new(arg3),
            desc        : arg1,
            publisher   : 0x2::tx_context::sender(arg3),
            deadline_ms : arg2,
        };
        0x2::transfer::transfer<Offer>(v0, arg0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun sign_offer(arg0: &0x2::clock::Clock, arg1: &Offer, arg2: &0x52e42b171229db14d8cee617bd480f9ee6998a00802ff0438611e2a7393deee1::cfa::CFACertificate, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.deadline_ms > 0x2::clock::timestamp_ms(arg0), 1);
        let v0 = Contract{
            id       : 0x2::object::new(arg3),
            employee : 0x2::tx_context::sender(arg3),
            employer : arg1.publisher,
            offer_id : 0x2::object::uid_to_address(&arg1.id),
        };
        let v1 = Contract{
            id       : 0x2::object::new(arg3),
            employee : 0x2::tx_context::sender(arg3),
            employer : arg1.publisher,
            offer_id : 0x2::object::uid_to_address(&arg1.id),
        };
        0x2::transfer::transfer<Contract>(v0, 0x2::tx_context::sender(arg3));
        0x2::transfer::transfer<Contract>(v1, arg1.publisher);
        let v2 = ContractEvent{
            desc     : arg1.desc,
            employer : arg1.publisher,
            employee : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ContractEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

