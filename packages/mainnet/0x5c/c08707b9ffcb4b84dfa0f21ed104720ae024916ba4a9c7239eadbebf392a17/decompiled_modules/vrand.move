module 0x5cc08707b9ffcb4b84dfa0f21ed104720ae024916ba4a9c7239eadbebf392a17::vrand {
    struct Treasury has key {
        id: 0x2::object::UID,
        whitelistOf: 0x2::vec_map::VecMap<address, u64>,
        mintedlistOf: 0x2::vec_map::VecMap<address, u64>,
        suiCoinsTreasury: 0x2::balance::Balance<0x2::sui::SUI>,
        publicMintTotal: u64,
        whitelistMintTotal: u64,
        bonusMintTotal: u64,
        imgListOf: 0x2::vec_map::VecMap<address, 0x1::string::String>,
        attrKeysListOf: 0x2::vec_map::VecMap<address, vector<0x1::string::String>>,
        attrValuesListOf: 0x2::vec_map::VecMap<address, vector<0x1::string::String>>,
        imgHistoryOf: 0x2::vec_map::VecMap<u64, 0x1::string::String>,
        totalSupply: u64,
        supply: u64,
        status: bool,
        fee: u64,
    }

    struct VrandNFT has store, key {
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

    struct BonusMint has copy, drop {
        user: address,
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

    struct VRAND has drop {
        dummy_field: bool,
    }

    fun new(arg0: u64, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : VrandNFT {
        let v0 = 0x2::object::new(arg4);
        VrandNFT{
            id          : v0,
            name        : 0x1::string::utf8(b"VRAND CHIP"),
            image_url   : 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/WtgIqQ3NBOixUUedXI-YL1jgMjKxfSrJMGNUyHiuZ1Q"),
            description : arg1,
            b36addr     : to_b36(0x2::object::uid_to_address(&v0)),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3),
            number_id   : arg0,
        }
    }

    public entry fun add_attrkeys_list(arg0: address, arg1: vector<0x1::string::String>, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg2.attrKeysListOf, &arg0)) {
            0x2::vec_map::insert<address, vector<0x1::string::String>>(&mut arg2.attrKeysListOf, arg0, arg1);
        };
    }

    public entry fun add_attrvalues_list(arg0: address, arg1: vector<0x1::string::String>, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg2.attrValuesListOf, &arg0)) {
            0x2::vec_map::insert<address, vector<0x1::string::String>>(&mut arg2.attrValuesListOf, arg0, arg1);
        };
    }

    public entry fun add_imglist(arg0: address, arg1: 0x1::string::String, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<address, 0x1::string::String>(&arg2.imgListOf, &arg0)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut arg2.imgListOf, arg0, arg1);
        };
    }

    public entry fun add_imglist_history(arg0: u64, arg1: 0x1::string::String, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<u64, 0x1::string::String>(&arg2.imgHistoryOf, &arg0)) {
            0x2::vec_map::insert<u64, 0x1::string::String>(&mut arg2.imgHistoryOf, arg0, arg1);
        };
    }

    public entry fun add_whitelist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.whitelistOf, &arg0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.whitelistOf, arg0, 1);
        };
    }

    public entry fun admin_update_price(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        arg0.fee = arg1;
        let v0 = AdminUpdateFee{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<AdminUpdateFee>(v0);
    }

    public entry fun admin_update_totalsupply(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        arg0.totalSupply = arg1;
        let v0 = AdminUpdateSupply{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<AdminUpdateSupply>(v0);
    }

    public entry fun admin_withdraw(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    public entry fun bonus_mint(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut Treasury, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == v0, 0);
        assert!(arg3.whitelistMintTotal + arg3.publicMintTotal + arg3.bonusMintTotal <= arg3.totalSupply, 3);
        if (!0x2::vec_map::contains<address, u64>(&arg3.mintedlistOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg3.mintedlistOf, v0, 1);
        } else {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg3.mintedlistOf, &v0);
            assert!(*v1 <= 10, 4);
            *v1 = *v1 + 1;
        };
        arg3.supply = arg3.supply + 1;
        0x2::transfer::public_transfer<VrandNFT>(new(arg3.supply, arg0, arg1, arg2, arg5), arg4);
        arg3.bonusMintTotal = arg3.bonusMintTotal + 1;
        let v2 = BonusMint{user: arg4};
        0x2::event::emit<BonusMint>(v2);
    }

    fun init(arg0: VRAND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VRAND>(arg0, arg1);
        let v1 = 0x2::display::new<VrandNFT>(&v0, arg1);
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"VRAND CHIP"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"The VRAND CHIP NFT Collection represents the first implementation of the Axolotl Protocol on the Sui blockchain, enabling true on-chain evolution of digital assets."));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/WtgIqQ3NBOixUUedXI-YL1jgMjKxfSrJMGNUyHiuZ1Q"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"VRAND.CHIP"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://vramai.wal.app"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"https://vramai.wal.app/?nft={b36addr}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://vramai.wal.app/?nft={b36addr}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"VRAND CHIP #{number_id}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"number_id"), 0x1::string::utf8(b"{number_id}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<VrandNFT>(&mut v1, 0x1::string::utf8(b"walrus site address"), 0x2::address::to_string(@0xb747da318c311052b21eddbd46d43a6f04c6689add62f76d58bdd9866a60f3be));
        0x2::display::update_version<VrandNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VrandNFT>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Treasury{
            id                 : 0x2::object::new(arg1),
            whitelistOf        : 0x2::vec_map::empty<address, u64>(),
            mintedlistOf       : 0x2::vec_map::empty<address, u64>(),
            suiCoinsTreasury   : 0x2::balance::zero<0x2::sui::SUI>(),
            publicMintTotal    : 0,
            whitelistMintTotal : 0,
            bonusMintTotal     : 0,
            imgListOf          : 0x2::vec_map::empty<address, 0x1::string::String>(),
            attrKeysListOf     : 0x2::vec_map::empty<address, vector<0x1::string::String>>(),
            attrValuesListOf   : 0x2::vec_map::empty<address, vector<0x1::string::String>>(),
            imgHistoryOf       : 0x2::vec_map::empty<u64, 0x1::string::String>(),
            totalSupply        : 10000,
            supply             : 0,
            status             : true,
            fee                : 100000000,
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    entry fun mint(arg0: u64, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg4), 0);
        let v0 = new(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<VrandNFT>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun public_mint(arg0: 0x1::string::String, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut Treasury, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0 >= arg4.fee, 2);
        assert!(arg4.whitelistMintTotal + arg4.publicMintTotal + arg4.bonusMintTotal <= arg4.totalSupply, 3);
        if (!0x2::vec_map::contains<address, u64>(&arg4.mintedlistOf, &v1)) {
            0x2::vec_map::insert<address, u64>(&mut arg4.mintedlistOf, v1, 1);
        } else {
            let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg4.mintedlistOf, &v1);
            assert!(*v2 <= 10, 4);
            *v2 = *v2 + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg4.supply = arg4.supply + 1;
        let v3 = new(arg4.supply, arg0, arg2, arg3, arg5);
        0x2::transfer::public_transfer<VrandNFT>(v3, v1);
        arg4.publicMintTotal = arg4.publicMintTotal + 1;
        let v4 = PublicMint{
            user  : 0x2::tx_context::sender(arg5),
            price : v0,
        };
        0x2::event::emit<PublicMint>(v4);
    }

    public entry fun remove_attrkeys_list(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg1.attrKeysListOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, vector<0x1::string::String>>(&mut arg1.attrKeysListOf, &arg0);
        };
    }

    public entry fun remove_attrvalues_list(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, vector<0x1::string::String>>(&arg1.attrValuesListOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, vector<0x1::string::String>>(&mut arg1.attrValuesListOf, &arg0);
        };
    }

    public entry fun remove_imglist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg1.imgListOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut arg1.imgListOf, &arg0);
        };
    }

    public entry fun remove_whitelist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0x7f2f424e0b808b5ef40cd15bb682ca716c02fec2e5627aed836a55441ee27427 == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, u64>(&arg1.whitelistOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.whitelistOf, &arg0);
        };
    }

    public entry fun reveal_vrand(arg0: &mut VrandNFT, arg1: &mut Treasury, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.image_url = arg2;
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

    public entry fun whitelist_mint(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut Treasury, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.whitelistMintTotal + arg3.publicMintTotal + arg3.bonusMintTotal <= arg3.totalSupply, 3);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::vec_map::contains<address, u64>(&arg3.whitelistOf, &v0)) {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg3.whitelistOf, &v0);
            if (*v1 == 1) {
                arg3.supply = arg3.supply + 1;
                let v2 = new(arg3.supply, arg0, arg1, arg2, arg4);
                0x2::transfer::public_transfer<VrandNFT>(v2, v0);
                arg3.whitelistMintTotal = arg3.whitelistMintTotal + 1;
                *v1 = 2;
                if (!0x2::vec_map::contains<address, u64>(&arg3.mintedlistOf, &v0)) {
                    0x2::vec_map::insert<address, u64>(&mut arg3.mintedlistOf, v0, 1);
                } else {
                    let v3 = 0x2::vec_map::get_mut<address, u64>(&mut arg3.mintedlistOf, &v0);
                    *v3 = *v3 + 1;
                };
                let v4 = WhitelistMint{user: 0x2::tx_context::sender(arg4)};
                0x2::event::emit<WhitelistMint>(v4);
            };
        };
    }

    // decompiled from Move bytecode v6
}

