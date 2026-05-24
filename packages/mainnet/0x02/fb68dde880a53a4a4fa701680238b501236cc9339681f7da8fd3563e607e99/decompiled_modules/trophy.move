module 0x3a3e0155ea8abd741d36c6a4602d0d8c3b697614412d252dcf17b6cf81a74886::trophy {
    struct TROPHY has drop {
        dummy_field: bool,
    }

    struct WinnerTrophy has store, key {
        id: 0x2::object::UID,
        sale_id: 0x1::string::String,
        auction_id: 0x1::string::String,
        display_lot: u64,
        wine_title: 0x1::string::String,
        metadata_url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct WinnerTrophySoulbound has key {
        id: 0x2::object::UID,
        sale_id: 0x1::string::String,
        auction_id: 0x1::string::String,
        display_lot: u64,
        wine_title: 0x1::string::String,
        metadata_url: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    struct Registry has store, key {
        id: 0x2::object::UID,
        minted_sale_ids: 0x2::table::Table<0x1::string::String, bool>,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct TrophyMinted has copy, drop {
        sale_id: 0x1::string::String,
        trophy_id: 0x2::object::ID,
        recipient: address,
    }

    public fun configure_soulbound_display(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::display::new_with_fields<WinnerTrophySoulbound>(arg0, trophy_display_keys(), trophy_display_values(), arg1);
        0x2::display::update_version<WinnerTrophySoulbound>(&mut v0);
        0x2::transfer::public_transfer<0x2::display::Display<WinnerTrophySoulbound>>(v0, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: TROPHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<TROPHY>(arg0, arg1);
        let v1 = Registry{
            id              : 0x2::object::new(arg1),
            minted_sale_ids : 0x2::table::new<0x1::string::String, bool>(arg1),
        };
        let v2 = MintCap{id: 0x2::object::new(arg1)};
        let v3 = 0x2::display::new_with_fields<WinnerTrophy>(&v0, trophy_display_keys(), trophy_display_values(), arg1);
        0x2::display::update_version<WinnerTrophy>(&mut v3);
        0x2::transfer::public_transfer<0x2::display::Display<WinnerTrophy>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<Registry>(v1);
        0x2::transfer::public_transfer<MintCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: &MintCap, arg1: &mut Registry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: address, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::string::length(&arg2) > 0, 2);
        assert!(0x1::string::length(&arg3) > 0, 2);
        assert!(!0x2::table::contains<0x1::string::String, bool>(&arg1.minted_sale_ids, arg2), 1);
        let v0 = WinnerTrophySoulbound{
            id           : 0x2::object::new(arg9),
            sale_id      : arg2,
            auction_id   : arg3,
            display_lot  : arg4,
            wine_title   : arg5,
            metadata_url : arg6,
            image_url    : arg7,
        };
        0x2::table::add<0x1::string::String, bool>(&mut arg1.minted_sale_ids, v0.sale_id, true);
        let v1 = TrophyMinted{
            sale_id   : v0.sale_id,
            trophy_id : 0x2::object::id<WinnerTrophySoulbound>(&v0),
            recipient : arg8,
        };
        0x2::event::emit<TrophyMinted>(v1);
        0x2::transfer::transfer<WinnerTrophySoulbound>(v0, arg8);
    }

    fun trophy_display_keys() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        v0
    }

    fun trophy_display_values() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(x"7b77696e655f7469746c657d20e28094204c6f74207b646973706c61795f6c6f747d"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Treasure secured on VinoBid HK"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"{metadata_url}"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"https://vino-bid.com"));
        v0
    }

    // decompiled from Move bytecode v7
}

