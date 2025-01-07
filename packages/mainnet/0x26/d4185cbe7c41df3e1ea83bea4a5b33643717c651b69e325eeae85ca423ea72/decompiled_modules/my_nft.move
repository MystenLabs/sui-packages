module 0x26d4185cbe7c41df3e1ea83bea4a5b33643717c651b69e325eeae85ca423ea72::my_nft {
    struct CoCoNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
        count: u64,
    }

    struct MY_NFT has drop {
        dummy_field: bool,
    }

    fun date_key() : 0x1::string::String {
        0x1::string::utf8(b"date")
    }

    public entry fun first_mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = mint(arg0, arg1, arg2, arg7);
        0x2::vec_set::insert<0x1::string::String>(0x2::dynamic_field::borrow_mut<0x1::string::String, 0x2::vec_set::VecSet<0x1::string::String>>(&mut v0.id, date_key()), arg6);
        0x2::dynamic_object_field::add<0x1::string::String, 0x26d4185cbe7c41df3e1ea83bea4a5b33643717c651b69e325eeae85ca423ea72::item::CoCoItem>(&mut v0.id, item_key(), 0x26d4185cbe7c41df3e1ea83bea4a5b33643717c651b69e325eeae85ca423ea72::item::new_item(arg3, arg4, arg5, arg6, arg7));
        0x2::transfer::public_transfer<CoCoNFT>(v0, 0x2::tx_context::sender(arg7));
    }

    fun init(arg0: MY_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io/hero/{id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true CoCoNFT of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://sui-heroes.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Unknown Sui Fan"));
        let v4 = 0x2::package::claim<MY_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<CoCoNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<CoCoNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<CoCoNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    fun item_key() : 0x1::string::String {
        0x1::string::utf8(b"item")
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : CoCoNFT {
        let v0 = CoCoNFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            img_url     : arg2,
            count       : 1,
        };
        0x2::dynamic_field::add<0x1::string::String, 0x2::vec_set::VecSet<0x1::string::String>>(&mut v0.id, date_key(), 0x2::vec_set::empty<0x1::string::String>());
        v0
    }

    // decompiled from Move bytecode v6
}

