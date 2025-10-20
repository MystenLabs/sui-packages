module 0xafc31ae0bc0a41141f705ac2cc2a2adaf0c77352cb7823b3f99bf5edc7fbffca::nft {
    struct VS11 has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        thumbnail_url: 0x2::url::Url,
        background_color: 0x1::string::String,
        link: 0x2::url::Url,
        burnable: bool,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        animation_urls: vector<AnimationUrl>,
    }

    struct VS11MintEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
        kiosk_id: 0x1::option::Option<0x2::object::ID>,
        kiosk_owner_cap: 0x1::option::Option<0x2::object::ID>,
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

    public fun transfer(arg0: VS11, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<VS11>(arg0, arg1);
    }

    public fun burn(arg0: VS11, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.burnable, 0);
        let VS11 {
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
        let v7 = 0x2::display::new_with_fields<VS11>(&v0, v3, v5, arg1);
        0x2::display::update_version<VS11>(&mut v7);
        let (v8, v9) = 0x2::transfer_policy::new<VS11>(&v0, arg1);
        let v10 = v9;
        let v11 = v8;
        if (213 > 0) {
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<VS11>(&mut v11, &v10, 213, 0);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<VS11>(&mut v11, &v10);
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<VS11>>(v11);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<VS11>>(v10, v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v1);
        0x2::transfer::public_transfer<0x2::display::Display<VS11>>(v7, v1);
        0x2::transfer::transfer<AdminCap>(v2, v1);
    }

    public fun mint_to_multiple_destinations(arg0: &AdminCap, arg1: &0x2::transfer_policy::TransferPolicy<VS11>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: bool, arg9: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg10: vector<AnimationUrl>, arg11: vector<address>, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg11)) {
            let v1 = VS11{
                id               : 0x2::object::new(arg12),
                name             : 0x1::string::utf8(arg2),
                description      : 0x1::string::utf8(arg3),
                image_url        : 0x2::url::new_unsafe_from_bytes(arg4),
                thumbnail_url    : 0x2::url::new_unsafe_from_bytes(arg5),
                background_color : 0x1::string::utf8(arg6),
                link             : 0x2::url::new_unsafe_from_bytes(arg7),
                burnable         : arg8,
                attributes       : arg9,
                animation_urls   : arg10,
            };
            if (213 > 0) {
                let (v2, v3) = 0x2::kiosk::new(arg12);
                let v4 = v3;
                let v5 = v2;
                let v6 = VS11MintEvent{
                    object_id       : 0x2::object::id<VS11>(&v1),
                    creator         : 0x2::tx_context::sender(arg12),
                    name            : 0x1::string::utf8(arg2),
                    kiosk_id        : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::Kiosk>(&v5)),
                    kiosk_owner_cap : 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v4)),
                };
                0x2::event::emit<VS11MintEvent>(v6);
                0x2::kiosk::lock<VS11>(&mut v5, &v4, arg1, v1);
                0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
                0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, *0x1::vector::borrow<address>(&arg11, v0));
            } else {
                let v7 = VS11MintEvent{
                    object_id       : 0x2::object::id<VS11>(&v1),
                    creator         : 0x2::tx_context::sender(arg12),
                    name            : 0x1::string::utf8(arg2),
                    kiosk_id        : 0x1::option::none<0x2::object::ID>(),
                    kiosk_owner_cap : 0x1::option::none<0x2::object::ID>(),
                };
                0x2::event::emit<VS11MintEvent>(v7);
                0x2::transfer::public_transfer<VS11>(v1, *0x1::vector::borrow<address>(&arg11, v0));
            };
            v0 = v0 + 1;
        };
    }

    public fun remove_admin(arg0: &AdminCap, arg1: AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let AdminCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun update_animation_urls(arg0: &AdminCap, arg1: &mut VS11, arg2: vector<AnimationUrl>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.animation_urls = arg2;
    }

    public fun update_attributes(arg0: &AdminCap, arg1: &mut VS11, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.attributes = arg2;
    }

    public fun update_background_color(arg0: &AdminCap, arg1: &mut VS11, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.background_color = 0x1::string::utf8(arg2);
    }

    public fun update_description(arg0: &AdminCap, arg1: &mut VS11, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.description = 0x1::string::utf8(arg2);
    }

    public fun update_image_url(arg0: &AdminCap, arg1: &mut VS11, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.image_url = arg2;
    }

    public fun update_link(arg0: &AdminCap, arg1: &mut VS11, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.link = arg2;
    }

    public fun update_metadata(arg0: &AdminCap, arg1: &mut VS11, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: bool, arg9: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg10: vector<AnimationUrl>, arg11: &mut 0x2::tx_context::TxContext) {
        arg1.name = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(arg3);
        arg1.image_url = 0x2::url::new_unsafe_from_bytes(arg4);
        arg1.thumbnail_url = 0x2::url::new_unsafe_from_bytes(arg5);
        arg1.link = 0x2::url::new_unsafe_from_bytes(arg6);
        arg1.burnable = arg8;
        arg1.attributes = arg9;
        arg1.background_color = 0x1::string::utf8(arg7);
        arg1.animation_urls = arg10;
    }

    public fun update_name(arg0: &AdminCap, arg1: &mut VS11, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.name = 0x1::string::utf8(arg2);
    }

    public fun update_thumbnail_url(arg0: &AdminCap, arg1: &mut VS11, arg2: 0x2::url::Url, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.thumbnail_url = arg2;
    }

    // decompiled from Move bytecode v6
}

