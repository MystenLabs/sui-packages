module 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::kiosk_integration {
    public(friend) fun purchase_character(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>, arg2: 0x2::object::ID, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) : 0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character {
        let (v0, v1) = 0x2::kiosk::purchase<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>(arg0, arg2, arg3);
        let v2 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>(arg1, &mut v2, 0x2::coin::split<0x2::sui::SUI>(arg4, 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::fee_amount<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>(arg1, 0x2::transfer_policy::paid<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>(&v2)), arg5));
        let (_, _, _) = 0x2::transfer_policy::confirm_request<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>(arg1, v2);
        v0
    }

    public(friend) fun withdraw_royalty(arg0: &0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::admin_cap::AdminCap, arg1: &mut 0x2::transfer_policy::TransferPolicy<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>, arg2: &0x2::transfer_policy::TransferPolicyCap<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>, arg3: 0x1::option::Option<u64>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<0x598baed5c29a54341edc662cdf51ffd703192060d615ff72af72bb4f2b23ca82::character_data::Character>(arg1, arg2, arg3, arg5), arg4);
    }

    // decompiled from Move bytecode v6
}

