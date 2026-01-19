module 0x152240cbf42906475e012ee21d76bac8328228ef2feb295cf1a22612d68fe00d::pawtato_equipment {
    struct PAWTATO_EQUIPMENT has drop {
        dummy_field: bool,
    }

    struct EQUIPMENT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        token_id: u64,
        tier: 0x1::string::String,
        equipment_type: u16,
    }

    struct EquipmentCollection has key {
        id: 0x2::object::UID,
        minted: u64,
        supply_limit: u64,
        version: u64,
        paused: bool,
    }

    struct EquipmentAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct EquipmentMinted has copy, drop {
        nft_id: 0x2::object::ID,
        token_id: u64,
        minter: address,
    }

    public entry fun admin_mint_equipment(arg0: &EquipmentAdminCap, arg1: &mut EquipmentCollection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<EQUIPMENT>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u16, arg8: 0x1::string::String, arg9: 0x1::string::String, arg10: vector<0x1::string::String>, arg11: vector<0x1::string::String>, arg12: u64, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 800);
        assert!(!arg1.paused, 801);
        if (arg1.supply_limit > 0) {
            assert!(arg1.minted + arg12 <= arg1.supply_limit, 802);
        };
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg10)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg10, v1), *0x1::vector::borrow<0x1::string::String>(&arg11, v1));
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < arg12) {
            let v3 = arg1.minted + 1;
            let v4 = EQUIPMENT{
                id             : 0x2::object::new(arg13),
                name           : arg5,
                description    : arg6,
                image_url      : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg9)),
                attributes     : v0,
                token_id       : v3,
                tier           : arg8,
                equipment_type : arg7,
            };
            0x2::kiosk::lock<EQUIPMENT>(arg2, arg3, arg4, v4);
            arg1.minted = arg1.minted + 1;
            let v5 = EquipmentMinted{
                nft_id   : 0x2::object::id<EQUIPMENT>(&v4),
                token_id : v3,
                minter   : 0x2::tx_context::sender(arg13),
            };
            0x2::event::emit<EquipmentMinted>(v5);
            v2 = v2 + 1;
        };
    }

    fun init(arg0: PAWTATO_EQUIPMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<PAWTATO_EQUIPMENT>(arg0, arg1);
        let v1 = EquipmentCollection{
            id           : 0x2::object::new(arg1),
            minted       : 0,
            supply_limit : 0,
            version      : 1,
            paused       : false,
        };
        let v2 = EquipmentAdminCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::display::new<EQUIPMENT>(&v0, arg1);
        0x2::display::add<EQUIPMENT>(&mut v3, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{token_id}"));
        0x2::display::add<EQUIPMENT>(&mut v3, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<EQUIPMENT>(&mut v3, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<EQUIPMENT>(&mut v3, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::update_version<EQUIPMENT>(&mut v3);
        let (v4, v5) = 0x2::transfer_policy::new<EQUIPMENT>(&v0, arg1);
        0x2::transfer::transfer<EquipmentAdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EQUIPMENT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<EQUIPMENT>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<EQUIPMENT>>(v4);
        0x2::transfer::share_object<EquipmentCollection>(v1);
    }

    public entry fun set_paused(arg0: &EquipmentAdminCap, arg1: &mut EquipmentCollection, arg2: bool) {
        arg1.paused = arg2;
    }

    public entry fun set_supply_limit(arg0: &EquipmentAdminCap, arg1: &mut EquipmentCollection, arg2: u64) {
        arg1.supply_limit = arg2;
    }

    public entry fun upgrade_version(arg0: &EquipmentAdminCap, arg1: &mut EquipmentCollection) {
        assert!(arg1.version < 1, 800);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

