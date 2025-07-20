module 0x63facfcc525ab9bdcacc8ec0b804b99631e199f3c2213b0206043b8692234226::game {
    struct PaidToContract has copy, drop {
        player: address,
        amount: u64,
        timestamp: u64,
    }

    struct TreasuryAddressUpdated has copy, drop {
        old_address: address,
        new_address: address,
    }

    struct PublicKeyUpdated has copy, drop {
        old_key: vector<u8>,
        new_key: vector<u8>,
    }

    struct TreasuryTransfer has copy, drop {
        amount: u64,
        treasury_address: address,
    }

    struct PaymentMessageEvent has copy, drop {
        message: vector<u8>,
    }

    struct GameState has key {
        id: 0x2::object::UID,
        treasury_address: address,
        collected_fees: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        public_key: vector<u8>,
    }

    public fun get_collected_fees(arg0: &GameState) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees)
    }

    public fun get_treasury_address(arg0: &GameState) : address {
        arg0.treasury_address
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GameState{
            id               : 0x2::object::new(arg0),
            treasury_address : v0,
            collected_fees   : 0x2::balance::zero<0x2::sui::SUI>(),
            owner            : v0,
            public_key       : b"",
        };
        0x2::transfer::share_object<GameState>(v1);
    }

    public fun paySUI(arg0: &mut GameState, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg0.public_key), 4);
        let v0 = PaymentMessageEvent{message: arg3};
        0x2::event::emit<PaymentMessageEvent>(v0);
        assert!(0x2::ed25519::ed25519_verify(&arg2, &arg0.public_key, &arg3), 3);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 == arg5, 0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.collected_fees, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v2 = PaidToContract{
            player    : 0x2::tx_context::sender(arg6),
            amount    : v1,
            timestamp : arg4,
        };
        0x2::event::emit<PaidToContract>(v2);
    }

    public fun transfer_to_treasury(arg0: &mut GameState, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::ed25519::ed25519_verify(&arg1, &arg0.public_key, &arg2), 3);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.collected_fees);
        assert!(v0 > 0, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.collected_fees, v0), arg3), arg0.treasury_address);
        let v1 = TreasuryTransfer{
            amount           : v0,
            treasury_address : arg0.treasury_address,
        };
        0x2::event::emit<TreasuryTransfer>(v1);
    }

    public fun update_public_key(arg0: &mut GameState, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.public_key = arg1;
        let v0 = PublicKeyUpdated{
            old_key : arg0.public_key,
            new_key : arg1,
        };
        0x2::event::emit<PublicKeyUpdated>(v0);
    }

    public fun update_treasury_address(arg0: &mut GameState, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(arg1 != @0x0, 2);
        arg0.treasury_address = arg1;
        let v0 = TreasuryAddressUpdated{
            old_address : arg0.treasury_address,
            new_address : arg1,
        };
        0x2::event::emit<TreasuryAddressUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

