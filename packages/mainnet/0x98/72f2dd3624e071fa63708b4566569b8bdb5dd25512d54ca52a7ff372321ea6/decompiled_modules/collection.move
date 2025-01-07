module 0x9872f2dd3624e071fa63708b4566569b8bdb5dd25512d54ca52a7ff372321ea6::collection {
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

