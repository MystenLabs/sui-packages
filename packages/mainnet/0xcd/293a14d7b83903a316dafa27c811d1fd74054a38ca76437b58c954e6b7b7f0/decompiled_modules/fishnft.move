module 0xcd293a14d7b83903a316dafa27c811d1fd74054a38ca76437b58c954e6b7b7f0::fishnft {
    struct WithdrawFee has copy, drop {
        amount: u64,
    }

    struct GeneralMinted has copy, drop {
        owner: address,
        num: u64,
    }

    struct CommemorativeMinted has copy, drop {
        owner: address,
        num: u64,
    }

    struct FISHNFT has drop {
        dummy_field: bool,
    }

    struct FishAdminCap has key {
        id: 0x2::object::UID,
    }

    struct FishNFTMintInfo has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        general_minted_num: u64,
        commemorative_minted_num: u64,
        general_price: u64,
        commemorative_price: u64,
        minted_count: 0x2::vec_map::VecMap<address, u8>,
        start: u64,
    }

    struct General has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct Commemorative has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    fun init(arg0: FISHNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<FISHNFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"NORMAL #{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://fishui.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://bafybeialt42n5j3e36bmqf66yeblxpvfxcrdova6jmlli2k7mqpf4bg7hu.ipfs.nftstorage.link/normal.png"));
        let v5 = 0x2::display::new_with_fields<General>(&v0, v1, v3, arg1);
        0x2::display::update_version<General>(&mut v5);
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"MEMORIAL EDITION #{name}"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://fishui.xyz/"));
        0x1::vector::push_back<0x1::string::String>(v9, 0x1::string::utf8(b"https://bafybeicjhfimpqx3dzwdyglmxkpfvg4fp32256at56hcsqhlx7x6of2pvm.ipfs.nftstorage.link/MEMORIAL%20EDITION.png"));
        let v10 = 0x2::display::new_with_fields<Commemorative>(&v0, v6, v8, arg1);
        0x2::display::update_version<Commemorative>(&mut v10);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<General>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Commemorative>>(v10, 0x2::tx_context::sender(arg1));
        let v11 = FishAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<FishAdminCap>(v11, 0x2::tx_context::sender(arg1));
        let v12 = FishNFTMintInfo{
            id                       : 0x2::object::new(arg1),
            balance                  : 0x2::balance::zero<0x2::sui::SUI>(),
            general_minted_num       : 0,
            commemorative_minted_num : 0,
            general_price            : 10 * 1000000000,
            commemorative_price      : 50 * 1000000000,
            minted_count             : 0x2::vec_map::empty<address, u8>(),
            start                    : 0,
        };
        0x2::transfer::share_object<FishNFTMintInfo>(v12);
    }

    fun intToString(arg0: u64) : 0x1::string::String {
        let v0 = b"";
        if (arg0 > 0) {
            while (arg0 > 0) {
                let v1 = arg0 % 10;
                arg0 = arg0 / 10;
                let v2 = b"0123456789";
                0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(&v2, v1));
            };
            0x1::vector::reverse<u8>(&mut v0);
        } else {
            0x1::vector::append<u8>(&mut v0, b"0");
        };
        0x1::string::utf8(v0)
    }

    public entry fun mint_commemorative(arg0: &mut FishNFTMintInfo, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.start > 0, 0);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.start + 10800000, 1);
        if (!0x2::vec_map::contains<address, u8>(&arg0.minted_count, &v0)) {
            0x2::vec_map::insert<address, u8>(&mut arg0.minted_count, v0, 0);
        };
        let v1 = 0x2::vec_map::get_mut<address, u8>(&mut arg0.minted_count, &v0);
        assert!(*v1 <= 8 - 1, 2);
        assert!(arg0.commemorative_minted_num <= 2000 - 1, 2);
        let v2 = arg0.commemorative_minted_num + 1;
        arg0.commemorative_minted_num = arg0.commemorative_minted_num + 1;
        *v1 = *v1 + 1;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg1, arg0.commemorative_price, arg3));
        let v3 = CommemorativeMinted{
            owner : v0,
            num   : v2,
        };
        0x2::event::emit<CommemorativeMinted>(v3);
        0x2::transfer::public_transfer<Commemorative>(new_commemorative(intToString(v2), arg3), v0);
    }

    public entry fun mint_general(arg0: &mut FishNFTMintInfo, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.start > 0, 0);
        assert!(0x2::clock::timestamp_ms(arg2) <= arg0.start + 10800000, 1);
        if (!0x2::vec_map::contains<address, u8>(&arg0.minted_count, &v0)) {
            0x2::vec_map::insert<address, u8>(&mut arg0.minted_count, v0, 0);
        };
        let v1 = 0x2::vec_map::get_mut<address, u8>(&mut arg0.minted_count, &v0);
        assert!(*v1 <= 8 - 1, 2);
        assert!(arg0.general_minted_num <= 8000 - 1, 2);
        let v2 = arg0.general_minted_num + 1;
        arg0.general_minted_num = arg0.general_minted_num + 1;
        *v1 = *v1 + 1;
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::split<0x2::sui::SUI>(arg1, arg0.general_price, arg3));
        let v3 = GeneralMinted{
            owner : v0,
            num   : v2,
        };
        0x2::event::emit<GeneralMinted>(v3);
        0x2::transfer::public_transfer<General>(new_general(intToString(v2), arg3), v0);
    }

    fun new_commemorative(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : Commemorative {
        Commemorative{
            id   : 0x2::object::new(arg1),
            name : arg0,
        }
    }

    fun new_general(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) : General {
        General{
            id   : 0x2::object::new(arg1),
            name : arg0,
        }
    }

    public entry fun set_commemorative_price(arg0: &mut FishNFTMintInfo, arg1: &FishAdminCap, arg2: u64) {
        arg0.commemorative_price = 50 * 1000000000;
    }

    public entry fun set_general_price(arg0: &mut FishNFTMintInfo, arg1: &FishAdminCap, arg2: u64) {
        arg0.general_price = 10 * 1000000000;
    }

    public entry fun start_timing(arg0: &mut FishNFTMintInfo, arg1: &FishAdminCap, arg2: &0x2::clock::Clock) {
        arg0.start = 0x2::clock::timestamp_ms(arg2);
    }

    public entry fun withdraw(arg0: &mut FishNFTMintInfo, arg1: &FishAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.balance;
        assert!(0x2::balance::value<0x2::sui::SUI>(v0) >= arg2, 6);
        let v1 = WithdrawFee{amount: arg2};
        0x2::event::emit<WithdrawFee>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v0, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public entry fun withdraw_all(arg0: &mut FishNFTMintInfo, arg1: &FishAdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0.balance;
        let v1 = 0x2::balance::value<0x2::sui::SUI>(v0);
        let v2 = WithdrawFee{amount: v1};
        0x2::event::emit<WithdrawFee>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(v0, v1, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

