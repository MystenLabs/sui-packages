module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes {
    public(friend) fun accessory() : 0x1::string::String {
        0x1::string::utf8(b"Accessory")
    }

    public(friend) fun accessory_bytes() : vector<u8> {
        b"Accessory"
    }

    public(friend) fun assert_is_valid_cosmetic(arg0: &0x1::string::String) {
        let v0 = cosmetic_types();
        assert!(0x1::vector::contains<0x1::string::String>(&v0, arg0), 0);
    }

    public(friend) fun assert_is_valid_weapon(arg0: &0x1::string::String) {
        let v0 = weapon_types();
        assert!(0x1::vector::contains<0x1::string::String>(&v0, arg0), 0);
    }

    public(friend) fun backpiece() : 0x1::string::String {
        0x1::string::utf8(b"Backpiece")
    }

    public(friend) fun backpiece_bytes() : vector<u8> {
        b"Backpiece"
    }

    public(friend) fun belt() : 0x1::string::String {
        0x1::string::utf8(b"Belt")
    }

    public(friend) fun belt_bytes() : vector<u8> {
        b"Belt"
    }

    public(friend) fun boots() : 0x1::string::String {
        0x1::string::utf8(b"Boots")
    }

    public(friend) fun boots_bytes() : vector<u8> {
        b"Boots"
    }

    public(friend) fun chestpiece() : 0x1::string::String {
        0x1::string::utf8(b"Chestpiece")
    }

    public(friend) fun chestpiece_bytes() : vector<u8> {
        b"Chestpiece"
    }

    public(friend) fun cosmetic_types() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Helm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Upper Torso"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Chestpiece"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Backpiece"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Arm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Arm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Bracer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Bracer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Glove"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Glove"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Pauldron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Pauldron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Legs"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Belt"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Accessory"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Shins"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Boots"));
        v0
    }

    public(friend) fun genesis_mint_types() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Helm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Upper Torso"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Chestpiece"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Arm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Arm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Bracer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Bracer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Glove"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Glove"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Pauldron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Pauldron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Legs"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Shins"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Boots"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Belt"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Primary"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Secondary"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Tertiary"));
        v0
    }

    public(friend) fun helm() : 0x1::string::String {
        0x1::string::utf8(b"Helm")
    }

    public(friend) fun helm_bytes() : vector<u8> {
        b"Helm"
    }

    public(friend) fun left_arm() : 0x1::string::String {
        0x1::string::utf8(b"Left Arm")
    }

    public(friend) fun left_arm_bytes() : vector<u8> {
        b"Left Arm"
    }

    public(friend) fun left_bracer() : 0x1::string::String {
        0x1::string::utf8(b"Left Bracer")
    }

    public(friend) fun left_bracer_bytes() : vector<u8> {
        b"Left Bracer"
    }

    public(friend) fun left_glove() : 0x1::string::String {
        0x1::string::utf8(b"Left Glove")
    }

    public(friend) fun left_glove_bytes() : vector<u8> {
        b"Left Glove"
    }

    public(friend) fun left_pauldron() : 0x1::string::String {
        0x1::string::utf8(b"Left Pauldron")
    }

    public(friend) fun left_pauldron_bytes() : vector<u8> {
        b"Left Pauldron"
    }

    public(friend) fun legs() : 0x1::string::String {
        0x1::string::utf8(b"Legs")
    }

    public(friend) fun legs_bytes() : vector<u8> {
        b"Legs"
    }

    public(friend) fun make_formatted_type(arg0: 0x1::string::String) : 0x1::string::String {
        if (arg0 == 0x1::string::utf8(b"Left Arm")) {
            return 0x1::string::utf8(b"Arm (L)")
        };
        if (arg0 == 0x1::string::utf8(b"Right Arm")) {
            return 0x1::string::utf8(b"Arm (R)")
        };
        if (arg0 == 0x1::string::utf8(b"Left Bracer")) {
            return 0x1::string::utf8(b"Bracer (L)")
        };
        if (arg0 == 0x1::string::utf8(b"Right Bracer")) {
            return 0x1::string::utf8(b"Bracer (R)")
        };
        if (arg0 == 0x1::string::utf8(b"Left Glove")) {
            return 0x1::string::utf8(b"Glove (L)")
        };
        if (arg0 == 0x1::string::utf8(b"Right Glove")) {
            return 0x1::string::utf8(b"Glove (R)")
        };
        if (arg0 == 0x1::string::utf8(b"Left Pauldron")) {
            return 0x1::string::utf8(b"Pauldron (L)")
        };
        if (arg0 == 0x1::string::utf8(b"Right Pauldron")) {
            return 0x1::string::utf8(b"Pauldron (R)")
        };
        arg0
    }

    public(friend) fun new() : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        let v2 = cosmetic_types();
        while (0x1::vector::length<0x1::string::String>(&v2) > v1) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&v2, v1), 0x1::string::utf8(b""));
            v1 = v1 + 1;
        };
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, primary(), 0x1::string::utf8(b""));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, secondary(), 0x1::string::utf8(b""));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, tertiary(), 0x1::string::utf8(b""));
        v0
    }

    public(friend) fun new_hashes() : 0x2::vec_map::VecMap<0x1::string::String, vector<u8>> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, vector<u8>>();
        let v1 = 0;
        let v2 = cosmetic_types();
        while (0x1::vector::length<0x1::string::String>(&v2) > v1) {
            0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&v2, v1), b"");
            v1 = v1 + 1;
        };
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v0, primary(), b"");
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v0, secondary(), b"");
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut v0, tertiary(), b"");
        v0
    }

    public(friend) fun primary() : 0x1::string::String {
        0x1::string::utf8(b"Primary")
    }

    public(friend) fun primary_bytes() : vector<u8> {
        b"Primary"
    }

    public(friend) fun right_arm() : 0x1::string::String {
        0x1::string::utf8(b"Right Arm")
    }

    public(friend) fun right_arm_bytes() : vector<u8> {
        b"Right Arm"
    }

    public(friend) fun right_bracer() : 0x1::string::String {
        0x1::string::utf8(b"Right Bracer")
    }

    public(friend) fun right_bracer_bytes() : vector<u8> {
        b"Right Bracer"
    }

    public(friend) fun right_glove() : 0x1::string::String {
        0x1::string::utf8(b"Right Glove")
    }

    public(friend) fun right_glove_bytes() : vector<u8> {
        b"Right Glove"
    }

    public(friend) fun right_pauldron() : 0x1::string::String {
        0x1::string::utf8(b"Right Pauldron")
    }

    public(friend) fun right_pauldron_bytes() : vector<u8> {
        b"Right Pauldron"
    }

    public(friend) fun secondary() : 0x1::string::String {
        0x1::string::utf8(b"Secondary")
    }

    public(friend) fun secondary_bytes() : vector<u8> {
        b"Secondary"
    }

    public(friend) fun shins() : 0x1::string::String {
        0x1::string::utf8(b"Shins")
    }

    public(friend) fun shins_bytes() : vector<u8> {
        b"Shins"
    }

    public(friend) fun tertiary() : 0x1::string::String {
        0x1::string::utf8(b"Tertiary")
    }

    public(friend) fun tertiary_bytes() : vector<u8> {
        b"Tertiary"
    }

    public(friend) fun types() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Helm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Upper Torso"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Chestpiece"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Backpiece"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Arm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Arm"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Bracer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Bracer"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Glove"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Glove"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Left Pauldron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Right Pauldron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Legs"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Belt"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Accessory"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Shins"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Boots"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Primary"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Secondary"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Tertiary"));
        v0
    }

    public(friend) fun upper_torso() : 0x1::string::String {
        0x1::string::utf8(b"Upper Torso")
    }

    public(friend) fun upper_torso_bytes() : vector<u8> {
        b"Upper Torso"
    }

    public(friend) fun weapon_types() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Primary"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Secondary"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Tertiary"));
        v0
    }

    // decompiled from Move bytecode v6
}

