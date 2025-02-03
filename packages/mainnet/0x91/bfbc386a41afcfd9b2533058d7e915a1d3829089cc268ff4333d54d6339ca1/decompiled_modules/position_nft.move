module 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::position_nft {
    struct TurbosPositionNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        coin_type_a: 0x1::type_name::TypeName,
        coin_type_b: 0x1::type_name::TypeName,
        fee_type: 0x1::type_name::TypeName,
    }

    struct POSITION_NFT has drop {
        dummy_field: bool,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public(friend) fun burn(arg0: TurbosPositionNFT) {
        let TurbosPositionNFT {
            id          : v0,
            name        : _,
            description : _,
            img_url     : _,
            pool_id     : _,
            position_id : _,
            coin_type_a : _,
            coin_type_b : _,
            fee_type    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: POSITION_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"creator"));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"https://turbos.finance"));
        0x1::vector::push_back<0x1::string::String>(&mut v1, 0x1::string::utf8(b"Turbos Team"));
        let v2 = 0x2::package::claim<POSITION_NFT>(arg0, arg1);
        let v3 = 0x2::display::new<TurbosPositionNFT>(&v2, arg1);
        0x2::display::add_multiple<TurbosPositionNFT>(&mut v3, v0, v1);
        0x2::display::update_version<TurbosPositionNFT>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<TurbosPositionNFT>>(v3, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: 0x1::type_name::TypeName, arg6: 0x1::type_name::TypeName, arg7: 0x1::type_name::TypeName, arg8: &mut 0x2::tx_context::TxContext) : TurbosPositionNFT {
        let v0 = TurbosPositionNFT{
            id          : 0x2::object::new(arg8),
            name        : arg0,
            description : arg1,
            img_url     : 0x2::url::new_unsafe(0x1::string::to_ascii(arg2)),
            pool_id     : arg3,
            position_id : arg4,
            coin_type_a : arg5,
            coin_type_b : arg6,
            fee_type    : arg7,
        };
        let v1 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : 0x2::tx_context::sender(arg8),
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v1);
        v0
    }

    public fun pool_id(arg0: &TurbosPositionNFT) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun position_id(arg0: &TurbosPositionNFT) : 0x2::object::ID {
        arg0.pool_id
    }

    // decompiled from Move bytecode v6
}

