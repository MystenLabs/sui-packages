module 0x27dd21a3e9fa6483b2da62194f8ebf6e5f062ff0d0a68139257384b97977d239::collection {
    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        supply: u16,
    }

    public(friend) fun new(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id     : 0x2::object::new(arg1),
            supply : arg0,
        }
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
    }

    public(friend) fun supply(arg0: &Collection) : u16 {
        arg0.supply
    }

    public(friend) fun transfer_collection(arg0: Collection, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Collection>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

