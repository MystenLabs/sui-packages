module 0x10786d3c5b9aa5ab3efb05dd7b349ad03e20c175d2995a8f895ad2145bf29a6e::vesuip {
    struct VeSuipMintEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct VeSuipBurnEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct Supply has store, key {
        id: 0x2::object::UID,
        supply: u64,
    }

    struct VeSuip has key {
        id: 0x2::object::UID,
        balance: u64,
    }

    public(friend) fun transfer(arg0: VeSuip, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VeSuip>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun amount(arg0: &VeSuip) : u64 {
        arg0.balance
    }

    public(friend) fun burn(arg0: &mut Supply, arg1: VeSuip, arg2: &mut 0x2::tx_context::TxContext) {
        let VeSuip {
            id      : v0,
            balance : v1,
        } = arg1;
        arg0.supply = arg0.supply - v1;
        let v2 = VeSuipBurnEvent{
            id     : 0x2::object::id<VeSuip>(&arg1),
            amount : v1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VeSuipBurnEvent>(v2);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Supply{
            id     : 0x2::object::new(arg0),
            supply : 0,
        };
        0x2::transfer::public_share_object<Supply>(v0);
    }

    public entry fun join(arg0: &mut VeSuip, arg1: VeSuip) {
        let VeSuip {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.balance = arg0.balance + v1;
    }

    public entry fun join_vec(arg0: &mut VeSuip, arg1: vector<VeSuip>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<VeSuip>(&arg1)) {
            join(arg0, 0x1::vector::pop_back<VeSuip>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<VeSuip>(arg1);
    }

    public(friend) fun mint(arg0: &mut Supply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VeSuip {
        let v0 = VeSuip{
            id      : 0x2::object::new(arg2),
            balance : arg1,
        };
        let v1 = VeSuipMintEvent{
            id     : 0x2::object::id<VeSuip>(&v0),
            amount : arg1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VeSuipMintEvent>(v1);
        arg0.supply = arg0.supply + arg1;
        v0
    }

    public(friend) fun mint_and_transfer(arg0: &mut Supply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        transfer(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

