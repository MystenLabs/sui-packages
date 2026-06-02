module 0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::distributor {
    struct DISTRIBUTOR has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        serial: u64,
        is_og: bool,
    }

    struct DistributorCap has key {
        id: 0x2::object::UID,
        next_serial: u64,
        next_egg_image_serial: u64,
        next_og_egg_image_serial: u64,
    }

    fun display_fields() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"attributes"));
        v0
    }

    fun image_template(arg0: 0x1::string::String) : 0x1::string::String {
        0x1::string::append(&mut arg0, 0x1::string::utf8(b"{image_stem}_{image_serial}.jpg"));
        arg0
    }

    fun init(arg0: DISTRIBUTOR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<DISTRIBUTOR>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{base_name} #{serial}"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v2, image_template(0x1::string::utf8(b"https://spimage.s3.ap-northeast-1.amazonaws.com/nft/")));
        0x1::vector::push_back<0x1::string::String>(v2, image_template(0x1::string::utf8(b"https://spimage.s3.ap-northeast-1.amazonaws.com/nft/")));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"{attributes}"));
        let v3 = 0x2::display::new_with_fields<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(&v0, display_fields(), v1, arg1);
        0x2::display::update_version<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(&mut v3);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>>(v3, 0x2::tx_context::sender(arg1));
        let v4 = DistributorCap{
            id                       : 0x2::object::new(arg1),
            next_serial              : 1,
            next_egg_image_serial    : 1,
            next_og_egg_image_serial : 1,
        };
        0x2::transfer::transfer<DistributorCap>(v4, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &mut DistributorCap, arg1: address, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: bool, arg7: vector<0x1::string::String>, arg8: vector<0x1::string::String>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        let v0 = 0;
        while (v0 < arg2) {
            let v1 = arg0.next_serial;
            let v2 = next_image_serial(arg0, arg6);
            arg0.next_serial = arg0.next_serial + 1;
            let v3 = 0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::new_egg(arg3, arg4, arg5, v2, v1, arg6, 0x1::option::some<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::attributes::Attributes>(0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::attributes::admin_new(arg7, arg8, arg9)), arg9);
            let v4 = NFTMinted{
                nft_id    : 0x2::object::id<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(&v3),
                recipient : arg1,
                serial    : v1,
                is_og     : arg6,
            };
            0x2::event::emit<NFTMinted>(v4);
            0x2::transfer::public_transfer<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(v3, arg1);
            v0 = v0 + 1;
        };
    }

    entry fun mint_egg(arg0: &mut DistributorCap, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, 0x1::string::utf8(b"Jackson Sharkz Egg"), 0x1::string::utf8(b"A mysterious egg within the Jackson.io ecosystem. Holders will unlock future rewards, exclusive perks, and upcoming Sharkz evolutions."), 0x1::string::utf8(b"egg"), false, arg3, arg4, arg5);
    }

    entry fun mint_og_egg(arg0: &mut DistributorCap, arg1: address, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2, 0x1::string::utf8(b"OG Jackson Sharkz Egg"), 0x1::string::utf8(b"A limited egg reserved for original Jackson Sharkz supporters. Unlock exclusive OG rewards, special status, and future ecosystem benefits."), 0x1::string::utf8(b"og_egg"), true, arg3, arg4, arg5);
    }

    fun next_image_serial(arg0: &mut DistributorCap, arg1: bool) : u64 {
        if (arg1) {
            arg0.next_og_egg_image_serial = arg0.next_og_egg_image_serial + 1;
            arg0.next_og_egg_image_serial
        } else {
            arg0.next_egg_image_serial = arg0.next_egg_image_serial + 1;
            arg0.next_egg_image_serial
        }
    }

    entry fun set_image_prefix(arg0: &DistributorCap, arg1: &mut 0x2::display::Display<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>, arg2: 0x1::string::String) {
        let v0 = image_template(arg2);
        0x2::display::edit<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(arg1, 0x1::string::utf8(b"image"), v0);
        0x2::display::edit<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(arg1, 0x1::string::utf8(b"image_url"), v0);
        0x2::display::update_version<0x1808f89344c8372ab484168a90f9316e3646c16fbcfbb16e54c0a708d6ac28fa::jackson_sharkz::JacksonSharkzEgg>(arg1);
    }

    // decompiled from Move bytecode v7
}

