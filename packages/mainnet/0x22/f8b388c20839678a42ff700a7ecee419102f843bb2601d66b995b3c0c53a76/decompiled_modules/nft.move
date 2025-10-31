module 0x22f8b388c20839678a42ff700a7ecee419102f843bb2601d66b995b3c0c53a76::nft {
    struct MyNFT has store, key {
        id: 0x2::object::UID,
        nama: 0x1::string::String,
        deskripsi: 0x1::string::String,
        url: 0x1::string::String,
        access_level: 0x1::string::String,
        vote_weight: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"access_level"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"vote_weight"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{nama}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{deskripsi}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{access_level}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{vote_weight}"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<MyNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<MyNFT>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MyNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = MyNFT{
            id           : 0x2::object::new(arg7),
            nama         : arg1,
            deskripsi    : arg2,
            url          : arg3,
            access_level : arg4,
            vote_weight  : arg5,
        };
        0x2::transfer::public_transfer<MyNFT>(v0, arg6);
    }

    // decompiled from Move bytecode v6
}

