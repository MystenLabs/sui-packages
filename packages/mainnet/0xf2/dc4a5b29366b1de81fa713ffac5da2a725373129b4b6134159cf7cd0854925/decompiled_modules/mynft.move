module 0xf2dc4a5b29366b1de81fa713ffac5da2a725373129b4b6134159cf7cd0854925::mynft {
    struct MYNFT has drop {
        dummy_field: bool,
    }

    struct Tnft has store, key {
        id: 0x2::object::UID,
        motto: 0x1::string::String,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    fun init(arg0: MYNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MYNFT>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Tnft>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0xf2dc4a5b29366b1de81fa713ffac5da2a725373129b4b6134159cf7cd0854925::kiosk_lock_rule::add<Tnft>(&mut v4, &v3);
        0xf2dc4a5b29366b1de81fa713ffac5da2a725373129b4b6134159cf7cd0854925::royalty_rule::add<Tnft>(&mut v4, &v3, 500, 0);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"thumbnail_url"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://www.outrageousmottos.art/test1.html"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Tnft Creator"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        let v9 = 0x2::display::new_with_fields<Tnft>(&v0, v5, v7, arg1);
        0x2::display::update_version<Tnft>(&mut v9);
        0x2::transfer::public_transfer<0x2::display::Display<Tnft>>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Tnft>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v10 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"series"), 0x1::string::utf8(b"1"));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v10, 0x1::string::utf8(b"motto"), 0x1::string::utf8(b"Testing testing one."));
        let v11 = Tnft{
            id          : 0x2::object::new(arg1),
            motto       : 0x1::string::utf8(b"Testing testing one."),
            name        : 0x1::string::utf8(b"test mynft"),
            image_url   : 0x2::url::new_unsafe_from_bytes(0x1::string::into_bytes(0x1::string::utf8(b"https://gray-determined-landfowl-131.mypinata.cloud/ipfs/QmSYor8dXe2HjwZKkVQhAcD2VkGAXyBdGX264uTMsUji3i"))),
            description : 0x1::string::utf8(b"test mynft series 1 game nft"),
            attributes  : v10,
        };
        let (v12, v13) = 0x2::kiosk::new(arg1);
        let v14 = v13;
        let v15 = v12;
        0x2::kiosk::lock<Tnft>(&mut v15, &v14, &v4, v11);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v15);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Tnft>>(v4);
    }

    // decompiled from Move bytecode v6
}

