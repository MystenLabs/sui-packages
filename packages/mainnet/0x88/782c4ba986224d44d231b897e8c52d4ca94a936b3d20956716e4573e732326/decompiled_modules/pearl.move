module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl {
    struct SbSupplyKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SbAwarded has copy, drop {
        recipient: address,
        amount: u64,
    }

    struct SbSpent has copy, drop {
        who: address,
        amount: u64,
    }

    struct PEARL has drop {
        dummy_field: bool,
    }

    struct PearlMint has key {
        id: 0x2::object::UID,
        treasury: 0x2::coin::TreasuryCap<PEARL>,
    }

    struct PearlMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    public(friend) fun burn(arg0: &mut PearlMint, arg1: 0x2::coin::Coin<PEARL>) : u64 {
        0x2::coin::burn<PEARL>(&mut arg0.treasury, arg1)
    }

    public fun total_supply(arg0: &PearlMint) : u64 {
        0x2::coin::total_supply<PEARL>(&arg0.treasury)
    }

    public fun admin_credit(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PearlMint, arg2: address, arg3: u64) {
        credit(arg1, arg2, arg3);
        let v0 = SbAwarded{
            recipient : arg2,
            amount    : arg3,
        };
        0x2::event::emit<SbAwarded>(v0);
    }

    public fun admin_credit_many(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PearlMint, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = 0x1::vector::length<address>(&arg2);
        assert!(v0 == 0x1::vector::length<u64>(&arg3), 1);
        let v1 = 0;
        while (v1 < v0) {
            credit(arg1, *0x1::vector::borrow<address>(&arg2, v1), *0x1::vector::borrow<u64>(&arg3, v1));
            let v2 = SbAwarded{
                recipient : *0x1::vector::borrow<address>(&arg2, v1),
                amount    : *0x1::vector::borrow<u64>(&arg3, v1),
            };
            0x2::event::emit<SbAwarded>(v2);
            v1 = v1 + 1;
        };
    }

    public fun admin_mint(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut PearlMint, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEARL>>(0x2::coin::mint<PEARL>(&mut arg1.treasury, arg2, arg4), arg3);
        let v0 = PearlMinted{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<PearlMinted>(v0);
    }

    public(friend) fun award(arg0: &mut PearlMint, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEARL>>(0x2::coin::mint<PEARL>(&mut arg0.treasury, arg1, arg3), arg2);
    }

    public(friend) fun award_soulbound(arg0: &mut PearlMint, arg1: address, arg2: u64) {
        if (arg2 > 0) {
            credit(arg0, arg1, arg2);
            let v0 = SbAwarded{
                recipient : arg1,
                amount    : arg2,
            };
            0x2::event::emit<SbAwarded>(v0);
        };
    }

    public fun balance_of(arg0: &PearlMint, arg1: address) : u64 {
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            *0x2::dynamic_field::borrow<address, u64>(&arg0.id, arg1)
        } else {
            0
        }
    }

    fun credit(arg0: &mut PearlMint, arg1: address, arg2: u64) {
        if (0x2::dynamic_field::exists<address>(&arg0.id, arg1)) {
            let v0 = 0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, arg1);
            *v0 = *v0 + arg2;
        } else {
            0x2::dynamic_field::add<address, u64>(&mut arg0.id, arg1, arg2);
        };
        let v1 = SbSupplyKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SbSupplyKey>(&arg0.id, v1)) {
            let v2 = SbSupplyKey{dummy_field: false};
            let v3 = 0x2::dynamic_field::borrow_mut<SbSupplyKey, u64>(&mut arg0.id, v2);
            *v3 = *v3 + arg2;
        } else {
            let v4 = SbSupplyKey{dummy_field: false};
            0x2::dynamic_field::add<SbSupplyKey, u64>(&mut arg0.id, v4, arg2);
        };
    }

    fun debit(arg0: &mut PearlMint, arg1: address, arg2: u64) {
        assert!(0x2::dynamic_field::exists<address>(&arg0.id, arg1), 0);
        let v0 = 0x2::dynamic_field::borrow_mut<address, u64>(&mut arg0.id, arg1);
        assert!(*v0 >= arg2, 0);
        *v0 = *v0 - arg2;
        let v1 = SbSupplyKey{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<SbSupplyKey, u64>(&mut arg0.id, v1);
        *v2 = *v2 - arg2;
    }

    fun init(arg0: PEARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEARL>(arg0, 0, b"PEARL", b"Atollia Pearl", b"The currency of the Epochs. Earned by opening packs, spent in the Tide Bazaar.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEARL>>(v1);
        let v2 = PearlMint{
            id       : 0x2::object::new(arg1),
            treasury : v0,
        };
        0x2::transfer::share_object<PearlMint>(v2);
    }

    public fun soulbound_supply(arg0: &PearlMint) : u64 {
        let v0 = SbSupplyKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SbSupplyKey>(&arg0.id, v0)) {
            let v2 = SbSupplyKey{dummy_field: false};
            *0x2::dynamic_field::borrow<SbSupplyKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public(friend) fun spend_soulbound(arg0: &mut PearlMint, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        debit(arg0, v0, arg1);
        let v1 = SbSpent{
            who    : v0,
            amount : arg1,
        };
        0x2::event::emit<SbSpent>(v1);
    }

    // decompiled from Move bytecode v7
}

