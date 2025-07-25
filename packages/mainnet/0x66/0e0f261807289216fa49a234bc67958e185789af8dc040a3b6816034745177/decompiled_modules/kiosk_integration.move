module 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::kiosk_integration {
    struct PolicyRegistry has key {
        id: 0x2::object::UID,
        transfer_policy_id: 0x2::object::ID,
        transfer_policy_cap_id: 0x2::object::ID,
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_policy_registry(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::AdminCap, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = PolicyRegistry{
            id                     : 0x2::object::new(arg3),
            transfer_policy_id     : arg1,
            transfer_policy_cap_id : arg2,
        };
        0x2::transfer::share_object<PolicyRegistry>(v0);
    }

    public entry fun delist_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID) {
        0x2::kiosk::delist<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg0, arg1, arg2);
    }

    public fun get_kiosk_balance(arg0: &0x2::kiosk::Kiosk) : u64 {
        0x2::kiosk::profits_amount(arg0)
    }

    public entry fun list_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64) {
        0x2::kiosk::list<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg0, arg1, arg2, arg3);
    }

    public fun place_and_lock_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg3: 0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character) {
        0x2::kiosk::lock<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg0, arg1, arg2, arg3);
    }

    public entry fun purchase_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::purchase<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg0, arg2, arg3);
        let v2 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg1, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg1, 0x2::transfer_policy::paid<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(&v2)), arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg1, v2);
        0x2::transfer::public_transfer<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun withdraw_profits(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::kiosk::withdraw(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_royalty(arg0: &0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::admin_cap::AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>, arg3: 0x1::option::Option<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0x660e0f261807289216fa49a234bc67958e185789af8dc040a3b6816034745177::character_data::Character>(arg1, arg2, arg3, arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

