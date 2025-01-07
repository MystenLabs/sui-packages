module 0x561043b1c6135403a4c5f392fa31ee44c51ec03368a65ad2e378d43c595f7697::poap {
    struct PoapObject has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        gathering_id: 0x2::object::ID,
        created_by: address,
        created_at: u64,
    }

    struct POAP has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : PoapObject {
        PoapObject{
            id           : 0x2::object::new(arg5),
            name         : arg0,
            description  : arg1,
            img_url      : arg2,
            gathering_id : arg3,
            created_by   : 0x2::tx_context::sender(arg5),
            created_at   : 0x2::clock::timestamp_ms(arg4),
        }
    }

    fun init(arg0: POAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://poap.umilabs.org/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://poap.umilabs.org"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Japan Web3 Week Visitor"));
        let v4 = 0x2::package::claim<POAP>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<PoapObject>(&v4, v0, v2, arg1);
        0x2::display::update_version<PoapObject>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PoapObject>>(v5, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

