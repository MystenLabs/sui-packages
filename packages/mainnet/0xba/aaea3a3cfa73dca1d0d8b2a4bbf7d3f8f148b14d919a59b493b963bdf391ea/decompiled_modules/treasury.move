module 0xbaaaea3a3cfa73dca1d0d8b2a4bbf7d3f8f148b14d919a59b493b963bdf391ea::treasury {
    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x1::option::Option<0x2::coin::TreasuryCap<T0>>,
        owner: address,
        is_paused: bool,
    }

    struct TreasuryInitialized has copy, drop {
        owner: address,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
    }

    struct OwnershipTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
    }

    struct PauseEvent has copy, drop {
        paused: bool,
    }

    struct CapExtracted has copy, drop {
        recipient: address,
    }

    public entry fun burn<T0>(arg0: &mut Treasury<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        assert!(!arg0.is_paused, 6);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 7);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 1);
        0x2::coin::burn<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), arg1);
        let v1 = BurnEvent{
            amount : v0,
            burner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<BurnEvent>(v1);
    }

    public entry fun extract_cap<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 7);
        let v0 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T0>>(0x1::option::extract<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), v0);
        arg0.is_paused = true;
        let v1 = CapExtracted{recipient: v0};
        0x2::event::emit<CapExtracted>(v1);
    }

    public entry fun initialize_treasury<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg1, 0);
        let v0 = Treasury<T0>{
            id           : 0x2::object::new(arg2),
            treasury_cap : 0x1::option::some<0x2::coin::TreasuryCap<T0>>(arg0),
            owner        : arg1,
            is_paused    : false,
        };
        0x2::transfer::share_object<Treasury<T0>>(v0);
        let v1 = TreasuryInitialized{owner: arg1};
        0x2::event::emit<TreasuryInitialized>(v1);
    }

    public entry fun mint<T0>(arg0: &mut Treasury<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.owner, 0);
        assert!(!arg0.is_paused, 6);
        assert!(0x1::option::is_some<0x2::coin::TreasuryCap<T0>>(&arg0.treasury_cap), 7);
        assert!(arg1 > 0, 1);
        0x2::coin::mint_and_transfer<T0>(0x1::option::borrow_mut<0x2::coin::TreasuryCap<T0>>(&mut arg0.treasury_cap), arg1, arg2, arg3);
        let v0 = MintEvent{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public entry fun toggle_pause<T0>(arg0: &mut Treasury<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 0);
        arg0.is_paused = !arg0.is_paused;
        let v0 = PauseEvent{paused: arg0.is_paused};
        0x2::event::emit<PauseEvent>(v0);
    }

    public entry fun transfer_ownership<T0>(arg0: &mut Treasury<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.owner = arg1;
        let v0 = OwnershipTransferred{
            previous_owner : arg0.owner,
            new_owner      : arg1,
        };
        0x2::event::emit<OwnershipTransferred>(v0);
    }

    // decompiled from Move bytecode v6
}

