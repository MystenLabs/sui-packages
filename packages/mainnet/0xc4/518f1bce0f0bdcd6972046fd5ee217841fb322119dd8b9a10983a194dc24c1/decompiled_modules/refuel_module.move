module 0xc4518f1bce0f0bdcd6972046fd5ee217841fb322119dd8b9a10983a194dc24c1::refuel_module {
    struct Config has key {
        id: 0x2::object::UID,
        owner: address,
        processed_deposits: 0x2::vec_map::VecMap<address, bool>,
    }

    struct Deposited has copy, drop {
        sender: address,
        chain_id: u64,
        recipient: address,
        amount: u64,
    }

    struct Relayed has copy, drop {
        deposit_id: address,
        sender: address,
        recipient: address,
        amount: u64,
    }

    public entry fun deposit(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        assert!(v0 > 0, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg3.owner);
        let v1 = Deposited{
            sender    : 0x2::tx_context::sender(arg4),
            chain_id  : arg1,
            recipient : arg2,
            amount    : v0,
        };
        0x2::event::emit<Deposited>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                 : 0x2::object::new(arg0),
            owner              : 0x2::tx_context::sender(arg0),
            processed_deposits : 0x2::vec_map::empty<address, bool>(),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public entry fun relay(arg0: address, arg1: address, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut Config, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 > 0, 1);
        assert!(!0x2::vec_map::contains<address, bool>(&arg3.processed_deposits, &arg0), 3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg1);
        0x2::vec_map::insert<address, bool>(&mut arg3.processed_deposits, arg0, true);
        let v1 = Relayed{
            deposit_id : arg0,
            sender     : 0x2::tx_context::sender(arg4),
            recipient  : arg1,
            amount     : v0,
        };
        0x2::event::emit<Relayed>(v1);
    }

    // decompiled from Move bytecode v6
}

