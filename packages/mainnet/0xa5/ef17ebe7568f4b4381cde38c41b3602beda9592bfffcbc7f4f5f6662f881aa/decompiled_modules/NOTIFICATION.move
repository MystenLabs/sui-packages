module 0xa5ef17ebe7568f4b4381cde38c41b3602beda9592bfffcbc7f4f5f6662f881aa::NOTIFICATION {
    struct Notification has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct NOTIFICATION has drop {
        dummy_field: bool,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        recipient: address,
    }

    public fun batch_mint(arg0: vector<vector<u8>>, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<address>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg3);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg0), 0);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg1), 0);
        assert!(v0 == 0x1::vector::length<vector<u8>>(&arg2), 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = Notification{
                id          : 0x2::object::new(arg4),
                name        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg0, v1)),
                description : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v1)),
                url         : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg2, v1)),
            };
            let v3 = MintNFTEvent{
                object_id : 0x2::object::uid_to_inner(&v2.id),
                creator   : 0x2::tx_context::sender(arg4),
                name      : v2.name,
                recipient : *0x1::vector::borrow<address>(&arg3, v1),
            };
            0x2::event::emit<MintNFTEvent>(v3);
            0x2::transfer::transfer<Notification>(v2, *0x1::vector::borrow<address>(&arg3, v1));
            v1 = v1 + 1;
        };
    }

    fun init(arg0: NOTIFICATION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        let v4 = 0x2::package::claim<NOTIFICATION>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Notification>(&v4, v0, v2, arg1);
        0x2::display::update_version<Notification>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Notification>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Notification{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg4),
            name      : v0.name,
            recipient : arg3,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        0x2::transfer::transfer<Notification>(v0, arg3);
    }

    // decompiled from Move bytecode v6
}

