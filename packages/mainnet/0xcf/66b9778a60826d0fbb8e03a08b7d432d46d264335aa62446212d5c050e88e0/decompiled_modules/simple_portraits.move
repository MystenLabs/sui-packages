module 0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::simple_portraits {
    struct SIMPLE_PORTRAITS has drop {
        dummy_field: bool,
    }

    struct PortraitNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        mint_number: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun create_collection(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg1),
            mint_supply : arg0,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg1),
        }
    }

    public fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) : (0x2::kiosk::Kiosk, 0x2::kiosk::KioskOwnerCap) {
        0x2::kiosk::new(arg0)
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun init(arg0: SIMPLE_PORTRAITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SIMPLE_PORTRAITS>(arg0, arg1);
        let v1 = 0x2::display::new<PortraitNFT>(&v0, arg1);
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<PortraitNFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<PortraitNFT>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<PortraitNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::add_personal_kiosk_rule<PortraitNFT>(&mut v5, &v4);
        0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::add_kiosk_lock_rule<PortraitNFT>(&mut v5, &v4);
        0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::add_royalty_rule<PortraitNFT>(&mut v5, &v4, 0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::new_royalty_config(100, 0));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PortraitNFT>>(v5);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PortraitNFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer_to_kiosk(arg0: &mut Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &mut 0x2::transfer_policy::TransferPolicy<PortraitNFT>, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: address, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.mint_supply, 1);
        assert!(arg0.creator == 0x2::tx_context::sender(arg9), 2);
        arg0.minted = arg0.minted + 1;
        let v0 = PortraitNFT{
            id          : 0x2::object::new(arg9),
            name        : arg4,
            description : arg5,
            image_url   : arg6,
            creator     : arg0.creator,
            mint_number : arg0.minted,
        };
        0x2::kiosk::place<PortraitNFT>(arg1, arg2, v0);
        let v1 = 0x2::transfer_policy::new_request<PortraitNFT>(0x2::object::id<PortraitNFT>(&v0), 0x2::coin::value<0x2::sui::SUI>(&arg8), 0x2::object::id_from_address(arg7));
        0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::prove_personal_kiosk_rule<PortraitNFT>(arg1, arg3, &mut v1);
        0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::prove_kiosk_lock_rule<PortraitNFT>(arg1, arg3, &mut v1);
        0xcf66b9778a60826d0fbb8e03a08b7d432d46d264335aa62446212d5c050e88e0::rules::pay_royalty_rule<PortraitNFT>(arg3, &mut v1, arg8);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<PortraitNFT>(arg3, v1);
    }

    public fun mint_nft_to_kiosk(arg0: &mut Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted < arg0.mint_supply, 1);
        assert!(arg0.creator == 0x2::tx_context::sender(arg6), 2);
        arg0.minted = arg0.minted + 1;
        let v0 = PortraitNFT{
            id          : 0x2::object::new(arg6),
            name        : arg3,
            description : arg4,
            image_url   : arg5,
            creator     : arg0.creator,
            mint_number : arg0.minted,
        };
        0x2::kiosk::place<PortraitNFT>(arg1, arg2, v0);
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        assert!(arg0.minted <= arg1, 1);
        arg0.mint_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

