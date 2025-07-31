module 0xf796f522a68f63c31dee9f571db6bdac2565db114f28b143c5f361297e150f1a::number {
    struct NUMBER has drop {
        dummy_field: bool,
    }

    struct Number has store, key {
        id: 0x2::object::UID,
        name: u64,
    }

    struct NumberStore has store, key {
        id: 0x2::object::UID,
        nft_ids: vector<0x2::object::ID>,
        amounts: vector<u64>,
    }

    fun init(arg0: NUMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = NumberStore{
            id      : 0x2::object::new(arg1),
            nft_ids : 0x1::vector::empty<0x2::object::ID>(),
            amounts : 0x1::vector::empty<u64>(),
        };
        let v1 = 0x2::package::claim<NUMBER>(arg0, arg1);
        let v2 = 0x2::display::new<Number>(&v1, arg1);
        0x2::display::add<Number>(&mut v2, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Numbers"));
        0x2::display::add<Number>(&mut v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Collection of Numbers"));
        0x2::display::add<Number>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Number>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"data:image/svg+xml,%3csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3e%3crect x='10' y='10' width='80' height='80' fill='%238B0000' stroke='%235A0000' stroke-width='2'/%3e%3ctext x='50' y='50' text-anchor='middle' dominant-baseline='central' font-family='Arial, sans-serif' font-size='clamp(12px, 60px, 60px)' font-weight='bold' fill='white' textLength='60' lengthAdjust='spacingAndGlyphs'%3e{name}%3c/text%3e%3c/svg%3e"));
        0x2::display::add<Number>(&mut v2, 0x1::string::utf8(b"media_url"), 0x1::string::utf8(b"data:image/svg+xml,%3csvg width='100' height='100' viewBox='0 0 100 100' xmlns='http://www.w3.org/2000/svg'%3e%3crect x='10' y='10' width='80' height='80' fill='%238B0000' stroke='%235A0000' stroke-width='2'/%3e%3ctext x='50' y='50' text-anchor='middle' dominant-baseline='central' font-family='Arial, sans-serif' font-size='clamp(12px, 60px, 60px)' font-weight='bold' fill='white' textLength='60' lengthAdjust='spacingAndGlyphs'%3e{name}%3c/text%3e%3c/svg%3e"));
        0x2::display::update_version<Number>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Number>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Number>(&mut v6, &v5);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Number>(&mut v6, &v5, 100, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Number>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Number>>(v5, 0x2::tx_context::sender(arg1));
        let (v7, v8) = 0x2::kiosk::new(arg1);
        let v9 = v8;
        let v10 = v7;
        0x2::kiosk::set_owner(&mut v10, &v9, arg1);
        let v11 = 1;
        while (v11 <= 100) {
            let v12 = Number{
                id   : 0x2::object::new(arg1),
                name : v11,
            };
            0x1::vector::push_back<0x2::object::ID>(&mut v0.nft_ids, 0x2::object::id<Number>(&v12));
            0x1::vector::push_back<u64>(&mut v0.amounts, 10000000);
            0x2::kiosk::lock<Number>(&mut v10, &v9, &v6, v12);
            v11 = v11 + 1;
        };
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v9, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<NumberStore>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Number>>(v6);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v10);
    }

    entry fun register_and_load_ft(arg0: &NumberStore, arg1: &mut 0xf796f522a68f63c31dee9f571db6bdac2565db114f28b143c5f361297e150f1a::ft_type::Store, arg2: &mut 0x752fcae2c19de64548be8fb0438ca424309bc85ff0dabbc7c9ee4c5916d2ce40::tradeport_bridge::Manager, arg3: &mut 0x2::tx_context::TxContext) {
        0xf796f522a68f63c31dee9f571db6bdac2565db114f28b143c5f361297e150f1a::ft_type::register_bridge<Number>(arg1, arg2, arg3);
        0x752fcae2c19de64548be8fb0438ca424309bc85ff0dabbc7c9ee4c5916d2ce40::tradeport_bridge::load_bridge<Number, 0xf796f522a68f63c31dee9f571db6bdac2565db114f28b143c5f361297e150f1a::ft_type::FT_TYPE>(arg2, 0, arg0.nft_ids, arg0.amounts, arg3);
    }

    // decompiled from Move bytecode v6
}

