module 0x89275899de97e5dee73593a3545032a0e279027727363658fd8f17226b9cd026::test_haedal {
    struct Res has store, key {
        id: 0x2::object::UID,
        res: u64,
    }

    public entry fun new_res(arg0: &0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::Staking, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Res{
            id  : 0x2::object::new(arg1),
            res : 0xbde4ba4c2e274a60ce15c1cfff9e5c42e41654ac8b6d906a57efa4bd3c29f47d::staking::get_exchange_rate(arg0),
        };
        0x2::transfer::public_transfer<Res>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

