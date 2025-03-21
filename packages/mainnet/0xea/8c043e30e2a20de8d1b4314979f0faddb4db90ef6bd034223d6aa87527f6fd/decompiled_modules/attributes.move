module 0xea8c043e30e2a20de8d1b4314979f0faddb4db90ef6bd034223d6aa87527f6fd::attributes {
    struct ATTRIBUTES has drop {
        dummy_field: bool,
    }

    struct DynAttrObj has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    public fun del_attribute(arg0: DynAttrObj) {
        let DynAttrObj {
            id   : v0,
            name : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: ATTRIBUTES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ATTRIBUTES>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"A dynamic attribute"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"ipfs://QmVkiWEpFrCPg1GPgRdTVaPr4XCy8Bg7RnGnbcKg44QHoM"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://xxx.com/aaa/1"));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<DynAttrObj>>(0x2::display::new_with_fields<DynAttrObj>(&v0, v1, v3, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun new_attribute(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) : DynAttrObj {
        DynAttrObj{
            id   : 0x2::object::new(arg1),
            name : 0x1::string::utf8(arg0),
        }
    }

    public fun update_value(arg0: &mut DynAttrObj, arg1: vector<u8>) {
        arg0.name = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

