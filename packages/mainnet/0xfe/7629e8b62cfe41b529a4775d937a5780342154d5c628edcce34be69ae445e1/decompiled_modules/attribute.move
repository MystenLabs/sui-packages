module 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::attribute {
    struct ATTRIBUTE has drop {
        dummy_field: bool,
    }

    struct KumoAccessory has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoBackground has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoEyes has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoFurColour has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoMouth has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoTail has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoOneOfOne has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_hash: 0x1::string::String,
        rarity: 0x1::string::String,
        rarity_score: u64,
    }

    struct KumoAttributeMintAuth has store, key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        owner: address,
        accessory_count: u64,
        background_count: u64,
        eyes_count: u64,
        fur_colour_count: u64,
        mouth_count: u64,
        tail_count: u64,
        one_of_one_count: u64,
        total_mint_count: u64,
    }

    struct KumoAttributeMintedEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        category: 0x1::string::String,
    }

    public(friend) fun accessory_name(arg0: &KumoAccessory) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun accessory_rarity_score(arg0: &KumoAccessory) : u64 {
        arg0.rarity_score
    }

    fun attach_accessory(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoAccessory) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoAccessory>(arg0, arg1, arg2, 0x1::string::utf8(b"Accessory"), accessory_name(&arg3), accessory_rarity_score(&arg3), arg3);
    }

    fun attach_background(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoBackground) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoBackground>(arg0, arg1, arg2, 0x1::string::utf8(b"Background"), background_name(&arg3), background_rarity_score(&arg3), arg3);
    }

    fun attach_eyes(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoEyes) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoEyes>(arg0, arg1, arg2, 0x1::string::utf8(b"Eyes"), eyes_name(&arg3), eyes_rarity_score(&arg3), arg3);
    }

    fun attach_fur_colour(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoFurColour) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoFurColour>(arg0, arg1, arg2, 0x1::string::utf8(b"FurColour"), fur_colour_name(&arg3), fur_colour_rarity_score(&arg3), arg3);
    }

    fun attach_mouth(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoMouth) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoMouth>(arg0, arg1, arg2, 0x1::string::utf8(b"Mouth"), mouth_name(&arg3), mouth_rarity_score(&arg3), arg3);
    }

    fun attach_one_of_one(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoOneOfOne) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoOneOfOne>(arg0, arg1, arg2, 0x1::string::utf8(b"OneOfOne"), one_of_one_name(&arg3), one_of_one_rarity_score(&arg3), arg3);
    }

    fun attach_tail(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: KumoTail) {
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoTail>(arg0, arg1, arg2, 0x1::string::utf8(b"Tail"), tail_name(&arg3), tail_rarity_score(&arg3), arg3);
    }

    public(friend) fun background_name(arg0: &KumoBackground) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun background_rarity_score(arg0: &KumoBackground) : u64 {
        arg0.rarity_score
    }

    fun confirm_equipment(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::KumoMutationValidator, arg4: vector<0x1::string::String>, arg5: &0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg6: &0x2::transfer_policy::TransferPolicy<KumoBackground>, arg7: &0x2::transfer_policy::TransferPolicy<KumoEyes>, arg8: &0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg9: &0x2::transfer_policy::TransferPolicy<KumoMouth>, arg10: &0x2::transfer_policy::TransferPolicy<KumoTail>, arg11: &0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg12: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoAccessory>>, arg13: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoBackground>>, arg14: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoEyes>>, arg15: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoFurColour>>, arg16: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoMouth>>, arg17: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoTail>>, arg18: 0x1::option::Option<0x2::transfer_policy::TransferRequest<KumoOneOfOne>>, arg19: 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::EquipmentReceipt) {
        assert!(arg4 == 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::get_current_loadout(arg0, arg1, arg2), 3);
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoAccessory>>(&arg12)) {
            let v0 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoAccessory>>(&mut arg12);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoAccessory>(&mut v0, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoAccessory>(arg5, v0);
        };
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoBackground>>(&arg13)) {
            let v4 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoBackground>>(&mut arg13);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoBackground>(&mut v4, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoBackground>(arg6, v4);
        };
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoEyes>>(&arg14)) {
            let v8 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoEyes>>(&mut arg14);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoEyes>(&mut v8, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoEyes>(arg7, v8);
        };
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoFurColour>>(&arg15)) {
            let v12 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoFurColour>>(&mut arg15);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoFurColour>(&mut v12, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoFurColour>(arg8, v12);
        };
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoMouth>>(&arg16)) {
            let v16 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoMouth>>(&mut arg16);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoMouth>(&mut v16, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoMouth>(arg9, v16);
        };
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoTail>>(&arg17)) {
            let v20 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoTail>>(&mut arg17);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoTail>(&mut v20, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoTail>(arg10, v20);
        };
        if (0x1::option::is_some<0x2::transfer_policy::TransferRequest<KumoOneOfOne>>(&arg18)) {
            let v24 = 0x1::option::extract<0x2::transfer_policy::TransferRequest<KumoOneOfOne>>(&mut arg18);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::confirm_equipped_attribute<KumoOneOfOne>(&mut v24, &mut arg19);
            let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoOneOfOne>(arg11, v24);
        };
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoAccessory>>(arg12);
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoBackground>>(arg13);
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoEyes>>(arg14);
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoFurColour>>(arg15);
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoMouth>>(arg16);
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoTail>>(arg17);
        0x1::option::destroy_none<0x2::transfer_policy::TransferRequest<KumoOneOfOne>>(arg18);
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::destroy_empty_receipt(arg19);
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::complete_mutation(arg0, arg1, arg2, arg3);
    }

    fun equip(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x1::option::Option<KumoAccessory>, arg4: 0x1::option::Option<KumoBackground>, arg5: 0x1::option::Option<KumoEyes>, arg6: 0x1::option::Option<KumoFurColour>, arg7: 0x1::option::Option<KumoMouth>, arg8: 0x1::option::Option<KumoTail>, arg9: 0x1::option::Option<KumoOneOfOne>, arg10: &mut 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::EquipmentReceipt) {
        if (0x1::option::is_some<KumoAccessory>(&arg3)) {
            let v0 = 0x1::option::extract<KumoAccessory>(&mut arg3);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoAccessory>(&v0));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoAccessory>(arg0, arg1, arg2, 0x1::string::utf8(b"Accessory"), v0.name, v0.rarity_score, v0);
        };
        if (0x1::option::is_some<KumoBackground>(&arg4)) {
            let v1 = 0x1::option::extract<KumoBackground>(&mut arg4);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoBackground>(&v1));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoBackground>(arg0, arg1, arg2, 0x1::string::utf8(b"Background"), v1.name, v1.rarity_score, v1);
        };
        if (0x1::option::is_some<KumoEyes>(&arg5)) {
            let v2 = 0x1::option::extract<KumoEyes>(&mut arg5);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoEyes>(&v2));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoEyes>(arg0, arg1, arg2, 0x1::string::utf8(b"Eyes"), v2.name, v2.rarity_score, v2);
        };
        if (0x1::option::is_some<KumoFurColour>(&arg6)) {
            let v3 = 0x1::option::extract<KumoFurColour>(&mut arg6);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoFurColour>(&v3));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoFurColour>(arg0, arg1, arg2, 0x1::string::utf8(b"FurColour"), v3.name, v3.rarity_score, v3);
        };
        if (0x1::option::is_some<KumoMouth>(&arg7)) {
            let v4 = 0x1::option::extract<KumoMouth>(&mut arg7);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoMouth>(&v4));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoMouth>(arg0, arg1, arg2, 0x1::string::utf8(b"Mouth"), v4.name, v4.rarity_score, v4);
        };
        if (0x1::option::is_some<KumoTail>(&arg8)) {
            let v5 = 0x1::option::extract<KumoTail>(&mut arg8);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoTail>(&v5));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoTail>(arg0, arg1, arg2, 0x1::string::utf8(b"Tail"), v5.name, v5.rarity_score, v5);
        };
        if (0x1::option::is_some<KumoOneOfOne>(&arg9)) {
            let v6 = 0x1::option::extract<KumoOneOfOne>(&mut arg9);
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add_id_to_receipt(arg10, 0x2::object::id<KumoOneOfOne>(&v6));
            0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::set_attribute<KumoOneOfOne>(arg0, arg1, arg2, 0x1::string::utf8(b"OneOfOne"), v6.name, v6.rarity_score, v6);
        };
        0x1::option::destroy_none<KumoAccessory>(arg3);
        0x1::option::destroy_none<KumoBackground>(arg4);
        0x1::option::destroy_none<KumoEyes>(arg5);
        0x1::option::destroy_none<KumoFurColour>(arg6);
        0x1::option::destroy_none<KumoMouth>(arg7);
        0x1::option::destroy_none<KumoTail>(arg8);
        0x1::option::destroy_none<KumoOneOfOne>(arg9);
    }

    public(friend) fun eyes_name(arg0: &KumoEyes) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun eyes_rarity_score(arg0: &KumoEyes) : u64 {
        arg0.rarity_score
    }

    public(friend) fun fur_colour_name(arg0: &KumoFurColour) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun fur_colour_rarity_score(arg0: &KumoFurColour) : u64 {
        arg0.rarity_score
    }

    fun init(arg0: ATTRIBUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ATTRIBUTE>(arg0, arg1);
        setup_display<KumoAccessory>(&v1, arg1);
        setup_display<KumoBackground>(&v1, arg1);
        setup_display<KumoEyes>(&v1, arg1);
        setup_display<KumoFurColour>(&v1, arg1);
        setup_display<KumoMouth>(&v1, arg1);
        setup_display<KumoTail>(&v1, arg1);
        setup_display<KumoOneOfOne>(&v1, arg1);
        setup_transfer_policy<KumoAccessory>(&v1, arg1);
        setup_transfer_policy<KumoBackground>(&v1, arg1);
        setup_transfer_policy<KumoEyes>(&v1, arg1);
        setup_transfer_policy<KumoFurColour>(&v1, arg1);
        setup_transfer_policy<KumoMouth>(&v1, arg1);
        setup_transfer_policy<KumoTail>(&v1, arg1);
        setup_transfer_policy<KumoOneOfOne>(&v1, arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v2 = KumoAttributeMintAuth{
            id               : 0x2::object::new(arg1),
            description      : 0x1::string::utf8(b"Main Kumo Attribute mint authority"),
            owner            : v0,
            accessory_count  : 0,
            background_count : 0,
            eyes_count       : 0,
            fur_colour_count : 0,
            mouth_count      : 0,
            tail_count       : 0,
            one_of_one_count : 0,
            total_mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoAttributeMintAuth>(v2, v0);
    }

    public fun init_equip(arg0: &mut 0x2::kiosk::Kiosk, arg1: &mut 0x2::kiosk::KioskOwnerCap, arg2: address, arg3: &mut 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::KumoMutationValidator, arg4: &0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg5: &0x2::transfer_policy::TransferPolicy<KumoBackground>, arg6: &0x2::transfer_policy::TransferPolicy<KumoEyes>, arg7: &0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg8: &0x2::transfer_policy::TransferPolicy<KumoMouth>, arg9: &0x2::transfer_policy::TransferPolicy<KumoTail>, arg10: &0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg11: &0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg12: &0x2::transfer_policy::TransferPolicy<KumoBackground>, arg13: &0x2::transfer_policy::TransferPolicy<KumoEyes>, arg14: &0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg15: &0x2::transfer_policy::TransferPolicy<KumoMouth>, arg16: &0x2::transfer_policy::TransferPolicy<KumoTail>, arg17: &0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg18: &mut 0x1::option::Option<address>, arg19: &mut 0x1::option::Option<address>, arg20: &mut 0x1::option::Option<address>, arg21: &mut 0x1::option::Option<address>, arg22: &mut 0x1::option::Option<address>, arg23: &mut 0x1::option::Option<address>, arg24: &mut 0x1::option::Option<address>, arg25: vector<0x1::string::String>, arg26: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<0x1::string::String>(&arg25) == 7, 2);
        let v0 = 0x2::object::id_from_address(arg2);
        let v1 = 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::get_current_loadout(v0, arg0, arg1);
        let v2 = 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::new_receipt();
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = 0x1::option::none<KumoAccessory>();
        let v5 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoAccessory>>();
        let v6 = 0x1::option::none<KumoBackground>();
        let v7 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoBackground>>();
        let v8 = 0x1::option::none<KumoEyes>();
        let v9 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoEyes>>();
        let v10 = 0x1::option::none<KumoFurColour>();
        let v11 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoFurColour>>();
        let v12 = 0x1::option::none<KumoMouth>();
        let v13 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoMouth>>();
        let v14 = 0x1::option::none<KumoTail>();
        let v15 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoTail>>();
        let v16 = 0x1::option::none<KumoOneOfOne>();
        let v17 = 0x1::option::none<0x2::transfer_policy::TransferRequest<KumoOneOfOne>>();
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 0) != *0x1::vector::borrow<0x1::string::String>(&v1, 0) && *0x1::vector::borrow<0x1::string::String>(&v1, 0) != 0x1::string::utf8(b"None")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"Accessory"));
        };
        if (0x1::option::is_some<address>(arg18)) {
            let (v18, v19) = unlock_attribute_for_equipping<KumoAccessory>(0x1::option::extract<address>(arg18), arg0, arg1, arg26);
            0x1::option::fill<KumoAccessory>(&mut v4, v18);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoAccessory>>(&mut v5, v19);
        };
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 1) != *0x1::vector::borrow<0x1::string::String>(&v1, 1) && *0x1::vector::borrow<0x1::string::String>(&v1, 1) != 0x1::string::utf8(b"Default")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"Background"));
        };
        if (0x1::option::is_some<address>(arg19)) {
            let (v20, v21) = unlock_attribute_for_equipping<KumoBackground>(0x1::option::extract<address>(arg19), arg0, arg1, arg26);
            0x1::option::fill<KumoBackground>(&mut v6, v20);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoBackground>>(&mut v7, v21);
        };
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 2) != *0x1::vector::borrow<0x1::string::String>(&v1, 2) && *0x1::vector::borrow<0x1::string::String>(&v1, 2) != 0x1::string::utf8(b"Default")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"Eyes"));
        };
        if (0x1::option::is_some<address>(arg20)) {
            let (v22, v23) = unlock_attribute_for_equipping<KumoEyes>(0x1::option::extract<address>(arg20), arg0, arg1, arg26);
            0x1::option::fill<KumoEyes>(&mut v8, v22);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoEyes>>(&mut v9, v23);
        };
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 3) != *0x1::vector::borrow<0x1::string::String>(&v1, 3) && *0x1::vector::borrow<0x1::string::String>(&v1, 3) != 0x1::string::utf8(b"Default")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"FurColour"));
        };
        if (0x1::option::is_some<address>(arg21)) {
            let (v24, v25) = unlock_attribute_for_equipping<KumoFurColour>(0x1::option::extract<address>(arg21), arg0, arg1, arg26);
            0x1::option::fill<KumoFurColour>(&mut v10, v24);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoFurColour>>(&mut v11, v25);
        };
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 4) != *0x1::vector::borrow<0x1::string::String>(&v1, 4) && *0x1::vector::borrow<0x1::string::String>(&v1, 4) != 0x1::string::utf8(b"Default")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"Mouth"));
        };
        if (0x1::option::is_some<address>(arg22)) {
            let (v26, v27) = unlock_attribute_for_equipping<KumoMouth>(0x1::option::extract<address>(arg22), arg0, arg1, arg26);
            0x1::option::fill<KumoMouth>(&mut v12, v26);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoMouth>>(&mut v13, v27);
        };
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 5) != *0x1::vector::borrow<0x1::string::String>(&v1, 5) && *0x1::vector::borrow<0x1::string::String>(&v1, 5) != 0x1::string::utf8(b"Default")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"Tail"));
        };
        if (0x1::option::is_some<address>(arg23)) {
            let (v28, v29) = unlock_attribute_for_equipping<KumoTail>(0x1::option::extract<address>(arg23), arg0, arg1, arg26);
            0x1::option::fill<KumoTail>(&mut v14, v28);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoTail>>(&mut v15, v29);
        };
        if (*0x1::vector::borrow<0x1::string::String>(&arg25, 6) != *0x1::vector::borrow<0x1::string::String>(&v1, 6) && *0x1::vector::borrow<0x1::string::String>(&v1, 6) != 0x1::string::utf8(b"None")) {
            0x1::vector::push_back<0x1::string::String>(&mut v3, 0x1::string::utf8(b"OneOfOne"));
        };
        if (0x1::option::is_some<address>(arg24)) {
            let (v30, v31) = unlock_attribute_for_equipping<KumoOneOfOne>(0x1::option::extract<address>(arg24), arg0, arg1, arg26);
            0x1::option::fill<KumoOneOfOne>(&mut v16, v30);
            0x1::option::fill<0x2::transfer_policy::TransferRequest<KumoOneOfOne>>(&mut v17, v31);
        };
        unequip(v0, arg0, arg1, arg4, arg5, arg6, arg7, arg8, arg9, arg10, v3);
        let v32 = &mut v2;
        equip(v0, arg0, arg1, v4, v6, v8, v10, v12, v14, v16, v32);
        confirm_equipment(v0, arg0, arg1, arg3, arg25, arg11, arg12, arg13, arg14, arg15, arg16, arg17, v5, v7, v9, v11, v13, v15, v17, v2);
    }

    fun mint_accessory(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoAccessory {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoAccessory{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoAccessory>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Accessory"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.accessory_count = arg0.accessory_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_accessory_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_accessory(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoAccessory>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoAccessory>(&v0)
    }

    public fun mint_accessory_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_accessory(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_accessory(arg6, arg7, arg8, v0);
        0x2::object::id<KumoAccessory>(&v0)
    }

    public entry fun mint_attribute_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<KumoAccessory>(arg0), 1);
        let v0 = KumoAttributeMintAuth{
            id               : 0x2::object::new(arg2),
            description      : 0x1::string::utf8(b"Kumo Attribute Mint Authority"),
            owner            : arg1,
            accessory_count  : 0,
            background_count : 0,
            eyes_count       : 0,
            fur_colour_count : 0,
            mouth_count      : 0,
            tail_count       : 0,
            one_of_one_count : 0,
            total_mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoAttributeMintAuth>(v0, arg1);
    }

    fun mint_background(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoBackground {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoBackground{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoBackground>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Background"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.background_count = arg0.background_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_background_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoBackground>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_background(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoBackground>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoBackground>(&v0)
    }

    public fun mint_background_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_background(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_background(arg6, arg7, arg8, v0);
        0x2::object::id<KumoBackground>(&v0)
    }

    fun mint_eyes(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoEyes {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoEyes{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoEyes>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Eyes"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.eyes_count = arg0.eyes_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_eyes_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoEyes>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_eyes(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoEyes>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoEyes>(&v0)
    }

    public fun mint_eyes_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_eyes(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_eyes(arg6, arg7, arg8, v0);
        0x2::object::id<KumoEyes>(&v0)
    }

    fun mint_fur_colour(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoFurColour {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoFurColour{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoFurColour>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"FurColour"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.fur_colour_count = arg0.fur_colour_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_fur_colour_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_fur_colour(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoFurColour>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoFurColour>(&v0)
    }

    public fun mint_fur_colour_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_fur_colour(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_fur_colour(arg6, arg7, arg8, v0);
        0x2::object::id<KumoFurColour>(&v0)
    }

    fun mint_mouth(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoMouth {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoMouth{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoMouth>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Mouth"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.mouth_count = arg0.mouth_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_mouth_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoMouth>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_mouth(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoMouth>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoMouth>(&v0)
    }

    public fun mint_mouth_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_mouth(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_mouth(arg6, arg7, arg8, v0);
        0x2::object::id<KumoMouth>(&v0)
    }

    fun mint_one_of_one(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoOneOfOne {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoOneOfOne{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoOneOfOne>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"OneOfOne"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.one_of_one_count = arg0.one_of_one_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_one_of_one_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_one_of_one(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoOneOfOne>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoOneOfOne>(&v0)
    }

    public fun mint_one_of_one_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_one_of_one(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_one_of_one(arg6, arg7, arg8, v0);
        0x2::object::id<KumoOneOfOne>(&v0)
    }

    fun mint_tail(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : KumoTail {
        assert!(arg0.owner == 0x2::tx_context::sender(arg6), 0);
        let v0 = KumoTail{
            id           : 0x2::object::new(arg6),
            name         : 0x1::string::utf8(arg1),
            description  : 0x1::string::utf8(arg2),
            image_hash   : 0x1::string::utf8(arg3),
            rarity       : 0x1::string::utf8(arg4),
            rarity_score : arg5,
        };
        let v1 = KumoAttributeMintedEvent{
            id       : 0x2::object::id<KumoTail>(&v0),
            name     : 0x1::string::utf8(arg1),
            category : 0x1::string::utf8(b"Tail"),
        };
        0x2::event::emit<KumoAttributeMintedEvent>(v1);
        arg0.tail_count = arg0.tail_count + 1;
        arg0.total_mint_count = arg0.total_mint_count + 1;
        v0
    }

    public fun mint_tail_to_kiosk(arg0: &mut KumoAttributeMintAuth, arg1: &0x2::transfer_policy::TransferPolicy<KumoTail>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_tail(arg0, arg2, arg3, arg4, arg5, arg6, arg9);
        0x2::kiosk::lock<KumoTail>(arg7, arg8, arg1, v0);
        0x2::object::id<KumoTail>(&v0)
    }

    public fun mint_tail_to_kumo(arg0: &mut KumoAttributeMintAuth, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: 0x2::object::ID, arg7: &mut 0x2::kiosk::Kiosk, arg8: &0x2::kiosk::KioskOwnerCap, arg9: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = mint_tail(arg0, arg1, arg2, arg3, arg4, arg5, arg9);
        attach_tail(arg6, arg7, arg8, v0);
        0x2::object::id<KumoTail>(&v0)
    }

    public(friend) fun mouth_name(arg0: &KumoMouth) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun mouth_rarity_score(arg0: &KumoMouth) : u64 {
        arg0.rarity_score
    }

    public entry fun mutate_accessory_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoAccessory>) {
        assert!(0x2::package::from_package<KumoAccessory>(arg0), 1);
        0x2::display::edit<KumoAccessory>(arg3, arg1, arg2);
        0x2::display::update_version<KumoAccessory>(arg3);
    }

    public entry fun mutate_background_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoBackground>) {
        assert!(0x2::package::from_package<KumoBackground>(arg0), 1);
        0x2::display::edit<KumoBackground>(arg3, arg1, arg2);
        0x2::display::update_version<KumoBackground>(arg3);
    }

    public entry fun mutate_eyes_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoEyes>) {
        assert!(0x2::package::from_package<KumoEyes>(arg0), 1);
        0x2::display::edit<KumoEyes>(arg3, arg1, arg2);
        0x2::display::update_version<KumoEyes>(arg3);
    }

    public entry fun mutate_fur_colour_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoFurColour>) {
        assert!(0x2::package::from_package<KumoFurColour>(arg0), 1);
        0x2::display::edit<KumoFurColour>(arg3, arg1, arg2);
        0x2::display::update_version<KumoFurColour>(arg3);
    }

    public entry fun mutate_mouth_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoMouth>) {
        assert!(0x2::package::from_package<KumoMouth>(arg0), 1);
        0x2::display::edit<KumoMouth>(arg3, arg1, arg2);
        0x2::display::update_version<KumoMouth>(arg3);
    }

    public entry fun mutate_one_of_one_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoOneOfOne>) {
        assert!(0x2::package::from_package<KumoOneOfOne>(arg0), 1);
        0x2::display::edit<KumoOneOfOne>(arg3, arg1, arg2);
        0x2::display::update_version<KumoOneOfOne>(arg3);
    }

    public entry fun mutate_tail_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoTail>) {
        assert!(0x2::package::from_package<KumoTail>(arg0), 1);
        0x2::display::edit<KumoTail>(arg3, arg1, arg2);
        0x2::display::update_version<KumoTail>(arg3);
    }

    public(friend) fun one_of_one_name(arg0: &KumoOneOfOne) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun one_of_one_rarity_score(arg0: &KumoOneOfOne) : u64 {
        arg0.rarity_score
    }

    fun setup_display<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"ipfs://{image_hash}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://kumothekat.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v4 = 0x2::display::new_with_fields<T0>(arg0, v0, v2, arg1);
        0x2::display::update_version<T0>(&mut v4);
        0x2::transfer::public_transfer<0x2::display::Display<T0>>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun setup_equip_transfer_policy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::equip_rule::add<T0>(&mut v3, &v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    fun setup_transfer_policy<T0: store + key>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<T0>(&mut v3, &v2);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<T0>(&mut v3, &v2, 500, 0);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun tail_name(arg0: &KumoTail) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun tail_rarity_score(arg0: &KumoTail) : u64 {
        arg0.rarity_score
    }

    public fun transfer_attribute_to_kumo_kiosk(arg0: vector<address>, arg1: vector<0x1::string::String>, arg2: &mut 0x2::kiosk::Kiosk, arg3: &mut 0x2::kiosk::KioskOwnerCap, arg4: &mut 0x2::kiosk::Kiosk, arg5: &mut 0x2::kiosk::KioskOwnerCap, arg6: &mut 0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg7: &mut 0x2::transfer_policy::TransferPolicy<KumoBackground>, arg8: &mut 0x2::transfer_policy::TransferPolicy<KumoEyes>, arg9: &mut 0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg10: &mut 0x2::transfer_policy::TransferPolicy<KumoMouth>, arg11: &mut 0x2::transfer_policy::TransferPolicy<KumoTail>, arg12: &mut 0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg13: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg1, v0);
            if (v1 == 0x1::string::utf8(b"Accessory")) {
                let (v2, v3) = 0x2::kiosk::purchase_with_cap<KumoAccessory>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoAccessory>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v4 = v3;
                0x2::kiosk::lock<KumoAccessory>(arg2, arg3, arg6, v2);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoAccessory>(arg6, &mut v4, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoAccessory>(&mut v4, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoAccessory>(arg6, v4);
            } else if (v1 == 0x1::string::utf8(b"Background")) {
                let (v8, v9) = 0x2::kiosk::purchase_with_cap<KumoBackground>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoBackground>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v10 = v9;
                0x2::kiosk::lock<KumoBackground>(arg2, arg3, arg7, v8);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoBackground>(arg7, &mut v10, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoBackground>(&mut v10, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoBackground>(arg7, v10);
            } else if (v1 == 0x1::string::utf8(b"Eyes")) {
                let (v14, v15) = 0x2::kiosk::purchase_with_cap<KumoEyes>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoEyes>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v16 = v15;
                0x2::kiosk::lock<KumoEyes>(arg2, arg3, arg8, v14);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoEyes>(arg8, &mut v16, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoEyes>(&mut v16, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoEyes>(arg8, v16);
            } else if (v1 == 0x1::string::utf8(b"FurColour")) {
                let (v20, v21) = 0x2::kiosk::purchase_with_cap<KumoFurColour>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoFurColour>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v22 = v21;
                0x2::kiosk::lock<KumoFurColour>(arg2, arg3, arg9, v20);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoFurColour>(arg9, &mut v22, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoFurColour>(&mut v22, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoFurColour>(arg9, v22);
            } else if (v1 == 0x1::string::utf8(b"Mouth")) {
                let (v26, v27) = 0x2::kiosk::purchase_with_cap<KumoMouth>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoMouth>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v28 = v27;
                0x2::kiosk::lock<KumoMouth>(arg2, arg3, arg10, v26);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoMouth>(arg10, &mut v28, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoMouth>(&mut v28, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoMouth>(arg10, v28);
            } else if (v1 == 0x1::string::utf8(b"Tail")) {
                let (v32, v33) = 0x2::kiosk::purchase_with_cap<KumoTail>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoTail>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v34 = v33;
                0x2::kiosk::lock<KumoTail>(arg2, arg3, arg11, v32);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoTail>(arg11, &mut v34, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoTail>(&mut v34, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoTail>(arg11, v34);
            } else if (v1 == 0x1::string::utf8(b"OneOfOne")) {
                let (v38, v39) = 0x2::kiosk::purchase_with_cap<KumoOneOfOne>(arg4, 0x2::kiosk::list_with_purchase_cap<KumoOneOfOne>(arg4, arg5, 0x2::object::id_from_address(*0x1::vector::borrow<address>(&arg0, v0)), 0, arg13), 0x2::coin::zero<0x2::sui::SUI>(arg13));
                let v40 = v39;
                0x2::kiosk::lock<KumoOneOfOne>(arg2, arg3, arg12, v38);
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::pay<KumoOneOfOne>(arg12, &mut v40, 0x2::coin::zero<0x2::sui::SUI>(arg13));
                0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::prove<KumoOneOfOne>(&mut v40, arg2);
                let (_, _, _) = 0x2::transfer_policy::confirm_request<KumoOneOfOne>(arg12, v40);
            };
            v0 = v0 + 1;
        };
    }

    fun unequip(arg0: 0x2::object::ID, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<KumoAccessory>, arg4: &0x2::transfer_policy::TransferPolicy<KumoBackground>, arg5: &0x2::transfer_policy::TransferPolicy<KumoEyes>, arg6: &0x2::transfer_policy::TransferPolicy<KumoFurColour>, arg7: &0x2::transfer_policy::TransferPolicy<KumoMouth>, arg8: &0x2::transfer_policy::TransferPolicy<KumoTail>, arg9: &0x2::transfer_policy::TransferPolicy<KumoOneOfOne>, arg10: vector<0x1::string::String>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::string::String>(&arg10)) {
            let v1 = *0x1::vector::borrow<0x1::string::String>(&arg10, v0);
            if (v1 == 0x1::string::utf8(b"Accessory")) {
                0x2::kiosk::lock<KumoAccessory>(arg1, arg2, arg3, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoAccessory>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            } else if (v1 == 0x1::string::utf8(b"Background")) {
                0x2::kiosk::lock<KumoBackground>(arg1, arg2, arg4, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoBackground>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            } else if (v1 == 0x1::string::utf8(b"Eyes")) {
                0x2::kiosk::lock<KumoEyes>(arg1, arg2, arg5, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoEyes>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            } else if (v1 == 0x1::string::utf8(b"FurColour")) {
                0x2::kiosk::lock<KumoFurColour>(arg1, arg2, arg6, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoFurColour>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            } else if (v1 == 0x1::string::utf8(b"Mouth")) {
                0x2::kiosk::lock<KumoMouth>(arg1, arg2, arg7, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoMouth>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            } else if (v1 == 0x1::string::utf8(b"Tail")) {
                0x2::kiosk::lock<KumoTail>(arg1, arg2, arg8, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoTail>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            } else if (v1 == 0x1::string::utf8(b"OneOfOne")) {
                0x2::kiosk::lock<KumoOneOfOne>(arg1, arg2, arg9, 0x57191e5e5c41166b90a4b7811ad3ec7963708aa537a8438c1761a5d33e2155fd::kumo::unset_attribute<KumoOneOfOne>(arg0, arg1, arg2, *0x1::vector::borrow<0x1::string::String>(&arg10, v0)));
            };
            v0 = v0 + 1;
        };
    }

    public fun unlock_attribute_for_equipping<T0: store + key>(arg0: address, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x2::kiosk::purchase_with_cap<T0>(arg1, 0x2::kiosk::list_with_purchase_cap<T0>(arg1, arg2, 0x2::object::id_from_address(arg0), 0, arg3), 0x2::coin::zero<0x2::sui::SUI>(arg3))
    }

    // decompiled from Move bytecode v6
}

