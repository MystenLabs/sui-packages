module 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::wait {
    struct WAIT has drop {
        dummy_field: bool,
    }

    struct WaitCard has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        warlot: 0x2::url::Url,
    }

    struct CloneWaitCard<phantom T0> has store, key {
        id: 0x2::object::UID,
        admin_slot: u8,
        entry: 0x1::option::Option<WaitCard>,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct WaitCardAdded has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        receiver: address,
        name: 0x1::string::String,
    }

    public fun add_display(arg0: &mut AdminCap, arg1: &mut 0x2::display::Display<WaitCard>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::add<WaitCard>(arg1, arg2, arg3);
    }

    public fun add_multiple_display(arg0: &mut AdminCap, arg1: &mut 0x2::display::Display<WaitCard>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>) {
        0x2::display::add_multiple<WaitCard>(arg1, arg2, arg3);
    }

    public fun borrow_contribution(arg0: &WaitCard) : &0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::WarlotData {
        0x2::dynamic_field::borrow<vector<u8>, 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::WarlotData>(&arg0.id, b"WARLOT CONTRIBUTIONS")
    }

    public fun borrow_contribution_mut(arg0: &mut AdminCap, arg1: &mut WaitCard) : &mut 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::WarlotData {
        0x2::dynamic_field::borrow_mut<vector<u8>, 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::WarlotData>(&mut arg1.id, b"WARLOT CONTRIBUTIONS")
    }

    public fun burn(arg0: WaitCard) {
        let WaitCard {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            warlot      : _,
        } = arg0;
        let v5 = v0;
        let v6 = &mut v5;
        destroy_dfield(v6);
        0x2::object::delete(v5);
    }

    public fun burn_admin(arg0: AdminCap, arg1: &mut CloneWaitCard<WAIT>) {
        if (4 - arg1.admin_slot == 1) {
            assert!(0x1::option::is_none<WaitCard>(&arg1.entry), 13906835123531612168);
        };
        let AdminCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        arg1.admin_slot = arg1.admin_slot + 1;
    }

    public fun create_mod(arg0: &mut AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : WaitCard {
        WaitCard{
            id          : 0x2::object::new(arg5),
            name        : arg1,
            description : arg2,
            image_url   : 0x1::string::utf8(arg3),
            warlot      : 0x2::url::new_unsafe_from_bytes(arg4),
        }
    }

    public fun description(arg0: &WaitCard) : &0x1::string::String {
        &arg0.description
    }

    fun destroy_dfield(arg0: &mut 0x2::object::UID) {
        let v0 = 0x2::dynamic_field::exists_<vector<u8>>(arg0, b"WARLOT CONTRIBUTIONS");
        if (v0 == true) {
            0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::destroy(0x2::dynamic_field::remove<vector<u8>, 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::WarlotData>(arg0, b"WARLOT CONTRIBUTIONS"));
        };
    }

    public fun edit_display(arg0: &mut AdminCap, arg1: &mut 0x2::display::Display<WaitCard>, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::display::edit<WaitCard>(arg1, arg2, arg3);
    }

    public fun image_url(arg0: &WaitCard) : &0x1::string::String {
        &arg0.image_url
    }

    fun init(arg0: WAIT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<WAIT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"media_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The Warlot Call"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"The genesis piece of the Warlot ecosystem. This NFT embodies the rallying cry that unites builders, creators, and visionaries to join the on-chain movement. The warthog, a symbol of resilience and grit, wears the call proudly across its shades: JOIN US. The patterned circles reflect fragments of on-chain storage coming together; a reminder of how Warlot unites diverse data and use cases into one ecosystem. Owning 'The Warlot Call' marks you as one of the first to answer; a pioneer in shaping the future of transparent, persistent, and community-driven storage."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://waitlist.warlot.xyz/warlot,%20image.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://waitlist.warlot.xyz/warlot,%20image.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://waitlist.warlot.xyz/warlot,%20image.png"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://www.warlot.xyz"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"WARLOT TEAM"));
        let v5 = 0x2::display::new_with_fields<WaitCard>(&v0, v1, v3, arg1);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = WaitCard{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"The Warlot Call"),
            description : 0x1::string::utf8(b"With shades that speak louder than words, The Warlot Call welcomes you to Warlot ecosystem."),
            image_url   : 0x1::string::utf8(b"https://waitlist.warlot.xyz/warlot,%20image.png"),
            warlot      : 0x2::url::new_unsafe_from_bytes(b"https://www.warlot.xyz"),
        };
        let v8 = CloneWaitCard<WAIT>{
            id         : 0x2::object::new(arg1),
            admin_slot : 4 - 1,
            entry      : 0x1::option::some<WaitCard>(v7),
        };
        0x2::display::update_version<WaitCard>(&mut v5);
        let v9 = &mut v6;
        mint_to_request(v9, &v8, @0x43a388f2849fecfc38e57cc0928b71d90067dece08564c1215c12d712489d7a, arg1);
        0x2::transfer::public_share_object<CloneWaitCard<WAIT>>(v8);
        0x2::transfer::transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WaitCard>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    fun mint(arg0: &CloneWaitCard<WAIT>, arg1: &mut 0x2::tx_context::TxContext) : WaitCard {
        assert!(0x1::option::is_some<WaitCard>(&arg0.entry), 13906835557323046916);
        let v0 = 0x1::option::borrow<WaitCard>(&arg0.entry);
        let v1 = WaitCard{
            id          : 0x2::object::new(arg1),
            name        : v0.name,
            description : v0.description,
            image_url   : v0.image_url,
            warlot      : v0.warlot,
        };
        0x2::dynamic_field::add<vector<u8>, 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::WarlotData>(&mut v1.id, b"WARLOT CONTRIBUTIONS", 0x1695d99ed838294261c7728557d43a45e106d79e1ddea72177ed3c74ada65b11::contribution::create());
        v1
    }

    public fun mint_admin(arg0: &mut AdminCap, arg1: &mut CloneWaitCard<WAIT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin_slot > 0, 13906835029042200582);
        let v0 = AdminCap{id: 0x2::object::new(arg3)};
        0x2::transfer::transfer<AdminCap>(v0, arg2);
        arg1.admin_slot = arg1.admin_slot - 1;
    }

    public fun mint_to_request(arg0: &mut AdminCap, arg1: &CloneWaitCard<WAIT>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, arg2), 13906835634632982540);
        let v0 = mint(arg1, arg3);
        let v1 = WaitCardAdded{
            object_id : 0x2::object::id<WaitCard>(&v0),
            creator   : 0x2::tx_context::sender(arg3),
            receiver  : arg2,
            name      : v0.name,
        };
        0x2::event::emit<WaitCardAdded>(v1);
        0x2::transfer::transfer<WaitCard>(v0, arg2);
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, arg2, true);
    }

    public fun mint_to_sender(arg0: &mut CloneWaitCard<WAIT>, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::dynamic_field::exists_<address>(&arg0.id, 0x2::tx_context::sender(arg1)), 13906835729122131978);
        let v0 = mint(arg0, arg1);
        let v1 = WaitCardAdded{
            object_id : 0x2::object::id<WaitCard>(&v0),
            creator   : 0x2::tx_context::sender(arg1),
            receiver  : 0x2::tx_context::sender(arg1),
            name      : v0.name,
        };
        0x2::event::emit<WaitCardAdded>(v1);
        0x2::transfer::transfer<WaitCard>(v0, 0x2::tx_context::sender(arg1));
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, 0x2::tx_context::sender(arg1), true);
    }

    public fun modify_clone(arg0: &mut AdminCap, arg1: &mut CloneWaitCard<WAIT>, arg2: WaitCard, arg3: vector<u8>) {
        let v0 = 0x1::option::is_some<WaitCard>(&arg1.entry);
        if (v0 == true) {
            burn(0x1::option::swap<WaitCard>(&mut arg1.entry, arg2));
        } else {
            0x1::option::fill<WaitCard>(&mut arg1.entry, arg2);
        };
        let v1 = 0x1::option::borrow_mut<WaitCard>(&mut arg1.entry);
        v1.warlot = 0x2::url::new_unsafe_from_bytes(arg3);
        let v2 = &mut v1.id;
        destroy_dfield(v2);
    }

    public fun name(arg0: &WaitCard) : &0x1::string::String {
        &arg0.name
    }

    public fun remove_display(arg0: &mut AdminCap, arg1: &mut 0x2::display::Display<WaitCard>, arg2: 0x1::string::String) {
        0x2::display::remove<WaitCard>(arg1, arg2);
    }

    public fun suspend_clone(arg0: &mut AdminCap, arg1: &mut CloneWaitCard<WAIT>) {
        assert!(0x1::option::is_some<WaitCard>(&arg1.entry), 13906835527258144770);
        burn(0x1::option::extract<WaitCard>(&mut arg1.entry));
    }

    public fun warlot(arg0: &WaitCard) : &0x2::url::Url {
        &arg0.warlot
    }

    // decompiled from Move bytecode v6
}

