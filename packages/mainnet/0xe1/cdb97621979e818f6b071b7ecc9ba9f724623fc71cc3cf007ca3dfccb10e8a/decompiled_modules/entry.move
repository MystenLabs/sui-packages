module 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::entry {
    struct ENTRY has drop {
        dummy_field: bool,
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::create_kiosk(arg0);
    }

    public entry fun delist_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::delist_character(arg0, arg1, arg2);
    }

    fun init(arg0: ENTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::init_and_transfer_admin_cap(arg1, v0);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::init_game_data(arg1);
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::render_config::init_render_config(arg1);
        let v1 = 0x2::package::claim<ENTRY>(arg0, arg1);
        let v2 = 0x2::display::new<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&v1, arg1);
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{character_name}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"background"), 0x1::string::utf8(b"{attributes.background}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"body"), 0x1::string::utf8(b"{attributes.body}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"head"), 0x1::string::utf8(b"{attributes.head}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"serial_number"), 0x1::string::utf8(b"{attributes.serial_number}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"{attributes.collection}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"faction"), 0x1::string::utf8(b"{attributes.faction}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"equipped_hat"), 0x1::string::utf8(b"{attributes.equipped_hat}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"equipped_shirt"), 0x1::string::utf8(b"{attributes.equipped_shirt}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"equipped_pants"), 0x1::string::utf8(b"{attributes.equipped_pants}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"equipped_accessory"), 0x1::string::utf8(b"{attributes.equipped_accessory}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"total_raids"), 0x1::string::utf8(b"{attributes.total_raids}"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://megawavesmakers.com"));
        0x2::display::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Jungle Labs"));
        0x2::display::update_version<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v6, &v5, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::royalty_bp(), 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::min_royalty_amount());
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(&mut v6, &v5);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>>(v6);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>>(v5, v0);
        0x2::transfer::public_transfer<0x2::display::Display<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public entry fun join_faction(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character, arg1: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::GameData, arg2: u64) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::faction_selection::set_faction(arg0, arg1, arg2);
    }

    public entry fun list_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::list_character(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_character_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>, arg3: 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::place_and_lock_character(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::AdminCap, arg1: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::game_data::GameData, arg2: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::render_config::RenderConfig, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::new_character(0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::next_serial(arg0), arg6, 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::traits::new_base_traits(arg3, arg4, arg5), 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::marketplace::new_marketplace_data(arg6), arg2, arg1, arg7), 0x2::tx_context::sender(arg7));
    }

    public entry fun purchase_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::purchase_character(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun set_character_image(arg0: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character, arg1: vector<u8>) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::errors::assert_image_too_large(0x1::vector::length<u8>(&arg1) < 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::constants::max_image_size());
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::set_image_bytes(arg0, arg1);
    }

    public entry fun update_render_config(arg0: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::AdminCap, arg1: &mut 0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::render_config::RenderConfig, arg2: vector<u8>, arg3: 0x1::string::String) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::render_config::update_render_config(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_profits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::withdraw_profits(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_royalty(arg0: &0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::admin_cap::AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::character_data::Character>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0xe1cdb97621979e818f6b071b7ecc9ba9f724623fc71cc3cf007ca3dfccb10e8a::kiosk_integration::withdraw_royalty(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

