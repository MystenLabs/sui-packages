module 0x2f38264833106aff198970b7521a1ee8e1ef299defbff6f6746ddc5186b40708::attributes {
    struct Attributes has store, key {
        id: 0x2::object::UID,
        number: u16,
        data: AttributesData,
    }

    struct AttributesData has copy, store {
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
        let CreateAttributesCap {
            id     : v0,
            number : v1,
        } = arg0;
        let v2 = AttributesData{
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
        0x2::object::delete(v0);
        Attributes{
            id     : 0x2::object::new(arg11),
            number : v1,
            data   : v2,
        }
    }

    public fun create_attributes_cap_id(arg0: &CreateAttributesCap) : 0x2::object::ID {
        0x2::object::id<CreateAttributesCap>(arg0)
    }

    public fun get_attributes_data(arg0: &Attributes) : AttributesData {
        arg0.data
    }

    public fun issue_create_attributes_cap(arg0: u16, arg1: &mut 0x2::tx_context::TxContext) : CreateAttributesCap {
        CreateAttributesCap{
            id     : 0x2::object::new(arg1),
            number : arg0,
        }
    }

    public fun number(arg0: &Attributes) : u16 {
        arg0.number
    }

    // decompiled from Move bytecode v6
}

