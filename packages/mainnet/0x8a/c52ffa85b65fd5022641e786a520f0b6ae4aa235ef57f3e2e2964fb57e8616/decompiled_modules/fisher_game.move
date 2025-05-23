module 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_game {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        active: bool,
    }

    struct FisherToVFisher has copy, drop {
        sender: address,
        amount: u64,
    }

    struct VFisherToFisher has copy, drop {
        sender: address,
        amount: u64,
    }

    struct ExtraSlot has copy, drop {
        sender: address,
    }

    public entry fun buy_extra_slot(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg0) >= 2500000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_config::get_fee_receiver());
        let v0 = ExtraSlot{sender: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<ExtraSlot>(v0);
    }

    public entry fun fisher_to_v_fisher(arg0: &GameState, arg1: 0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>>(arg1, 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_config::get_fisher_receiver());
        let v0 = FisherToVFisher{
            sender : 0x2::tx_context::sender(arg2),
            amount : 0x2::coin::value<0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_token::FISHER_TOKEN>(&arg1),
        };
        0x2::event::emit<FisherToVFisher>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameState{
            id     : 0x2::object::new(arg0),
            active : false,
        };
        0x2::transfer::share_object<GameState>(v1);
    }

    public entry fun set_active(arg0: &AdminCap, arg1: &mut GameState, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.active = arg2;
    }

    public entry fun v_fisher_to_fisher(arg0: &GameState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.active, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= 1000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x8ac52ffa85b65fd5022641e786a520f0b6ae4aa235ef57f3e2e2964fb57e8616::fisher_config::get_fisher_receiver());
        let v0 = VFisherToFisher{
            sender : 0x2::tx_context::sender(arg3),
            amount : arg2,
        };
        0x2::event::emit<VFisherToFisher>(v0);
    }

    // decompiled from Move bytecode v6
}

