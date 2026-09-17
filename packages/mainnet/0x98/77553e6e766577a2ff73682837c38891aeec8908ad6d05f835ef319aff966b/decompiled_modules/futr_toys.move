module 0x9877553e6e766577a2ff73682837c38891aeec8908ad6d05f835ef319aff966b::futr_toys {
    struct FUTR_TOYS has drop {
        dummy_field: bool,
    }

    struct PepetheFrog has store, key {
        id: 0x2::object::UID,
        issue: u64,
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

    public fun add_new_toy(arg0: &0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::RegistryCap, arg1: &mut 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::Registry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::add_new_toy<PepetheFrog>(arg1, arg0, 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::create(0x1::string::utf8(b"Pepe the Frog"), 1, 0x1::string::utf8(b"Coolest Frog in Web3"), 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/WRSgpLbwtn8x1XfJy6EwY-MOS8E6zDYIW8k18L75EIcBAQALAA"), 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/WRSgpLbwtn8x1XfJy6EwY-MOS8E6zDYIW8k18L75EIcBXgCSAg"), 0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/by-quilt-patch-id/WRSgpLbwtn8x1XfJy6EwY-MOS8E6zDYIW8k18L75EIcBCwBeAA"), 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3), 10000, 100));
    }

    public fun burn(arg0: PepetheFrog, arg1: &mut 0x2::tx_context::TxContext) {
        let PepetheFrog {
            id          : v0,
            issue       : _,
            token_id    : _,
            name        : _,
            description : _,
            image_url   : _,
            video_url   : _,
            media_url   : _,
            attributes  : _,
        } = arg0;
        0x2::object::delete(v0);
        let v9 = Burn{from: 0x2::tx_context::sender(arg1)};
        0x2::event::emit<Burn>(v9);
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
        let v2 = 0x1::string::utf8(b"Pepe the Frog");
        0x1::string::append_utf8(&mut v2, b" #{token_id}");
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, v2);
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://futr.toys/"));
        let (v5, v6) = 0x2::display_registry::new_with_publisher<PepetheFrog>(arg0, &mut arg1, arg2);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0;
        while (v9 < 4) {
            0x2::display_registry::set<PepetheFrog>(&mut v8, &v7, *0x1::vector::borrow<0x1::string::String>(&v0, v9), *0x1::vector::borrow<0x1::string::String>(&v3, v9));
            v9 = v9 + 1;
        };
        0x2::display_registry::share<PepetheFrog>(v8);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<PepetheFrog>>(v7, 0x2::tx_context::sender(arg2));
        0x2::package::burn_publisher(arg1);
    }

    public fun premint_toys(arg0: &0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::store::StoreCap, arg1: &mut 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::store::Store, arg2: &mut 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::Registry, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<PepetheFrog>();
        let v1 = 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::registry::borrow_toy<PepetheFrog>(arg2);
        let v2 = 1;
        while (v2 <= arg3) {
            let v3 = PepetheFrog{
                id          : 0x2::object::new(arg4),
                issue       : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::issue(v1),
                token_id    : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::total_supply(v1) + v2,
                name        : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::name(v1),
                description : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::description(v1),
                image_url   : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::image_url(v1),
                video_url   : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::video_url(v1),
                media_url   : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::media_url(v1),
                attributes  : 0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::toy::attributes(v1),
            };
            0x1::vector::push_back<PepetheFrog>(&mut v0, v3);
            v2 = v2 + 1;
        };
        0x5b1dc549bfcb09721baf6fa9ac539b6fcae1fbb76be61761bb1f44268789eedd::store::add_preminted<PepetheFrog>(arg1, arg0, arg2, v0);
        let v4 = Mint{quantity: arg3};
        0x2::event::emit<Mint>(v4);
    }

    // decompiled from Move bytecode v7
}

