module 0x34c162f6b594cb5a1805264dd01ca5d80ce3eca6522e6ee37fd9ebfb9d3ddca::attributes {
    struct Attributes has store, key {
        id: 0x2::object::UID,
        number: u16,
        data: AttributesData,
    }

    struct AttributesData has store {
        aura: 0x1::string::String,
        background: 0x1::string::String,
        clothing: 0x1::string::String,
        decal: 0x1::string::String,
        headwear: 0x1::string::String,
        highlight: 0x1::string::String,
        internals: 0x1::string::String,
        mask: 0x1::string::String,
        screen: 0x1::string::String,
        skin: 0x1::string::String,
    }

    struct CreateAttributesCap has store, key {
        id: 0x2::object::UID,
        number: u16,
    }

    public fun new(arg0: CreateAttributesCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: 0x1::string::String, arg11: &mut 0x2::tx_context::TxContext) : Attributes {
        let v0 = AttributesData{
            aura       : arg1,
            background : arg2,
            clothing   : arg3,
            decal      : arg4,
            headwear   : arg5,
            highlight  : arg6,
            internals  : arg7,
            mask       : arg8,
            screen     : arg9,
            skin       : arg10,
        };
        let v1 = Attributes{
            id     : 0x2::object::new(arg11),
            number : arg0.number,
            data   : v0,
        };
        let CreateAttributesCap {
            id     : v2,
            number : _,
        } = arg0;
        0x2::object::delete(v2);
        v1
    }

    public(friend) fun create_attributes_cap_id(arg0: &CreateAttributesCap) : 0x2::object::ID {
        0x2::object::id<CreateAttributesCap>(arg0)
    }

    public(friend) fun issue_create_attributes_cap(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) : CreateAttributesCap {
        CreateAttributesCap{
            id     : 0x2::object::new(arg1),
            number : arg0,
        }
    }

    public(friend) fun number(arg0: &Attributes) : u16 {
        arg0.number
    }

    // decompiled from Move bytecode v6
}

