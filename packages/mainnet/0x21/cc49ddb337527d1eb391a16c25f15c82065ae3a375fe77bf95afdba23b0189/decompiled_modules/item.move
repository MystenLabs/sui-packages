module 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::item {
    struct Item has copy, drop, store {
        item_type: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::ItemType,
        identifier: 0x1::option::Option<0x2::object::ID>,
        amount: 0x1::option::Option<u64>,
    }

    public fun amount(arg0: &Item) : &0x1::option::Option<u64> {
        &arg0.amount
    }

    public(friend) fun clone(arg0: &Item) : Item {
        Item{
            item_type  : item_type(arg0),
            identifier : *identifier(arg0),
            amount     : *amount(arg0),
        }
    }

    public fun identifier(arg0: &Item) : &0x1::option::Option<0x2::object::ID> {
        &arg0.identifier
    }

    public fun item_type(arg0: &Item) : 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::ItemType {
        arg0.item_type
    }

    public(friend) fun new(arg0: 0x21cc49ddb337527d1eb391a16c25f15c82065ae3a375fe77bf95afdba23b0189::enums::ItemType, arg1: 0x1::option::Option<0x2::object::ID>, arg2: 0x1::option::Option<u64>) : Item {
        Item{
            item_type  : arg0,
            identifier : arg1,
            amount     : arg2,
        }
    }

    // decompiled from Move bytecode v6
}

