module 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin {
    public fun new_admin(arg0: &mut 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &mut 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg2: &mut 0x2::tx_context::TxContext) : 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin {
        let v0 = 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::new_admin(arg0, arg2);
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(arg1, arg0, b"ACCOLADES_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v0));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(arg1, arg0, b"REPUTATION_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v0));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(arg1, arg0, b"UPGRADES_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v0));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(arg1, arg0, b"GENESIS_MINTER_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v0));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(arg1, arg0, b"PROFILE_PICTURES_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v0));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(arg1, arg0, b"AVATAR_SETTINGS_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v0));
        v0
    }

    public fun assert_accolades_role(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin) {
        assert!(0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::has_role(arg1, arg0, b"ACCOLADES_ROLE"), 0);
    }

    public fun assert_avatar_settings_role(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin) {
        assert!(0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::has_role(arg1, arg0, b"AVATAR_SETTINGS_ROLE"), 0);
    }

    public fun assert_genesis_minter_role(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin) {
        assert!(0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::has_role(arg1, arg0, b"GENESIS_MINTER_ROLE"), 0);
    }

    public fun assert_profile_pictures_role(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin) {
        assert!(0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::has_role(arg1, arg0, b"PROFILE_PICTURES_ROLE"), 0);
    }

    public fun assert_reputation_role(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin) {
        assert!(0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::has_role(arg1, arg0, b"REPUTATION_ROLE"), 0);
    }

    public fun assert_upgrades_role(arg0: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin) {
        assert!(0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::has_role(arg1, arg0, b"UPGRADES_ROLE"), 0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::new(arg0);
        let v2 = v1;
        let v3 = v0;
        let v4 = 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::new_admin(&v3, arg0);
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::add(&v2, &mut v3, b"ACCOLADES_ROLE");
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::add(&v2, &mut v3, b"REPUTATION_ROLE");
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::add(&v2, &mut v3, b"UPGRADES_ROLE");
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::add(&v2, &mut v3, b"GENESIS_MINTER_ROLE");
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::add(&v2, &mut v3, b"PROFILE_PICTURES_ROLE");
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::add(&v2, &mut v3, b"AVATAR_SETTINGS_ROLE");
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(&v2, &mut v3, b"ACCOLADES_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v4));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(&v2, &mut v3, b"REPUTATION_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v4));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(&v2, &mut v3, b"UPGRADES_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v4));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(&v2, &mut v3, b"GENESIS_MINTER_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v4));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(&v2, &mut v3, b"PROFILE_PICTURES_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v4));
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::grant(&v2, &mut v3, b"AVATAR_SETTINGS_ROLE", 0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::addy(&v4));
        0x2::transfer::public_share_object<0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl>(v3);
        0x2::transfer::public_transfer<0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin>(v4, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

