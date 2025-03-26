module 0x5b3960e687d4e488ddc6385be8922f271b2437cd7f7583a27dbb0bf3330c8857::vram {
    struct Treasury has key {
        id: 0x2::object::UID,
        whitelistOf: 0x2::vec_map::VecMap<address, u64>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        publicMintTotal: u64,
        whitelistMintTotal: u64,
        imgListOf: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        imgHistoryOf: 0x2::vec_map::VecMap<u64, 0x1::string::String>,
        totalSupply: u64,
        supply: u64,
        status: bool,
        fee: u64,
    }

    struct VramNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
        b36addr: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        number_id: u64,
    }

    struct AdminUpdateFee has copy, drop {
        user: address,
        amount: u64,
    }

    struct PublicMint has copy, drop {
        user: address,
        price: u64,
    }

    struct WhitelistMint has copy, drop {
        user: address,
    }

    struct AdminSuiWithdrawn has copy, drop {
        user: address,
        amount: u64,
    }

    struct AdminUpdateSupply has copy, drop {
        user: address,
        amount: u64,
    }

    struct VRAM has drop {
        dummy_field: bool,
    }

    fun new(arg0: u64, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : VramNFT {
        let v0 = 0x2::object::new(arg4);
        VramNFT{
            id          : v0,
            name        : 0x1::string::utf8(b"VRAM OG Test"),
            image_url   : 0x1::string::utf8(b"https://i.ibb.co/Fqc3c2Xb/Whats-App-Video-2025-03-21-at-11-00-30-PM.gif"),
            description : arg1,
            b36addr     : to_b36(0x2::object::uid_to_address(&v0)),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3),
            number_id   : arg0,
        }
    }

    public entry fun add_imglist(arg0: address, arg1: 0x1::string::String, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<address, 0x1::string::String>(&arg2.imgListOf, &arg0)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut arg2.imgListOf, arg0, arg1);
        };
    }

    public entry fun add_imglist_hisotyr(arg0: u64, arg1: 0x1::string::String, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<u64, 0x1::string::String>(&arg2.imgHistoryOf, &arg0)) {
            0x2::vec_map::insert<u64, 0x1::string::String>(&mut arg2.imgHistoryOf, arg0, arg1);
        };
    }

    public entry fun add_whitelist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.whitelistOf, &arg0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.whitelistOf, arg0, 1);
        };
    }

    public entry fun admin_update_price(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg2), 0);
        arg0.fee = arg1;
        let v0 = AdminUpdateFee{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<AdminUpdateFee>(v0);
    }

    public entry fun admin_update_totalsupply(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg2), 0);
        arg0.totalSupply = arg1;
        let v0 = AdminUpdateSupply{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<AdminUpdateSupply>(v0);
    }

    public entry fun admin_withdraw(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    fun init(arg0: VRAM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VRAM>(arg0, arg1);
        let v1 = 0x2::display::new<VramNFT>(&v0, arg1);
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"VRAM OG Collection Test"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"VRAM OG is in VRAM.AI Test"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"https://i.ibb.co/Fqc3c2Xb/Whats-App-Video-2025-03-21-at-11-00-30-PM.gif"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://vram.walrus.site/?nft={b36addr}"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{number_id}"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"number_id"), 0x1::string::utf8(b"{number_id}"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<VramNFT>(&mut v1, 0x1::string::utf8(b"walrus site address"), 0x2::address::to_string(@0x52a7bf755a2c311fe6ef71ddbbebe6f4a795ac2302710ee24ad2b7f1b57ccf02));
        0x2::display::update_version<VramNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<VramNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x5b3960e687d4e488ddc6385be8922f271b2437cd7f7583a27dbb0bf3330c8857::kiosk_lock_rule::add<VramNFT>(&mut v5, &v4);
        0x5b3960e687d4e488ddc6385be8922f271b2437cd7f7583a27dbb0bf3330c8857::royalty_rule::add<VramNFT>(&mut v5, &v4, 500, 0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VramNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<VramNFT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<VramNFT>>(v5);
        let v6 = Treasury{
            id                 : 0x2::object::new(arg1),
            whitelistOf        : 0x2::vec_map::empty<address, u64>(),
            suiCoinsTreasury   : 0x2::balance::zero<0x2::sui::SUI>(),
            publicMintTotal    : 0,
            whitelistMintTotal : 0,
            imgListOf          : 0x2::vec_map::empty<address, 0x1::string::String>(),
            imgHistoryOf       : 0x2::vec_map::empty<u64, 0x1::string::String>(),
            totalSupply        : 10,
            supply             : 0,
            status             : true,
            fee                : 10000000,
        };
        0x2::transfer::share_object<Treasury>(v6);
    }

    entry fun mint(arg0: u64, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg4), 0);
        let v0 = new(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<VramNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun public_mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &0x2::transfer_policy::TransferPolicy<VramNFT>, arg6: &mut Treasury, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg2);
        assert!(v0 >= arg6.fee, 2);
        assert!(arg6.whitelistMintTotal + arg6.publicMintTotal <= arg6.totalSupply, 3);
        0x2::balance::join<0x2::sui::SUI>(&mut arg6.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg2));
        let v1 = 0x2::tx_context::sender(arg7);
        arg6.supply = arg6.supply + 1;
        let v2 = new(arg6.supply, arg1, arg3, arg4, arg7);
        let (v3, v4) = 0x2::kiosk::new(arg7);
        let v5 = v4;
        let v6 = v3;
        0x2::kiosk::lock<VramNFT>(&mut v6, &v5, arg5, v2);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, v1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
        arg6.publicMintTotal = arg6.publicMintTotal + 1;
        let v7 = PublicMint{
            user  : 0x2::tx_context::sender(arg7),
            price : v0,
        };
        0x2::event::emit<PublicMint>(v7);
    }

    public entry fun remove_imglist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg1.imgListOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut arg1.imgListOf, &arg0);
        };
    }

    public entry fun remove_whitelist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xa8125cc1a3c3d425a317d405b4089402cf0a9e20fb8a484a0f98973baec09c0b == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, u64>(&arg1.whitelistOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.whitelistOf, &arg0);
        };
    }

    public entry fun reveal_display(arg0: &mut VramNFT, arg1: &mut Treasury, arg2: bool, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::tx_context::TxContext) {
        let v0 = if (arg2) {
            arg4
        } else {
            arg3
        };
        arg0.image_url = v0;
        let v1 = 0x2::tx_context::sender(arg5);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg1.imgListOf, &v1)) {
            arg0.image_url = *0x2::vec_map::get_mut<address, 0x1::string::String>(&mut arg1.imgListOf, &v1);
        };
    }

    public entry fun reveal_update_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut Treasury, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg8.imgListOf, &v0)) {
            0x2::kiosk::borrow_mut<VramNFT>(arg5, arg6, arg7).image_url = *0x2::vec_map::get_mut<address, 0x1::string::String>(&mut arg8.imgListOf, &v0);
        };
    }

    public fun to_b36(arg0: address) : 0x1::string::String {
        let v0 = 0x2::address::to_bytes(arg0);
        let v1 = 2 * 0x1::vector::length<u8>(&v0);
        let v2 = b"0123456789abcdefghijklmnopqrstuvwxyz";
        let v3 = 0x1::vector::length<u8>(&v2);
        let v4 = b"";
        let v5 = 0;
        while (v5 < v1) {
            0x1::vector::push_back<u8>(&mut v4, 0);
            v5 = v5 + 1;
        };
        let v6 = v1 - 1;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u8>(&v0)) {
            let v8 = (*0x1::vector::borrow<u8>(&v0, v7) as u64);
            let v9 = v1 - 1;
            while (v9 > v6 || v8 != 0) {
                let v10 = v8 + 256 * (*0x1::vector::borrow<u8>(&v4, v9) as u64);
                *0x1::vector::borrow_mut<u8>(&mut v4, v9) = ((v10 % v3) as u8);
                v8 = v10 / v3;
                v9 = v9 - 1;
            };
            v6 = v9;
            v7 = v7 + 1;
        };
        let v11 = b"";
        let v12 = 0;
        let v13 = true;
        while (v12 < 0x1::vector::length<u8>(&v4)) {
            let v14 = (*0x1::vector::borrow<u8>(&v4, v12) as u64);
            if (v14 != 0 && v13) {
                v13 = false;
            };
            if (!v13) {
                0x1::vector::push_back<u8>(&mut v11, *0x1::vector::borrow<u8>(&v2, v14));
            };
            v12 = v12 + 1;
        };
        0x1::string::utf8(v11)
    }

    public entry fun update_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap, arg7: 0x2::object::ID, arg8: &mut Treasury, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::borrow_mut<VramNFT>(arg5, arg6, arg7);
        v0.name = arg0;
        v0.description = arg1;
        v0.image_url = arg2;
        v0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4);
    }

    public entry fun whitelist_mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &0x2::transfer_policy::TransferPolicy<VramNFT>, arg5: &mut Treasury, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg5.whitelistMintTotal + arg5.publicMintTotal <= arg5.totalSupply, 3);
        let v0 = 0x2::tx_context::sender(arg6);
        if (0x2::vec_map::contains<address, u64>(&arg5.whitelistOf, &v0)) {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg5.whitelistOf, &v0);
            if (*v1 == 1) {
                arg5.supply = arg5.supply + 1;
                let v2 = new(arg5.supply, arg1, arg2, arg3, arg6);
                let (v3, v4) = 0x2::kiosk::new(arg6);
                let v5 = v4;
                let v6 = v3;
                0x2::kiosk::lock<VramNFT>(&mut v6, &v5, arg4, v2);
                0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v5, v0);
                0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v6);
                arg5.whitelistMintTotal = arg5.whitelistMintTotal + 1;
                *v1 = 2;
                let v7 = WhitelistMint{user: 0x2::tx_context::sender(arg6)};
                0x2::event::emit<WhitelistMint>(v7);
            };
        };
    }

    public entry fun withdraw_collection_royalty(arg0: &mut 0x2::transfer_policy::TransferPolicy<VramNFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<VramNFT>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg2 == 0) {
            0x2::transfer_policy::withdraw<VramNFT>(arg0, arg1, 0x1::option::none<u64>(), arg4)
        } else {
            0x2::transfer_policy::withdraw<VramNFT>(arg0, arg1, 0x1::option::some<u64>(arg2), arg4)
        };
        if (0x2::tx_context::sender(arg4) == arg3) {
            0x2::pay::keep<0x2::sui::SUI>(v0, arg4);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg3);
        };
    }

    // decompiled from Move bytecode v6
}

