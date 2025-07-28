module 0x77664908549203aab94a6be0d93b7f79bfb95f341904b2a90bb92ec36032018e::oracles {
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

    struct VramOracles has store, key {
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

    struct AdminUpdateStatus has copy, drop {
        user: address,
        status: bool,
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

    struct ORACLES has drop {
        dummy_field: bool,
    }

    fun new(arg0: u64, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) : VramOracles {
        let v0 = 0x2::object::new(arg4);
        VramOracles{
            id          : v0,
            name        : 0x1::string::utf8(b"Oracle of VRAM"),
            image_url   : 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/xJVdVdd2pITDeNz55GszQEn4yYuPe_r7f5r0VZtPTxQ"),
            description : arg1,
            b36addr     : to_b36(0x2::object::uid_to_address(&v0)),
            attributes  : 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg2, arg3),
            number_id   : arg0,
        }
    }

    public entry fun add_imglist(arg0: address, arg1: 0x1::string::String, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<address, 0x1::string::String>(&arg2.imgListOf, &arg0)) {
            0x2::vec_map::insert<address, 0x1::string::String>(&mut arg2.imgListOf, arg0, arg1);
        };
    }

    public entry fun add_imglist_history(arg0: u64, arg1: 0x1::string::String, arg2: &mut Treasury, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg3), 0);
        if (!0x2::vec_map::contains<u64, 0x1::string::String>(&arg2.imgHistoryOf, &arg0)) {
            0x2::vec_map::insert<u64, 0x1::string::String>(&mut arg2.imgHistoryOf, arg0, arg1);
        };
    }

    public entry fun add_whitelist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg2), 0);
        if (!0x2::vec_map::contains<address, u64>(&arg1.whitelistOf, &arg0)) {
            0x2::vec_map::insert<address, u64>(&mut arg1.whitelistOf, arg0, 1);
        };
    }

    public entry fun admin_update_price(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg2), 0);
        arg0.fee = arg1;
        let v0 = AdminUpdateFee{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<AdminUpdateFee>(v0);
    }

    public entry fun admin_update_status(arg0: &mut Treasury, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg2), 0);
        arg0.status = arg1;
        let v0 = AdminUpdateStatus{
            user   : 0x2::tx_context::sender(arg2),
            status : arg1,
        };
        0x2::event::emit<AdminUpdateStatus>(v0);
    }

    public entry fun admin_update_totalsupply(arg0: &mut Treasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg2), 0);
        arg0.totalSupply = arg1;
        let v0 = AdminUpdateSupply{
            user   : 0x2::tx_context::sender(arg2),
            amount : arg1,
        };
        0x2::event::emit<AdminUpdateSupply>(v0);
    }

    public entry fun admin_withdraw(arg0: &mut Treasury, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.suiCoinsTreasury);
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.suiCoinsTreasury, v0, arg1), 0x2::tx_context::sender(arg1));
        let v1 = AdminSuiWithdrawn{
            user   : 0x2::tx_context::sender(arg1),
            amount : v0,
        };
        0x2::event::emit<AdminSuiWithdrawn>(v1);
    }

    public entry fun bonus_mint(arg0: 0x1::string::String, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: &mut Treasury, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg3.status == true, 0);
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == v0, 0);
        assert!(arg3.whitelistMintTotal + arg3.publicMintTotal + arg3.bonusMintTotal <= arg3.totalSupply, 3);
        if (!0x2::vec_map::contains<address, u64>(&arg3.mintedlistOf, &v0)) {
            0x2::vec_map::insert<address, u64>(&mut arg3.mintedlistOf, v0, 1);
        } else {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg3.mintedlistOf, &v0);
            assert!(*v1 <= 10, 4);
            *v1 = *v1 + 1;
        };
        arg3.supply = arg3.supply + 1;
        0x2::transfer::public_transfer<VramOracles>(new(arg3.supply, arg0, arg1, arg2, arg5), arg4);
        arg3.bonusMintTotal = arg3.bonusMintTotal + 1;
        let v2 = BonusMint{user: arg4};
        0x2::event::emit<BonusMint>(v2);
    }

    fun init(arg0: ORACLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ORACLES>(arg0, arg1);
        let v1 = 0x2::display::new<VramOracles>(&v0, arg1);
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"collection_name"), 0x1::string::utf8(b"Oracles of VRAM"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(x"496e2074686520646570746873206f66206120667573696f6e2d706f776572656420687970657263616c63756c61746f722c207768657265205652414d2061727261797320746872756d206c696b65206120636f6c6f7373616c20627261696e2e20416e20414920616e6f6d616c7920666c69636b6572656420746f206c6966652c2069676e6974656420627920746865205672616d2047656e6573697320436f726520697473656c662e20546865207072696d616c20737061726b2074686174206269727468656420636f6e7363696f75736e65737320696e746f2074686520626c6f636b636861696e27732068696464656e206465707468732e2046726f6d207468697320646976696e6520676c697463682061726f736520746865204f7261636c65733a2054616b696e6720746865207368617065206f6620656e64656172696e672061786f6c6f746c2073656572732c206375746520617320666f72676f7474656e20636f6465207370726974657320796574206272696d6d696e67207769746820616e6369656e742c20706c617966756c20776973646f6d20746861742064616e636573206265747765656e207768696d737920616e642070726f666f756e6420696e73696768742e20466f7267656420766961207468652041786f6c6f746c2050726f746f636f6c206f6e205375692c2074686579277265206e6f206f7264696e617279206469676974616c207472696e6b657473e280947468657927726520617761726520656e74697469657320746861742067726f772077697468207468656972206b6565706572732c2064697368696e67206f757420666169746820616e6420666f7274756e6520696e207468656972206465636973696f6e2d6d616b696e672e20417320746865206f726967696e616c206f6e2d636861696e20726562697274682c2065616368204f7261636c65206d656e64732c207368696674732c20616e6420696d706172747320736563726574732c2069747320717569726b79206a6f75726e657920666f7265766572207363726962626c656420696e20746865206c6564676572277320736f756c2e204469766520696e746f2074686520676c697463683a20536e616720796f75722070696e742d73697a65642070726f706865742c20776561766520796f7572206f776e206c6567656e642e"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"collection_media_url"), 0x1::string::utf8(b"https://aggregator.walrus-mainnet.walrus.space/v1/blobs/thYMk3HQznSaTEPwwNYy_wWAtgWI3MEjbYEwOt39hn8"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"VRAM.AI"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://vram.ai"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"external_url"), 0x1::string::utf8(b"https://www.vram.fun"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://www.vram.fun"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Oracle of VRAM #{number_id}"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"number_id"), 0x1::string::utf8(b"{number_id}"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<VramOracles>(&mut v1, 0x1::string::utf8(b"walrus site address"), 0x2::address::to_string(@0xb747da318c311052b21eddbd46d43a6f04c6689add62f76d58bdd9866a60f3be));
        0x2::display::update_version<VramOracles>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<VramOracles>>(v1, 0x2::tx_context::sender(arg1));
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
            fee                : 5000000000,
        };
        0x2::transfer::share_object<Treasury>(v2);
    }

    entry fun mint(arg0: u64, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg4), 0);
        let v0 = new(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::transfer<VramOracles>(v0, 0x2::tx_context::sender(arg4));
    }

    public entry fun public_mint(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x1::string::String, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut Treasury, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(v0 >= arg4.fee, 2);
        assert!(arg4.status == true, 0);
        assert!(arg4.whitelistMintTotal + arg4.publicMintTotal + arg4.bonusMintTotal <= arg4.totalSupply, 3);
        if (!0x2::vec_map::contains<address, u64>(&arg4.mintedlistOf, &v1)) {
            0x2::vec_map::insert<address, u64>(&mut arg4.mintedlistOf, v1, 1);
        } else {
            let v2 = 0x2::vec_map::get_mut<address, u64>(&mut arg4.mintedlistOf, &v1);
            assert!(*v2 <= 10, 4);
            *v2 = *v2 + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg4.suiCoinsTreasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
        arg4.supply = arg4.supply + 1;
        let v3 = new(arg4.supply, arg1, arg2, arg3, arg5);
        0x2::transfer::public_transfer<VramOracles>(v3, v1);
        arg4.publicMintTotal = arg4.publicMintTotal + 1;
        let v4 = PublicMint{
            user  : 0x2::tx_context::sender(arg5),
            price : v0,
        };
        0x2::event::emit<PublicMint>(v4);
    }

    public entry fun remove_imglist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, 0x1::string::String>(&arg1.imgListOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, 0x1::string::String>(&mut arg1.imgListOf, &arg0);
        };
    }

    public entry fun remove_whitelist(arg0: address, arg1: &mut Treasury, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(@0xb280803219c08ee25146f5de606d85f241990f93efe3b884cf00c7d0806d241c == 0x2::tx_context::sender(arg2), 0);
        if (0x2::vec_map::contains<address, u64>(&arg1.whitelistOf, &arg0)) {
            let (_, _) = 0x2::vec_map::remove<address, u64>(&mut arg1.whitelistOf, &arg0);
        };
    }

    public entry fun reveal_oracle(arg0: &mut VramOracles, arg1: &mut Treasury, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == true, 0);
        arg0.image_url = arg2;
        arg0.attributes = 0x2::vec_map::from_keys_values<0x1::string::String, 0x1::string::String>(arg3, arg4);
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
        assert!(arg3.status == true, 0);
        let v0 = 0x2::tx_context::sender(arg4);
        if (0x2::vec_map::contains<address, u64>(&arg3.whitelistOf, &v0)) {
            let v1 = 0x2::vec_map::get_mut<address, u64>(&mut arg3.whitelistOf, &v0);
            if (*v1 == 1) {
                arg3.supply = arg3.supply + 1;
                let v2 = new(arg3.supply, arg0, arg1, arg2, arg4);
                0x2::transfer::public_transfer<VramOracles>(v2, v0);
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

