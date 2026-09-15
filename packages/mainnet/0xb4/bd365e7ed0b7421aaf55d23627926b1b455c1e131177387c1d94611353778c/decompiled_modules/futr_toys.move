module 0xb4bd365e7ed0b7421aaf55d23627926b1b455c1e131177387c1d94611353778c::futr_toys {
    struct FUTR_TOYS has drop {
        dummy_field: bool,
    }

    struct TESTToy has store, key {
        id: 0x2::object::UID,
        token_id: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        video_url: 0x2::url::Url,
        media_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Mint has copy, drop, store {
        quantity: u64,
    }

    struct Burn has copy, drop, store {
        from: address,
    }

    public fun add_new_toy(arg0: &0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::RegistryCap, arg1: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::add_new_toy<TESTToy>(arg1, arg0, 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::create(0x1::string::utf8(b"TEST Toy"), 0x1::string::utf8(b"TEST Desc"), 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/dAYwnGnrDM9cw59w_nPZuLPGpAMii0ebSbO20wJhoDABAQALAA"), 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/dAYwnGnrDM9cw59w_nPZuLPGpAMii0ebSbO20wJhoDABXQCSAg"), 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/dAYwnGnrDM9cw59w_nPZuLPGpAMii0ebSbO20wJhoDABCwBdAA"), 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3), 50000, 10));
    }

    public fun burn(arg0: TESTToy, arg1: &mut 0x2::tx_context::TxContext) {
        let TESTToy {
            id          : v0,
            token_id    : _,
            name        : _,
            description : _,
            image_url   : _,
            video_url   : _,
            media_url   : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
        let v8 = Burn{from: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<Burn>(v8);
    }

    fun init(arg0: FUTR_TOYS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<FUTR_TOYS>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    public fun init_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: 0x2::package::Publisher, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::string::utf8(b"TEST Toy");
        0x1::string::append_utf8(&mut v2, b"#{token_id}");
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, v2);
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://futr.toys/"));
        let (v5, v6) = 0x2::display_registry::new_with_publisher<TESTToy>(arg0, &mut arg1, arg2);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0;
        while (v9 < 4) {
            0x2::display_registry::set<TESTToy>(&mut v8, &v7, *0x1::vector::borrow<0x1::string::String>(&v0, v9), *0x1::vector::borrow<0x1::string::String>(&v3, v9));
            v9 = v9 + 1;
        };
        0x2::display_registry::share<TESTToy>(v8);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<TESTToy>>(v7, 0x2::tx_context::sender(arg2));
        0x2::package::burn_publisher(arg1);
    }

    public fun premint_toys(arg0: &0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::store::StoreCap, arg1: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::store::Store, arg2: &mut 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<TESTToy>();
        let v1 = 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::registry::borrow_toy<TESTToy>(arg2);
        let v2 = 1;
        while (v2 <= arg3) {
            let v3 = TESTToy{
                id          : 0x2::object::new(arg4),
                token_id    : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::total_supply(v1) + v2,
                name        : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::name(v1),
                description : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::description(v1),
                image_url   : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::image_url(v1),
                video_url   : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::video_url(v1),
                media_url   : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::media_url(v1),
                attributes  : 0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::toy::attributes(v1),
            };
            0x1::vector::push_back<TESTToy>(&mut v0, v3);
            v2 = v2 + 1;
        };
        0x70243ba0c5b73ebb20ed89bad5f93a51fc070dfd7092e1cf174c5a5efea03c15::store::add_preminted<TESTToy>(arg1, arg0, arg2, v0);
        let v4 = Mint{quantity: arg3};
        0x2::event::emit<Mint>(v4);
    }

    // decompiled from Move bytecode v7
}

