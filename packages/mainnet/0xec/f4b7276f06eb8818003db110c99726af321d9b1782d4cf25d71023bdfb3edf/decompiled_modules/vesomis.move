module 0xecf4b7276f06eb8818003db110c99726af321d9b1782d4cf25d71023bdfb3edf::vesomis {
    struct VeSomisMintEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct VeSomisBurnEvent has copy, drop {
        id: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct Supply has store, key {
        id: 0x2::object::UID,
        supply: u64,
    }

    struct VeSomis has key {
        id: 0x2::object::UID,
        balance: u64,
    }

    public(friend) fun transfer(arg0: VeSomis, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<VeSomis>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun amount(arg0: &VeSomis) : u64 {
        arg0.balance
    }

    public(friend) fun burn(arg0: &mut Supply, arg1: VeSomis, arg2: &mut 0x2::tx_context::TxContext) {
        let VeSomis {
            id      : v0,
            balance : v1,
        } = arg1;
        arg0.supply = arg0.supply - v1;
        let v2 = VeSomisBurnEvent{
            id     : 0x2::object::id<VeSomis>(&arg1),
            amount : v1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VeSomisBurnEvent>(v2);
        0x2::object::delete(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Supply{
            id     : 0x2::object::new(arg0),
            supply : 0,
        };
        0x2::transfer::public_share_object<Supply>(v0);
    }

    public(friend) fun join(arg0: &mut VeSomis, arg1: VeSomis) {
        let VeSomis {
            id      : v0,
            balance : v1,
        } = arg1;
        0x2::object::delete(v0);
        arg0.balance = arg0.balance + v1;
    }

    public(friend) fun mint(arg0: &mut Supply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : VeSomis {
        let v0 = VeSomis{
            id      : 0x2::object::new(arg2),
            balance : arg1,
        };
        let v1 = VeSomisMintEvent{
            id     : 0x2::object::id<VeSomis>(&v0),
            amount : arg1,
            sender : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<VeSomisMintEvent>(v1);
        arg0.supply = arg0.supply + arg1;
        v0
    }

    public(friend) fun mint_and_transfer(arg0: &mut Supply, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2);
        transfer(v0, arg2);
    }

    // decompiled from Move bytecode v6
}

