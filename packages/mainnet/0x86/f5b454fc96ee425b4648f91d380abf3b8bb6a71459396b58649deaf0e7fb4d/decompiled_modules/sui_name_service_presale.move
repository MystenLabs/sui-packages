module 0x86f5b454fc96ee425b4648f91d380abf3b8bb6a71459396b58649deaf0e7fb4d::sui_name_service_presale {
    struct SuiNameServicePresaleNFT has store, key {
        id: 0x2::object::UID,
        title: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        title: 0x1::string::String,
    }

    struct SUI_NAME_SERVICE_PRESALE has drop {
        dummy_field: bool,
    }

    public fun description(arg0: &SuiNameServicePresaleNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SuiNameServicePresaleNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: SUI_NAME_SERVICE_PRESALE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{title}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        let v4 = 0x2::package::claim<SUI_NAME_SERVICE_PRESALE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SuiNameServicePresaleNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<SuiNameServicePresaleNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiNameServicePresaleNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiNameServicePresaleNFT{
            id          : 0x2::object::new(arg0),
            title       : 0x1::string::utf8(b"Sui Name Service Presale"),
            description : 0x1::string::utf8(b"This NFT represents your spot in the upcoming Sui Name Service Presale"),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/6oYX7cM.jpeg"),
        };
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = NFTMinted{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            title     : v0.title,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<SuiNameServicePresaleNFT>(v0, v1);
    }

    public fun title(arg0: &SuiNameServicePresaleNFT) : &0x1::string::String {
        &arg0.title
    }

    // decompiled from Move bytecode v6
}

