module 0xbba7b50e9ea178e138fec87973d3ce1bc405e47e6667dc72fa85d7ebba202da::deposit {
    struct DepositCreatedEvent has copy, drop {
        deposit_id: 0x2::object::ID,
        admin: address,
        amount: u64,
        workspace: 0x1::string::String,
    }

    struct DepositedObject has key {
        id: 0x2::object::UID,
        depositedCoin: 0x2::coin::Coin<0x2::sui::SUI>,
        workspace: 0x1::string::String,
    }

    public fun deposit(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = DepositedObject{
            id            : 0x2::object::new(arg3),
            depositedCoin : arg1,
            workspace     : arg2,
        };
        let v1 = DepositCreatedEvent{
            deposit_id : 0x2::object::id<DepositedObject>(&v0),
            admin      : arg0,
            amount     : 0x2::coin::value<0x2::sui::SUI>(&arg1),
            workspace  : arg2,
        };
        0x2::event::emit<DepositCreatedEvent>(v1);
        0x2::transfer::transfer<DepositedObject>(v0, arg0);
    }

    public fun receive(arg0: DepositedObject, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let DepositedObject {
            id            : v0,
            depositedCoin : v1,
            workspace     : _,
        } = arg0;
        0x2::object::delete(v0);
        v1
    }

    // decompiled from Move bytecode v6
}

