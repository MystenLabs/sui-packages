module 0x91c61f3336ce9ca899484e9bab4c03250077952c6584d0130949ba8ec9e101ec::ctrlv {
    struct CTRLV has drop {
        dummy_field: bool,
    }

    struct Copypasta has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        external_url: 0x2::url::Url,
        pseudonym: 0x1::string::String,
        creator: address,
        timestamp: 0x1::string::String,
    }

    struct Conf has store, key {
        id: 0x2::object::UID,
        version: u64,
        mint_cost_in_sui: u64,
        default_external_url: 0x2::url::Url,
        proceeds: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    public fun https_ctrlv_dot_onsui_dot_gg(arg0: &mut Conf, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::string::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &mut 0x2::tx_context::TxContext) : Copypasta {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.proceeds, 0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg1), arg0.mint_cost_in_sui));
        let v0 = if (0x1::ascii::length(&arg4) > 0) {
            0x2::url::new_unsafe(arg4)
        } else {
            arg0.default_external_url
        };
        let v1 = 0x2::address::to_string(0x2::tx_context::sender(arg7));
        0x1::string::append(&mut arg5, 0x1::string::utf8(b"#"));
        0x1::string::append(&mut arg5, 0x1::string::sub_string(&v1, 0, 8));
        Copypasta{
            id           : 0x2::object::new(arg7),
            name         : arg2,
            url          : 0x2::url::new_unsafe(arg3),
            external_url : v0,
            pseudonym    : arg5,
            creator      : 0x2::tx_context::sender(arg7),
            timestamp    : arg6,
        }
    }

    public entry fun increment_version(arg0: &mut Conf, arg1: &OwnerCap) {
        arg0.version = arg0.version + 1;
    }

    fun init(arg0: CTRLV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CTRLV>(arg0, arg1);
        let v1 = 0x2::display::new<Copypasta>(&v0, arg1);
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{pseudonym}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{external_url}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Ctrlv'd by {pseudonym} on {timestamp}"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"symbol"), 0x1::string::utf8(b"CTRLV"));
        0x2::display::add<Copypasta>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://ctrlv.onsui.gg"));
        let v2 = Conf{
            id                   : 0x2::object::new(arg1),
            version              : 0,
            mint_cost_in_sui     : 1000000000,
            default_external_url : 0x2::url::new_unsafe(0x1::ascii::string(b"https://ctrlv.onsui.gg")),
            proceeds             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::public_share_object<Conf>(v2);
        let v3 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<OwnerCap>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Copypasta>>(v1, 0x2::tx_context::sender(arg1));
    }

    public entry fun set_default_external_url(arg0: &mut Conf, arg1: &OwnerCap, arg2: 0x1::ascii::String) {
        arg0.default_external_url = 0x2::url::new_unsafe(arg2);
    }

    public entry fun set_mint_cost_in_sui(arg0: &mut Conf, arg1: &OwnerCap, arg2: u64) {
        arg0.mint_cost_in_sui = arg2;
    }

    public fun visit_https_ctrlv_dot_onsui_dot_gg() {
    }

    public entry fun withdraw_proceeds(arg0: &mut Conf, arg1: &OwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.proceeds), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

