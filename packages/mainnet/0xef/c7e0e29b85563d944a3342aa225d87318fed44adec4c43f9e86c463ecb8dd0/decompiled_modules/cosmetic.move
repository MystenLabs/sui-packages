module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::cosmetic {
    struct COSMETIC has drop {
        dummy_field: bool,
    }

    struct Equip has drop {
        dummy_field: bool,
    }

    struct Cosmetic has store, key {
        id: 0x2::object::UID,
        hash: vector<u8>,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        model_url: 0x1::string::String,
        texture_url: 0x1::string::String,
        type: 0x1::string::String,
        formatted_type: 0x1::string::String,
        colour_way: 0x1::string::String,
        edition: 0x1::string::String,
        manufacturer: 0x1::string::String,
        rarity: 0x1::string::String,
        wear_rating: u64,
        misc: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    public(friend) fun hash(arg0: &Cosmetic) : vector<u8> {
        arg0.hash
    }

    public(friend) fun new(arg0: vector<u8>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : Cosmetic {
        Cosmetic{
            id             : 0x2::object::new(arg11),
            hash           : arg0,
            name           : arg1,
            image_url      : arg2,
            model_url      : arg3,
            texture_url    : arg4,
            type           : arg5,
            formatted_type : 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::attributes::make_formatted_type(arg5),
            colour_way     : arg6,
            edition        : arg7,
            manufacturer   : arg8,
            rarity         : arg9,
            wear_rating    : arg10,
            misc           : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        }
    }

    public(friend) fun colour_way(arg0: &Cosmetic) : 0x1::string::String {
        arg0.colour_way
    }

    public(friend) fun edition(arg0: &Cosmetic) : 0x1::string::String {
        arg0.edition
    }

    public(friend) fun equip<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: 0x2::object::ID, arg3: &mut 0x2::kiosk::Kiosk, arg4: &0x2::kiosk::KioskOwnerCap, arg5: &0x2::transfer_policy::TransferPolicy<Cosmetic>, arg6: &mut 0x2::tx_context::TxContext) : (0x1::string::String, 0x1::string::String, vector<u8>) {
        let v0 = 0x2::kiosk::borrow<Cosmetic>(arg3, arg4, arg2);
        let v1 = Equip{dummy_field: false};
        0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item::equip<T0, Equip, Cosmetic>(arg0, arg1, arg2, arg3, arg4, arg5, v1, arg6);
        (v0.name, v0.type, v0.hash)
    }

    public entry fun fix_bracers_personal_kiosk(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<Cosmetic>(arg1, &v2, arg0);
        if (v3.type == 0x1::string::utf8(b"Left Bracer")) {
            fix_left_bracer(v3);
        } else if (v3.type == 0x1::string::utf8(b"Right Bracer")) {
            fix_right_bracer(v3);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    public(friend) fun fix_chestpiece(arg0: &mut Cosmetic) {
        let v0 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                if (arg0.image_url == 0x1::string::utf8(b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3")) {
                    arg0.type == 0x1::string::utf8(b"Chestpiece")
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.colour_way = 0x1::string::utf8(b"Hikari");
            arg0.rarity = 0x1::string::utf8(b"Mythic");
            let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_chestpiece(b"Fang MK IV", b"Hikari");
            arg0.image_url = 0x1::string::utf8(v1);
            arg0.model_url = 0x1::string::utf8(v2);
            arg0.texture_url = 0x1::string::utf8(v3);
            let v4 = b"";
            0x1::vector::append<u8>(&mut v4, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v4, b"Chestpiece");
            0x1::vector::append<u8>(&mut v4, b"Hikari");
            arg0.hash = 0x2::hash::blake2b256(&v4);
        };
    }

    public entry fun fix_chestpiece_personal_kiosk(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<Cosmetic>(arg1, &v2, arg0);
        fix_chestpiece(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    public(friend) fun fix_helm(arg0: &mut Cosmetic) {
        let v0 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                if (arg0.image_url == 0x1::string::utf8(b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3")) {
                    arg0.type == 0x1::string::utf8(b"Helm")
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.colour_way = 0x1::string::utf8(b"Hikari");
            arg0.rarity = 0x1::string::utf8(b"Mythic");
            let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_helm(b"Fang MK IV", b"Hikari");
            arg0.image_url = 0x1::string::utf8(v1);
            arg0.model_url = 0x1::string::utf8(v2);
            arg0.texture_url = 0x1::string::utf8(v3);
            let v4 = b"";
            0x1::vector::append<u8>(&mut v4, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v4, b"Helm");
            0x1::vector::append<u8>(&mut v4, b"Hikari");
            arg0.hash = 0x2::hash::blake2b256(&v4);
        };
    }

    public entry fun fix_helm_personal_kiosk(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<Cosmetic>(arg1, &v2, arg0);
        fix_helm(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    public(friend) fun fix_left_bracer(arg0: &mut Cosmetic) {
        let v0 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                if (arg0.image_url == 0x1::string::utf8(b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3")) {
                    arg0.type == 0x1::string::utf8(b"Left Bracer")
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.colour_way = 0x1::string::utf8(b"Hikari");
            arg0.rarity = 0x1::string::utf8(b"Mythic");
            let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_left_bracer(b"Fang MK IV", b"Hikari");
            arg0.image_url = 0x1::string::utf8(v1);
            arg0.model_url = 0x1::string::utf8(v2);
            arg0.texture_url = 0x1::string::utf8(v3);
            let v4 = b"";
            0x1::vector::append<u8>(&mut v4, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v4, b"Left Bracer");
            0x1::vector::append<u8>(&mut v4, b"Hikari");
            arg0.hash = 0x2::hash::blake2b256(&v4);
        };
    }

    public(friend) fun fix_left_pauldron(arg0: &mut Cosmetic) {
        let v0 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                if (arg0.image_url == 0x1::string::utf8(b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3")) {
                    arg0.type == 0x1::string::utf8(b"Left Pauldron")
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.colour_way = 0x1::string::utf8(b"Hikari");
            arg0.rarity = 0x1::string::utf8(b"Mythic");
            let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_left_pauldron(b"Fang MK IV", b"Hikari");
            arg0.image_url = 0x1::string::utf8(v1);
            arg0.model_url = 0x1::string::utf8(v2);
            arg0.texture_url = 0x1::string::utf8(v3);
            let v4 = b"";
            0x1::vector::append<u8>(&mut v4, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v4, b"Left Pauldron");
            0x1::vector::append<u8>(&mut v4, b"Hikari");
            arg0.hash = 0x2::hash::blake2b256(&v4);
        };
    }

    public(friend) fun fix_legs(arg0: &mut Cosmetic) {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, b"Fang MK IV");
        0x1::vector::append<u8>(&mut v0, b"Legs");
        0x1::vector::append<u8>(&mut v0, b"Hikari");
        let v1 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Hikari")) {
                arg0.type == 0x1::string::utf8(b"Legs")
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            arg0.colour_way = 0x1::string::utf8(b"Digital Winter");
            arg0.rarity = 0x1::string::utf8(b"Ultra Rare");
            let (v2, v3, v4) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_other(b"Fang MK IV", b"Legs", b"Digital Winter");
            arg0.image_url = 0x1::string::utf8(v2);
            arg0.model_url = 0x1::string::utf8(v3);
            arg0.texture_url = 0x1::string::utf8(v4);
            let v5 = b"";
            0x1::vector::append<u8>(&mut v5, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v5, b"Legs");
            0x1::vector::append<u8>(&mut v5, b"Digital Winter");
            arg0.hash = 0x2::hash::blake2b256(&v5);
        } else {
            let v6 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
                if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                    if (arg0.type == 0x1::string::utf8(b"Legs")) {
                        arg0.hash == 0x2::hash::blake2b256(&v0)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v6) {
                let v7 = b"";
                0x1::vector::append<u8>(&mut v7, b"Fang MK IV");
                0x1::vector::append<u8>(&mut v7, b"Legs");
                0x1::vector::append<u8>(&mut v7, b"Digital Winter");
                arg0.hash = 0x2::hash::blake2b256(&v7);
            };
        };
    }

    public fun fix_legs_kiosk(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap) {
        let v0 = 0x2::kiosk::borrow_mut<Cosmetic>(arg1, arg2, arg0);
        fix_legs(v0);
    }

    public entry fun fix_legs_personal_kiosk(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<Cosmetic>(arg1, &v2, arg0);
        fix_legs(v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    public entry fun fix_pauldrons_personal_kiosk(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::PersonalKioskCap) {
        let (v0, v1) = 0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::borrow_val(arg2);
        let v2 = v0;
        let v3 = 0x2::kiosk::borrow_mut<Cosmetic>(arg1, &v2, arg0);
        if (v3.type == 0x1::string::utf8(b"Left Pauldron")) {
            fix_left_pauldron(v3);
        } else if (v3.type == 0x1::string::utf8(b"Right Pauldron")) {
            fix_right_pauldron(v3);
        };
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::return_val(arg2, v2, v1);
    }

    public(friend) fun fix_right_bracer(arg0: &mut Cosmetic) {
        let v0 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                if (arg0.image_url == 0x1::string::utf8(b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3")) {
                    arg0.type == 0x1::string::utf8(b"Right Bracer")
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.colour_way = 0x1::string::utf8(b"Hikari");
            arg0.rarity = 0x1::string::utf8(b"Mythic");
            let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_right_bracer(b"Fang MK IV", b"Hikari");
            arg0.image_url = 0x1::string::utf8(v1);
            arg0.model_url = 0x1::string::utf8(v2);
            arg0.texture_url = 0x1::string::utf8(v3);
            let v4 = b"";
            0x1::vector::append<u8>(&mut v4, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v4, b"Right Bracer");
            0x1::vector::append<u8>(&mut v4, b"Hikari");
            arg0.hash = 0x2::hash::blake2b256(&v4);
        };
    }

    public(friend) fun fix_right_pauldron(arg0: &mut Cosmetic) {
        let v0 = if (arg0.name == 0x1::string::utf8(b"Fang MK IV")) {
            if (arg0.colour_way == 0x1::string::utf8(b"Digital Winter")) {
                if (arg0.image_url == 0x1::string::utf8(b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3")) {
                    arg0.type == 0x1::string::utf8(b"Right Pauldron")
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v0) {
            arg0.colour_way = 0x1::string::utf8(b"Hikari");
            arg0.rarity = 0x1::string::utf8(b"Mythic");
            let (v1, v2, v3) = 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris::get_right_pauldron(b"Fang MK IV", b"Hikari");
            arg0.image_url = 0x1::string::utf8(v1);
            arg0.model_url = 0x1::string::utf8(v2);
            arg0.texture_url = 0x1::string::utf8(v3);
            let v4 = b"";
            0x1::vector::append<u8>(&mut v4, b"Fang MK IV");
            0x1::vector::append<u8>(&mut v4, b"Right Pauldron");
            0x1::vector::append<u8>(&mut v4, b"Hikari");
            arg0.hash = 0x2::hash::blake2b256(&v4);
        };
    }

    public(friend) fun formatted_type(arg0: &Cosmetic) : 0x1::string::String {
        arg0.formatted_type
    }

    public(friend) fun image_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: COSMETIC, arg1: &mut 0x2::tx_context::TxContext) {
        0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item::init_state<COSMETIC, Equip, Cosmetic>(arg0, 0x1::string::utf8(b"{name} {formatted_type}"), 0x1::string::utf8(b"A cosmetic built in the laser forges of ACT, an Anima Nexus world."), arg1);
    }

    public(friend) fun manufacturer(arg0: &Cosmetic) : 0x1::string::String {
        arg0.manufacturer
    }

    public(friend) fun model_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.model_url
    }

    public(friend) fun name(arg0: &Cosmetic) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun rarity(arg0: &Cosmetic) : 0x1::string::String {
        arg0.rarity
    }

    public(friend) fun texture_url(arg0: &Cosmetic) : 0x1::string::String {
        arg0.texture_url
    }

    public(friend) fun type_(arg0: &Cosmetic) : 0x1::string::String {
        arg0.type
    }

    public(friend) fun unequip<T0: copy + drop + store>(arg0: &mut 0x2::object::UID, arg1: T0, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<Cosmetic>) : 0x1::string::String {
        0x2::kiosk::borrow<Cosmetic>(arg2, arg3, 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::item::unequip<T0, Cosmetic>(arg0, arg1, arg2, arg3, arg4)).name
    }

    public(friend) fun wear_rating(arg0: &Cosmetic) : u64 {
        arg0.wear_rating
    }

    // decompiled from Move bytecode v6
}

