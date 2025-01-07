module 0x5881c6967c0ff88580267cf5e479521f8df93da30228ec7a2b522b568d4524fe::kriya_basecamp_nft {
    struct KriyaBasecampNFT has key {
        id: 0x2::object::UID,
        multiplier: u8,
    }

    struct KRIYA_BASECAMP_NFT has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: KRIYA_BASECAMP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"multiplier"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kriya Basecamp NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{multiplier}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.discordapp.com/attachments/1203687243823456326/1221135053262815232/Screenshot_2024-03-23_at_10.04.19_PM.png?ex=661179a4&is=65ff04a4&hm=b98ba653bfed98c6e81dc592ec2288723589e82f8e0f24dafad40fcacdbb85b5&"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.discordapp.com/attachments/1203687243823456326/1221135053262815232/Screenshot_2024-03-23_at_10.04.19_PM.png?ex=661179a4&is=65ff04a4&hm=b98ba653bfed98c6e81dc592ec2288723589e82f8e0f24dafad40fcacdbb85b5&"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Kriya Basecamp NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.kriya.finance"));
        let v4 = 0x2::package::claim<KRIYA_BASECAMP_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KriyaBasecampNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<KriyaBasecampNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KriyaBasecampNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &AdminCap, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : KriyaBasecampNFT {
        KriyaBasecampNFT{
            id         : 0x2::object::new(arg2),
            multiplier : arg1,
        }
    }

    // decompiled from Move bytecode v6
}

