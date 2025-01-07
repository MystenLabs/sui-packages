module 0x41d76f59ee5fbe76f4069d89cdf57a256129c6b53cb2c4ead8526f9b9c9de191::message_contract {
    struct MessageStorage has key {
        id: 0x2::object::UID,
        messages: vector<0x1::string::String>,
        gas_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct MessageAdded has copy, drop {
        message: 0x1::string::String,
    }

    public entry fun add_gas(arg0: &mut MessageStorage, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, arg2, arg3)));
    }

    public entry fun add_message(arg0: &mut MessageStorage, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = (0x1::string::length(&v0) as u64) * 100;
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.gas_balance) >= v1, 0);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.messages, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_balance, v1), arg2), 0x2::tx_context::sender(arg2));
        let v2 = MessageAdded{message: v0};
        0x2::event::emit<MessageAdded>(v2);
    }

    public fun create(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MessageStorage{
            id          : 0x2::object::new(arg0),
            messages    : 0x1::vector::empty<0x1::string::String>(),
            gas_balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<MessageStorage>(v0);
    }

    public fun read_messages(arg0: &MessageStorage) : &vector<0x1::string::String> {
        &arg0.messages
    }

    // decompiled from Move bytecode v6
}

