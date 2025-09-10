module 0x9fec02b08815b90d23cc070735c53d9241c9a7c8bbe88a1a025d493a58618f34::traits {
    struct BaseTraits has store {
        head: 0x1::string::String,
        body: 0x1::string::String,
        background: 0x1::string::String,
    }

    struct TypeWeight has drop, store {
        type_id: u64,
        weight: u64,
    }

    public(friend) fun base_traits_background(arg0: &BaseTraits) : &0x1::string::String {
        &arg0.background
    }

    public(friend) fun base_traits_body(arg0: &BaseTraits) : &0x1::string::String {
        &arg0.body
    }

    public(friend) fun base_traits_head(arg0: &BaseTraits) : &0x1::string::String {
        &arg0.head
    }

    public(friend) fun new_base_traits(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : BaseTraits {
        BaseTraits{
            head       : arg0,
            body       : arg1,
            background : arg2,
        }
    }

    public(friend) fun new_type_weight(arg0: u64, arg1: u64) : TypeWeight {
        TypeWeight{
            type_id : arg0,
            weight  : arg1,
        }
    }

    public(friend) fun set_type_weight_weight(arg0: &mut TypeWeight, arg1: u64) {
        arg0.weight = arg1;
    }

    public(friend) fun type_weight_type_id(arg0: &TypeWeight) : u64 {
        arg0.type_id
    }

    public(friend) fun type_weight_weight(arg0: &TypeWeight) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v6
}

