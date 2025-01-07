module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::avatar {
    struct AVATAR has drop {
        dummy_field: bool,
    }

    struct CosmeticKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct WeaponKey has copy, drop, store {
        pos0: 0x1::string::String,
    }

    struct Avatar has store, key {
        id: 0x2::object::UID,
        image_url: 0x1::string::String,
        avatar_model: 0x1::string::String,
        avatar_texture: 0x1::string::String,
        edition: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        attributes_hash: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
        misc: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AvatarSettings has key {
        id: 0x2::object::UID,
        edition: 0x1::string::String,
        image_url: 0x1::string::String,
        avatar_model: 0x1::string::String,
        avatar_texture: 0x1::string::String,
        active: bool,
    }

    public fun new(arg0: &AvatarSettings, arg1: &mut 0x2::tx_context::TxContext) : Avatar {
        assert!(arg0.active, 5);
        Avatar{
            id              : 0x2::object::new(arg1),
            image_url       : arg0.image_url,
            avatar_model    : arg0.avatar_model,
            avatar_texture  : arg0.avatar_texture,
            edition         : arg0.edition,
            attributes      : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::new(),
            attributes_hash : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::new_hashes(),
            misc            : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public(friend) fun attributes(arg0: &Avatar) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public(friend) fun avatar_model(arg0: &Avatar) : 0x1::string::String {
        arg0.avatar_model
    }

    public(friend) fun avatar_texture(arg0: &Avatar) : 0x1::string::String {
        arg0.avatar_texture
    }

    public(friend) fun edition(arg0: &Avatar) : 0x1::string::String {
        arg0.edition
    }

    public fun equip_cosmetic(arg0: &mut Avatar, arg1: &0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures::ProfilePictures, arg2: 0x2::object::ID, arg3: 0x1::string::String, arg4: &mut 0x2::kiosk::Kiosk, arg5: &0x2::kiosk::KioskOwnerCap, arg6: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = CosmeticKey{pos0: arg3};
        let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::equip<CosmeticKey>(&mut arg0.id, v0, arg2, arg4, arg5, arg6, arg7);
        assert!(arg3 == v2, 4);
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg3) = v1;
        *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.attributes_hash, &arg3) = v3;
        if (arg3 == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm() || arg3 == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::upper_torso() || arg3 == 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece()) {
            update_image(arg0, arg1);
        };
    }

    public(friend) fun equip_minted_cosmetic(arg0: &mut Avatar, arg1: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::type_(&arg1)};
        assert!(!0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0), 2);
        let v1 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::type_(&arg1);
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v1) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::name(&arg1);
        let v2 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::type_(&arg1);
        *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.attributes_hash, &v2) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::hash(&arg1);
        let v3 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::type_(&arg1)};
        0x2::dynamic_object_field::add<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v3, arg1);
    }

    public(friend) fun equip_minted_weapon(arg0: &mut Avatar, arg1: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon) {
        let v0 = WeaponKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::slot(&arg1)};
        assert!(!0x2::dynamic_object_field::exists_<WeaponKey>(&arg0.id, v0), 1);
        let v1 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::slot(&arg1);
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v1) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::name(&arg1);
        let v2 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::slot(&arg1);
        *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.attributes_hash, &v2) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::hash(&arg1);
        let v3 = WeaponKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::slot(&arg1)};
        0x2::dynamic_object_field::add<WeaponKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>(&mut arg0.id, v3, arg1);
    }

    public fun equip_weapon(arg0: &mut Avatar, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = WeaponKey{pos0: arg2};
        let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::equip<WeaponKey>(&mut arg0.id, v0, arg1, arg3, arg4, arg5, arg6);
        assert!(arg2 == v2, 3);
        *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg2) = v1;
        *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.attributes_hash, &arg2) = v3;
    }

    public entry fun fix_bracers_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer()};
        let v1 = if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            true
        } else {
            let v2 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer()};
            0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v2)
        };
        if (v1) {
            let v3 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_left_bracer(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v3));
            let v4 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_right_bracer(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v4));
        };
    }

    public entry fun fix_chestpiece_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_chestpiece(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public entry fun fix_helm_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_helm(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public entry fun fix_left_bracer_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_bracer()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_left_bracer(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public entry fun fix_left_pauldron_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_left_pauldron(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public entry fun fix_legs_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::legs()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::legs()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_legs(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public entry fun fix_pauldrons_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron()};
        let v1 = if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            true
        } else {
            let v2 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron()};
            0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v2)
        };
        if (v1) {
            let v3 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::left_pauldron()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_left_pauldron(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v3));
            let v4 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_right_pauldron(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v4));
        };
    }

    public entry fun fix_right_bracer_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_bracer()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_right_bracer(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public entry fun fix_right_pauldron_avatar(arg0: &mut Avatar) {
        let v0 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron()};
        if (0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)) {
            let v1 = CosmeticKey{pos0: 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::right_pauldron()};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::fix_right_pauldron(0x2::dynamic_object_field::borrow_mut<CosmeticKey, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>(&mut arg0.id, v1));
        };
    }

    public(friend) fun has_cosmetic(arg0: &Avatar, arg1: 0x1::string::String) : bool {
        let v0 = CosmeticKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<CosmeticKey>(&arg0.id, v0)
    }

    public(friend) fun has_weapon(arg0: &Avatar, arg1: 0x1::string::String) : bool {
        let v0 = WeaponKey{pos0: arg1};
        0x2::dynamic_object_field::exists_<WeaponKey>(&arg0.id, v0)
    }

    public(friend) fun image_url(arg0: &Avatar) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: AVATAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ACT Avatar: {alias}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"An avatar for traversing metaversal worlds, designed by Anima Lab."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://animalabs.io"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Anima Labs"));
        let v4 = 0x2::package::claim<AVATAR>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Avatar>(&v4, v0, v2, arg1);
        0x2::display::update_version<Avatar>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Avatar>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AvatarSettings{
            id             : 0x2::object::new(arg1),
            edition        : 0x1::string::utf8(b""),
            image_url      : 0x1::string::utf8(b""),
            avatar_model   : 0x1::string::utf8(b""),
            avatar_texture : 0x1::string::utf8(b""),
            active         : false,
        };
        0x2::transfer::share_object<AvatarSettings>(v6);
    }

    public(friend) fun new_genesis_edition(arg0: &mut 0x2::tx_context::TxContext) : Avatar {
        Avatar{
            id              : 0x2::object::new(arg0),
            image_url       : 0x1::string::utf8(b"QmWCfdKVUDLaKyJiyy3rKaHAVYhAGS7k1gXaWoLRX8mjcD"),
            avatar_model    : 0x1::string::utf8(b"QmaKS7RQCZaLSq6XfmDakZC5boPCDhgGU8AK1Tdn5Xj3oi"),
            avatar_texture  : 0x1::string::utf8(b"QmefuZMw2GeveTYEmcaJf7QTHtyE99srP6FRK6bHPK2fNe"),
            edition         : 0x1::string::utf8(b"Genesis"),
            attributes      : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::new(),
            attributes_hash : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::new_hashes(),
            misc            : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public(friend) fun set_image(arg0: &mut Avatar, arg1: 0x1::string::String) {
        arg0.image_url = arg1;
    }

    public fun set_settings_active(arg0: &mut AvatarSettings, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: bool) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.active = arg3;
    }

    public fun set_settings_avatar_model(arg0: &mut AvatarSettings, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: 0x1::string::String) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.avatar_model = arg3;
    }

    public fun set_settings_avatar_texture(arg0: &mut AvatarSettings, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: 0x1::string::String) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.avatar_texture = arg3;
    }

    public fun set_settings_edition(arg0: &mut AvatarSettings, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: 0x1::string::String) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.edition = arg3;
    }

    public fun set_settings_image_url(arg0: &mut AvatarSettings, arg1: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::AccessControl, arg2: &0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::access_control::Admin, arg3: 0x1::string::String) {
        0xa51314ed1206259abaa92da73c5b685082755e3b7797462a879033d06eb0a60c::admin::assert_genesis_minter_role(arg1, arg2);
        arg0.image_url = arg3;
    }

    public fun settings_avatar_active(arg0: &AvatarSettings) : bool {
        arg0.active
    }

    public fun settings_avatar_model(arg0: &AvatarSettings) : 0x1::string::String {
        arg0.avatar_model
    }

    public fun settings_avatar_texture(arg0: &AvatarSettings) : 0x1::string::String {
        arg0.avatar_texture
    }

    public fun settings_edition(arg0: &AvatarSettings) : 0x1::string::String {
        arg0.edition
    }

    public fun settings_image_url(arg0: &AvatarSettings) : 0x1::string::String {
        arg0.image_url
    }

    public fun unequip_cosmetics(arg0: &mut Avatar, arg1: &0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures::ProfilePictures, arg2: vector<0x1::string::String>, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::Cosmetic>) {
        0x1::vector::reverse<0x1::string::String>(&mut arg2);
        while (!0x1::vector::is_empty<0x1::string::String>(&arg2)) {
            let v0 = 0x1::vector::pop_back<0x1::string::String>(&mut arg2);
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = 0x1::string::utf8(b"");
            *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.attributes_hash, &v0) = b"";
            let v1 = CosmeticKey{pos0: v0};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic::unequip<CosmeticKey>(&mut arg0.id, v1, arg3, arg4, arg5);
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg2);
        update_image(arg0, arg1);
    }

    public fun unequip_weapons(arg0: &mut Avatar, arg1: vector<0x1::string::String>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::Weapon>) {
        0x1::vector::reverse<0x1::string::String>(&mut arg1);
        while (!0x1::vector::is_empty<0x1::string::String>(&arg1)) {
            let v0 = 0x1::vector::pop_back<0x1::string::String>(&mut arg1);
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &v0) = 0x1::string::utf8(b"");
            *0x2::vec_map::get_mut<0x1::string::String, vector<u8>>(&mut arg0.attributes_hash, &v0) = b"";
            let v1 = WeaponKey{pos0: v0};
            0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::weapon::unequip<WeaponKey>(&mut arg0.id, v1, arg2, arg3, arg4);
        };
        0x1::vector::destroy_empty<0x1::string::String>(arg1);
    }

    public fun update_image(arg0: &mut Avatar, arg1: &0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures::ProfilePictures) {
        let v0 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::helm();
        let v1 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::chestpiece();
        let v2 = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::upper_torso();
        arg0.image_url = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::profile_pictures::get(arg1, *0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg0.attributes_hash, &v0), *0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg0.attributes_hash, &v1), *0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg0.attributes_hash, &v2));
    }

    // decompiled from Move bytecode v6
}

