module 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::suiball {
    struct SUIBALL has drop {
        dummy_field: bool,
    }

    struct Suiball has store, key {
        id: 0x2::object::UID,
        serial_number: u64,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        video_url: 0x1::string::String,
        creator: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct Mint has copy, drop {
        id: 0x2::object::ID,
        serial_number: u64,
    }

    public fun attributes(arg0: &Suiball) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun creator(arg0: &Suiball) : 0x1::string::String {
        arg0.creator
    }

    public fun description(arg0: &Suiball) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &Suiball) : 0x1::string::String {
        arg0.image_url
    }

    public fun video_url(arg0: &Suiball) : 0x1::string::String {
        arg0.video_url
    }

    public entry fun aidrop_to(arg0: &0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::RegisterAdminCap, arg1: &mut 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::Registry, arg2: &mut 0x2::transfer_policy::TransferPolicy<Suiball>, arg3: &mut 0x2::kiosk::Kiosk, arg4: vector<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        loop {
            if (v0 == 0x1::vector::length<address>(&arg4)) {
                break
            };
            let v1 = 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::get_minted(arg1, 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::airdrop(arg1));
            0x2::kiosk::list<Suiball>(arg3, 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::kiosk_cap(arg1), v1, 0);
            let (v2, v3) = 0x2::kiosk::purchase<Suiball>(arg3, v1, 0x2::coin::zero<0x2::sui::SUI>(arg5));
            let v4 = v3;
            let (v5, v6) = 0x2::kiosk::new(arg5);
            let v7 = v6;
            let v8 = v5;
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<Suiball>(arg2, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg5));
            0x2::kiosk::lock<Suiball>(&mut v8, &v7, arg2, v2);
            0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<Suiball>(&mut v4, &v8);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<Suiball>(arg2, v4);
            0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v8);
            0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v7, *0x1::vector::borrow<address>(&arg4, v0));
            v0 = v0 + 1;
        };
    }

    fun init(arg0: SUIBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIBALL>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<Suiball>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Suiball>(&mut v4, &v3, 700, 0);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Suiball>(&mut v4, &v3);
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"creator"));
        let v7 = 0x1::vector::empty<0x1::string::String>();
        let v8 = &mut v7;
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"Suiball #{serial_number}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"https://www.suiball.com/"));
        0x1::vector::push_back<0x1::string::String>(v8, 0x1::string::utf8(b"{creator}"));
        let v9 = 0x2::display::new_with_fields<Suiball>(&v0, v5, v7, arg1);
        0x2::display::update_version<Suiball>(&mut v9);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Suiball>>(v4);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Suiball>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Suiball>>(v9, 0x2::tx_context::sender(arg1));
    }

    fun mint_internal(arg0: &mut 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : Suiball {
        let v0 = 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::mint_data(arg0);
        let v1 = 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::total_supply(arg0);
        let v2 = Suiball{
            id            : 0x2::object::new(arg1),
            serial_number : v1,
            description   : 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::description(v0),
            image_url     : 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::image_url(v0),
            video_url     : 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::video_url(v0),
            creator       : 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::creator(v0),
            attributes    : 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::attributes(v0),
        };
        let v3 = Mint{
            id            : 0x2::object::id<Suiball>(&v2),
            serial_number : v1,
        };
        0x2::event::emit<Mint>(v3);
        v2
    }

    public entry fun premint_to_kiosk(arg0: &0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::RegisterAdminCap, arg1: &mut 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::Registry, arg2: &0x2::transfer_policy::TransferPolicy<Suiball>, arg3: &mut 0x2::kiosk::Kiosk, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::total_supply(arg1) + arg4 <= 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::collection_max_supply(arg1), 13906834560890568707);
        let v0 = 0;
        loop {
            if (v0 == arg4) {
                break
            };
            let v1 = mint_internal(arg1, arg5);
            0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::add_minted(arg1, v1.serial_number, *0x2::object::uid_as_inner(&v1.id));
            0x2::kiosk::lock<Suiball>(arg3, 0x5fc89b202831a55ab762b47f700c21215522741f030023154df7a3600857509c::registry::kiosk_cap(arg1), arg2, v1);
            v0 = v0 + 1;
        };
    }

    public fun serial_number(arg0: &Suiball) : u64 {
        arg0.serial_number
    }

    // decompiled from Move bytecode v6
}

