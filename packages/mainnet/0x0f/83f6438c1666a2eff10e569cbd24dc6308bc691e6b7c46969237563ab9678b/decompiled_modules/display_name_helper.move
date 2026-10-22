module 0xf83f6438c1666a2eff10e569cbd24dc6308bc691e6b7c46969237563ab9678b::display_name_helper {
    public fun update_name_with_edition(arg0: &mut 0x2::display_registry::Display<0x301c28202b1f06275532edece81e2fe638d9ddd8233bcfc5684975fbcf643fc0::medic::MedicWithTraits>, arg1: &0x2::display_registry::DisplayCap<0x301c28202b1f06275532edece81e2fe638d9ddd8233bcfc5684975fbcf643fc0::medic::MedicWithTraits>) {
        assert!(0x2::display_registry::cap_id<0x301c28202b1f06275532edece81e2fe638d9ddd8233bcfc5684975fbcf643fc0::medic::MedicWithTraits>(arg0) == 0x1::option::some<0x2::object::ID>(0x2::object::id<0x2::display_registry::DisplayCap<0x301c28202b1f06275532edece81e2fe638d9ddd8233bcfc5684975fbcf643fc0::medic::MedicWithTraits>>(arg1)), 0);
        0x2::display_registry::set<0x301c28202b1f06275532edece81e2fe638d9ddd8233bcfc5684975fbcf643fc0::medic::MedicWithTraits>(arg0, arg1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{edition}"));
    }

    // decompiled from Move bytecode v7
}

