module 0xb62b0ec973945a58396362f8539db8f091df96cf66b6dc8671c7ad003145683f::pumpkin_voucherv4 {
    struct PumpkinVoucher has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x1::string::String,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct PUMPKIN_VOUCHERV4 has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public fun attributes(arg0: &PumpkinVoucher) : &0x1::string::String {
        &arg0.attributes
    }

    public entry fun bulk_mint(arg0: &MinterCap, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>, arg3: vector<vector<u8>>, arg4: vector<vector<u8>>, arg5: vector<address>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<address>(&arg5);
        assert!(0x1::vector::length<vector<u8>>(&arg1) == v0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == v0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg3) == v0, 0);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == v0, 0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = PumpkinVoucher{
                id          : 0x2::object::new(arg6),
                name        : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg1, v1)),
                description : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg2, v1)),
                image_url   : 0x2::url::new_unsafe_from_bytes(*0x1::vector::borrow<vector<u8>>(&arg3, v1)),
                attributes  : 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg4, v1)),
            };
            let v3 = NFTMinted{
                object_id : 0x2::object::id<PumpkinVoucher>(&v2),
                creator   : 0x2::tx_context::sender(arg6),
                name      : v2.name,
            };
            0x2::event::emit<NFTMinted>(v3);
            0x2::transfer::public_transfer<PumpkinVoucher>(v2, *0x1::vector::borrow<address>(&arg5, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun burn(arg0: PumpkinVoucher) {
        let PumpkinVoucher {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &PumpkinVoucher) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &PumpkinVoucher) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: PUMPKIN_VOUCHERV4, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MinterCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x2::package::claim<PUMPKIN_VOUCHERV4>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"attributes"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{attributes}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://pumpkinvoucher.example/"));
        let v6 = 0x2::display::new_with_fields<PumpkinVoucher>(&v1, v2, v4, arg1);
        0x2::display::update_version<PumpkinVoucher>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PumpkinVoucher>>(v6, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &MinterCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = PumpkinVoucher{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            attributes  : 0x1::string::utf8(arg4),
        };
        let v1 = NFTMinted{
            object_id : 0x2::object::id<PumpkinVoucher>(&v0),
            creator   : 0x2::tx_context::sender(arg6),
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<PumpkinVoucher>(v0, arg5);
    }

    public fun name(arg0: &PumpkinVoucher) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_attributes(arg0: &mut PumpkinVoucher, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 0);
        arg0.attributes = 0x1::string::utf8(arg1);
    }

    public entry fun update_image_url(arg0: &mut PumpkinVoucher, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0x0, 0);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg1);
    }

    // decompiled from Move bytecode v6
}

