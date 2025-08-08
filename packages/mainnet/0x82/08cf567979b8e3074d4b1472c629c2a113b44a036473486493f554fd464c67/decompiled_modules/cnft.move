module 0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::cnft {
    struct Attribute has store, key {
        id: 0x2::object::UID,
        attribute_type: 0x1::string::String,
        value: 0x1::string::String,
        custom_rating: u64,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        knapsack: 0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::Knapsack<Attribute>,
    }

    struct CNFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CNFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"attributes"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.loc.gov/static/portals/free-to-use/public-domain/cats/5.jpg"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{knapsack.attributes_display}"));
        let v5 = 0x2::display::new_with_fields<NFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"attribute_type"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"value"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"custom_rating"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{attribute_type}-{value}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://www.loc.gov/static/portals/free-to-use/public-domain/cats/19.jpg"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{attribute_type}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{value}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"{custom_rating}"));
        let v10 = 0x2::display::new_with_fields<Attribute>(&v0, v6, v8, arg1);
        0x2::display::update_version<Attribute>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Attribute>>(v10, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: vector<u8>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id       : 0x2::object::new(arg1),
            name     : 0x1::string::utf8(arg0),
            knapsack : 0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::new_knapsack<Attribute>(),
        };
        let v1 = Attribute{
            id             : 0x2::object::new(arg1),
            attribute_type : 0x1::string::utf8(b"background"),
            value          : 0x1::string::utf8(b"blue"),
            custom_rating  : 5,
        };
        0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::add_attribute<Attribute>(&mut v0.knapsack, 0x1::string::utf8(b"background"), v1);
        let v2 = &mut v0;
        update_attributes_display(v2, 0x1::string::utf8(b"background"));
        let v3 = Attribute{
            id             : 0x2::object::new(arg1),
            attribute_type : 0x1::string::utf8(b"color"),
            value          : 0x1::string::utf8(b"green"),
            custom_rating  : 7,
        };
        0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::add_attribute<Attribute>(&mut v0.knapsack, 0x1::string::utf8(b"background"), v3);
        let v4 = &mut v0;
        update_attributes_display(v4, 0x1::string::utf8(b"background"));
        let v5 = Attribute{
            id             : 0x2::object::new(arg1),
            attribute_type : 0x1::string::utf8(b"color"),
            value          : 0x1::string::utf8(b"red"),
            custom_rating  : 3,
        };
        0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::add_attribute<Attribute>(&mut v0.knapsack, 0x1::string::utf8(b"color"), v5);
        let v6 = &mut v0;
        update_attributes_display(v6, 0x1::string::utf8(b"color"));
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_attribute(arg0: &mut NFT, arg1: vector<u8>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(arg1);
        let v1 = 0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::remove_attribute<Attribute>(&mut arg0.knapsack, v0, arg2);
        if (0x1::option::is_some<Attribute>(&v1)) {
            0x2::transfer::public_transfer<Attribute>(0x1::option::extract<Attribute>(&mut v1), 0x2::tx_context::sender(arg3));
        };
        0x1::option::destroy_none<Attribute>(v1);
        update_attributes_display(arg0, v0);
    }

    fun update_attributes_display(arg0: &mut NFT, arg1: 0x1::string::String) {
        let v0 = 0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::get_attributes<Attribute>(&arg0.knapsack, &arg1);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<Attribute>(v0);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::borrow<Attribute>(v0, v3).value;
            0x1::vector::append<u8>(&mut v1, *0x1::string::as_bytes(&v4));
            if (v3 < v2 - 1) {
                0x1::vector::append<u8>(&mut v1, b", ");
            };
            v3 = v3 + 1;
        };
        0x8208cf567979b8e3074d4b1472c629c2a113b44a036473486493f554fd464c67::knapsack::update_attributes_display<Attribute>(&mut arg0.knapsack, arg1, 0x1::string::utf8(v1));
    }

    // decompiled from Move bytecode v6
}

