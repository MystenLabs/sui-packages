module 0x1c0ce7de75f8c0dbba275cf03fbe77081e82fe6146ab3a5f036df4528d712736::playnet_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        external_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        telegram_compatible_link: 0x1::string::String,
        roblox_compatible_link: 0x1::string::String,
    }

    struct PLAYNET_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAYNET_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<PLAYNET_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_to_recipient(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id                       : 0x2::object::new(arg7),
            external_id              : arg0,
            name                     : arg1,
            description              : arg2,
            image_url                : arg3,
            telegram_compatible_link : arg4,
            roblox_compatible_link   : arg5,
        };
        0x2::transfer::public_transfer<NFT>(v0, arg6);
    }

    // decompiled from Move bytecode v6
}

