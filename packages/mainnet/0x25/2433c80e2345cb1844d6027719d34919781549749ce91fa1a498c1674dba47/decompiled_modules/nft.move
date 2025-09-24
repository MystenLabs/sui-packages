module 0x252433c80e2345cb1844d6027719d34919781549749ce91fa1a498c1674dba47::nft {
    struct VS1 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        thumbnail_url: 0x2::url::Url,
        background_color: 0x1::string::String,
        link: 0x2::url::Url,
        burnable: bool,
        attributes: vector<NftAttribute>,
        animation_urls: vector<AnimationUrl>,
    }

    struct VS1MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NftAttribute has copy, drop, store {
        displayType: 0x1::string::String,
        name: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct AnimationUrl has copy, drop, store {
        animationType: 0x1::string::String,
        value: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun transfer(arg0: VS1, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<VS1>(arg0, arg1);
    }

    public fun burn(arg0: VS1, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.burnable, 0);
        let VS1 {
            id               : v0,
            name             : _,
            description      : _,
            image_url        : _,
            thumbnail_url    : _,
            background_color : _,
            link             : _,
            burnable         : _,
            attributes       : _,
            animation_urls   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<AdminCap>(v0, arg1);
    }

    public fun create_animation_url(arg0: vector<u8>, arg1: vector<u8>) : AnimationUrl {
        AnimationUrl{
            animationType : 0x1::string::utf8(arg0),
            value         : 0x1::string::utf8(arg1),
        }
    }

    public fun create_attribute(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : NftAttribute {
        NftAttribute{
            displayType : 0x1::string::utf8(arg0),
            name        : 0x1::string::utf8(arg1),
            value       : 0x1::string::utf8(arg2),
        }
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"background_color"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"link"));
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://www.venly.io"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{thumbnail_url}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{background_color}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{link}"));
        let v7 = 0x2::display::new_with_fields<VS1>(&v0, v3, v5, arg1);
        0x2::display::update_version<VS1>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::display::Display<VS1>>(v7, v1);
        0x2::transfer::transfer<AdminCap>(v2, v1);
    }

    public fun mint_to_destination(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: vector<NftAttribute>, arg9: vector<AnimationUrl>, arg10: address, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = VS1{
            id               : 0x2::object::new(arg11),
            name             : 0x1::string::utf8(arg1),
            description      : 0x1::string::utf8(arg2),
            image_url        : 0x2::url::new_unsafe_from_bytes(arg3),
            thumbnail_url    : 0x2::url::new_unsafe_from_bytes(arg4),
            background_color : 0x1::string::utf8(arg5),
            link             : 0x2::url::new_unsafe_from_bytes(arg6),
            burnable         : arg7,
            attributes       : arg8,
            animation_urls   : arg9,
        };
        let v1 = VS1MintEvent{
            object_id : 0x2::object::id<VS1>(&v0),
            creator   : 0x2::tx_context::sender(arg11),
            name      : v0.name,
        };
        0x2::event::emit<VS1MintEvent>(v1);
        0x2::transfer::public_transfer<VS1>(v0, arg10);
    }

    public fun mint_to_multiple_destinations(arg0: &AdminCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: bool, arg8: vector<NftAttribute>, arg9: vector<AnimationUrl>, arg10: vector<address>, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg10)) {
            let v1 = VS1{
                id               : 0x2::object::new(arg11),
                name             : 0x1::string::utf8(arg1),
                description      : 0x1::string::utf8(arg2),
                image_url        : 0x2::url::new_unsafe_from_bytes(arg3),
                thumbnail_url    : 0x2::url::new_unsafe_from_bytes(arg4),
                background_color : 0x1::string::utf8(arg5),
                link             : 0x2::url::new_unsafe_from_bytes(arg6),
                burnable         : arg7,
                attributes       : arg8,
                animation_urls   : arg9,
            };
            let v2 = VS1MintEvent{
                object_id : 0x2::object::id<VS1>(&v1),
                creator   : 0x2::tx_context::sender(arg11),
                name      : 0x1::string::utf8(arg1),
            };
            0x2::event::emit<VS1MintEvent>(v2);
            0x2::transfer::public_transfer<VS1>(v1, *0x1::vector::borrow<address>(&arg10, v0));
            v0 = v0 + 1;
        };
    }

    public fun remove_admin(arg0: &AdminCap, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun update_animation_urls(arg0: &AdminCap, arg1: &mut VS1, arg2: vector<AnimationUrl>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.animation_urls = arg2;
    }

    public fun update_attributes(arg0: &AdminCap, arg1: &mut VS1, arg2: vector<NftAttribute>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.attributes = arg2;
    }

    public fun update_description(arg0: &AdminCap, arg1: &mut VS1, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.description = 0x1::string::utf8(arg2);
    }

    public fun update_image_url(arg0: &AdminCap, arg1: &mut VS1, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.image_url = arg2;
    }

    public fun update_link(arg0: &AdminCap, arg1: &mut VS1, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.link = arg2;
    }

    public fun update_metadata(arg0: &mut VS1, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: bool, arg7: vector<NftAttribute>, arg8: vector<AnimationUrl>, arg9: &mut 0x2::tx_context::TxContext) {
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
        arg0.image_url = 0x2::url::new_unsafe_from_bytes(arg3);
        arg0.thumbnail_url = 0x2::url::new_unsafe_from_bytes(arg4);
        arg0.link = 0x2::url::new_unsafe_from_bytes(arg5);
        arg0.burnable = arg6;
        arg0.attributes = arg7;
        arg0.animation_urls = arg8;
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut VS1, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.name = 0x1::string::utf8(arg2);
    }

    public fun update_thumbnail_url(arg0: &AdminCap, arg1: &mut VS1, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.thumbnail_url = arg2;
    }

    // decompiled from Move bytecode v6
}

