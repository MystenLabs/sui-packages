module 0xbf432c7ce6ccf38b884516d2b44ae4248436bb135364528a1248838c42813777::deposit {
    struct DepositCreatedEvent has copy, drop {
        deposit_id: 0x2::object::ID,
        admin: address,
        amount: u64,
        workspace: 0x1::string::String,
    }

    struct DepositReceivedEvent has copy, drop {
        deposit_id: 0x2::object::ID,
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
            workspace     : v2,
        } = arg0;
        let v3 = v1;
        0x2::object::delete(v0);
        let v4 = DepositReceivedEvent{
            deposit_id : 0x2::object::id<DepositedObject>(&arg0),
            amount     : 0x2::coin::value<0x2::sui::SUI>(&v3),
            workspace  : v2,
        };
        0x2::event::emit<DepositReceivedEvent>(v4);
        v3
    }

    // decompiled from Move bytecode v6
}

