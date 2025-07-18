module 0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::transfer_helper {
    public fun can_transfer_bidirectionally(arg0: &0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::KioskRegistry, arg1: address, arg2: address) : (bool, bool) {
        (0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::has_registered_kiosk(arg0, arg1), 0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::has_registered_kiosk(arg0, arg2))
    }

    public fun get_registry_stats(arg0: &0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::KioskRegistry) : u64 {
        0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::get_total_kiosks(arg0)
    }

    public fun get_transfer_instructions(arg0: &0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::KioskRegistry, arg1: address) : (bool, 0x1::option::Option<0x2::object::ID>) {
        let v0 = 0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::has_registered_kiosk(arg0, arg1);
        let v1 = if (v0) {
            0x7fb5d28e8701952bb524db05b78a0f92085b6d94cec141bf4507b106e3f39cf1::kiosk_registry::get_user_kiosk(arg0, arg1)
        } else {
            0x1::option::none<0x2::object::ID>()
        };
        (v0, v1)
    }

    public fun validate_transfer_params(arg0: &vector<0x2::object::ID>, arg1: u64) : bool {
        0x1::vector::length<0x2::object::ID>(arg0) == arg1 && 0x1::vector::length<0x2::object::ID>(arg0) > 0
    }

    // decompiled from Move bytecode v6
}

