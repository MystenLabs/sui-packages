module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::entry {
    struct ENTRY has drop {
        dummy_field: bool,
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::create_kiosk(arg0);
    }

    public entry fun delist_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::delist_character(arg0, arg1, arg2);
    }

    fun init(arg0: ENTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::init_and_transfer_admin_cap(arg1, v0);
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::game_data::init_game_data(arg1);
        let v1 = 0x2::package::claim<ENTRY>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(&v1, arg1);
        let v4 = v3;
        let v5 = v2;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(&mut v5, &v4, 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::royalty_bp(), 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::min_royalty_amount());
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>>(v4, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public entry fun list_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::list_character(arg0, arg1, arg2, arg3);
    }

    public entry fun lock_character_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg3: 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::place_and_lock_character(arg0, arg1, arg2, arg3);
    }

    public entry fun mint(arg0: &mut 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: vector<u8>, arg8: &mut 0x2::tx_context::TxContext) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::errors::assert_image_too_large(0x1::vector::length<u8>(&arg6) < 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::constants::max_image_size());
        0x2::transfer::public_transfer<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::new_character(0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::next_serial(arg0), 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::traits::new_base_traits(arg1, arg2, arg3), 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::marketplace::new_marketplace_data(arg4, arg5), arg6, arg7, arg8), 0x2::tx_context::sender(arg8));
    }

    public entry fun purchase_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::purchase_character(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun withdraw_profits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::withdraw_profits(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw_royalty(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration::withdraw_royalty(arg0, arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

