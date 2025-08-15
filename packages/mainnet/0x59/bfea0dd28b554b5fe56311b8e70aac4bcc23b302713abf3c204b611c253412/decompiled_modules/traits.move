module 0x59bfea0dd28b554b5fe56311b8e70aac4bcc23b302713abf3c204b611c253412::traits {
    struct BaseTraits has store {
        head: 0x1::string::String,
        body: 0x1::string::String,
        background: 0x1::string::String,
    }

    struct TypeWeight has drop, store {
        type_id: u64,
        weight: u64,
    }

    public fun base_traits_background(arg0: &BaseTraits) : &0x1::string::String {
        &arg0.background
    }

    public fun base_traits_body(arg0: &BaseTraits) : &0x1::string::String {
        &arg0.body
    }

    public fun base_traits_head(arg0: &BaseTraits) : &0x1::string::String {
        &arg0.head
    }

    public fun new_base_traits(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String) : BaseTraits {
        BaseTraits{
            head       : arg0,
            body       : arg1,
            background : arg2,
        }
    }

    public fun new_type_weight(arg0: u64, arg1: u64) : TypeWeight {
        TypeWeight{
            type_id : arg0,
            weight  : arg1,
        }
    }

    public fun set_type_weight_weight(arg0: &mut TypeWeight, arg1: u64) {
        arg0.weight = arg1;
    }

    public fun type_weight_type_id(arg0: &TypeWeight) : u64 {
        arg0.type_id
    }

    public fun type_weight_weight(arg0: &TypeWeight) : u64 {
        arg0.weight
    }

    // decompiled from Move bytecode v6
}

