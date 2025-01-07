module 0xf1e7b4093872df432b2adb50533a1fa6f9e4b20856217657242fe7d9d4ac42e8::ethos_squad {
    struct ETHOS_SQUAD has drop {
        dummy_field: bool,
    }

    struct EthosSquad<phantom T0> has store, key {
        id: 0x2::object::UID,
        nft: u64,
    }

    struct EthosSquad1 has drop {
        dummy_field: bool,
    }

    struct EthosSquad2 has drop {
        dummy_field: bool,
    }

    struct EthosSquad3 has drop {
        dummy_field: bool,
    }

    struct EthosSquad4 has drop {
        dummy_field: bool,
    }

    struct EthosSquad5 has drop {
        dummy_field: bool,
    }

    struct EthosSquad6 has drop {
        dummy_field: bool,
    }

    struct EthosSquad7 has drop {
        dummy_field: bool,
    }

    struct EthosSquad8 has drop {
        dummy_field: bool,
    }

    struct EthosSquad9 has drop {
        dummy_field: bool,
    }

    struct EthosSquad10 has drop {
        dummy_field: bool,
    }

    struct EthosSquad11 has drop {
        dummy_field: bool,
    }

    struct EthosSquad12 has drop {
        dummy_field: bool,
    }

    struct EthosSquad13 has drop {
        dummy_field: bool,
    }

    struct EthosSquad14 has drop {
        dummy_field: bool,
    }

    struct EthosSquad15 has drop {
        dummy_field: bool,
    }

    struct EthosSquad16 has drop {
        dummy_field: bool,
    }

    struct EthosSquad17 has drop {
        dummy_field: bool,
    }

    struct EthosSquad18 has drop {
        dummy_field: bool,
    }

    struct EthosSquad19 has drop {
        dummy_field: bool,
    }

    struct EthosSquad20 has drop {
        dummy_field: bool,
    }

    struct EthosSquadMaintainer has key {
        id: 0x2::object::UID,
        maintainer_address: address,
        nft_count: u64,
        fee: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun change_fee(arg0: &mut EthosSquadMaintainer, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.fee = arg1;
    }

    public entry fun change_maintainer(arg0: &mut EthosSquadMaintainer, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.maintainer_address, 1);
        arg0.maintainer_address = arg1;
    }

    public fun count<T0>(arg0: &EthosSquad<T0>) : &u64 {
        &arg0.nft
    }

    public(friend) fun create_maintainer(arg0: &mut 0x2::tx_context::TxContext) : EthosSquadMaintainer {
        EthosSquadMaintainer{
            id                 : 0x2::object::new(arg0),
            maintainer_address : 0x2::tx_context::sender(arg0),
            nft_count          : 0,
            fee                : 200000000,
            balance            : 0x2::balance::zero<0x2::sui::SUI>(),
        }
    }

    fun get_description(arg0: u8) : 0x1::string::String {
        if (arg0 == 1 || arg0 == 10) {
            return 0x1::string::utf8(b"Bonezy, the mischievous skull with a toothy grin and an insatiable appetite for puns.")
        };
        if (arg0 == 2 || arg0 == 11) {
            return 0x1::string::utf8(b"Chirp, the plucky one-eyed bird who always keeps a lookout for the tastiest worms and never misses a beat with her cheerful chirping.")
        };
        if (arg0 == 3 || arg0 == 12) {
            return 0x1::string::utf8(b"Ethmaus, a playful pup whose wagging tail and whimsical expressions bring joy to all who meet him!")
        };
        if (arg0 == 4 || arg0 == 13) {
            return 0x1::string::utf8(b"Fred, the zany inventor who always has a new gadget up his sleeve and a mischievous twinkle in his eye.")
        };
        if (arg0 == 5 || arg0 == 14) {
            return 0x1::string::utf8(b"Loupe, the carefree sunflower who always turns her face towards the light.")
        };
        if (arg0 == 6 || arg0 == 15) {
            return 0x1::string::utf8(b"Mimi, the mischievous feline who loves to play hide and seek, especially when it involves stealing socks.")
        };
        if (arg0 == 7 || arg0 == 16) {
            return 0x1::string::utf8(b"Mystie OK, the whimsical mouse with a flair for the mysterious, who loves to set out on adventures in search of hidden treasures.")
        };
        if (arg0 == 8 || arg0 == 17) {
            return 0x1::string::utf8(b"Nano, the curious and adventurous Martian who loves to explore new planets, gather samples, and solve mysteries about the universe.")
        };
        if (arg0 == 9 || arg0 == 18) {
            return 0x1::string::utf8(b"Suive, the lovable bovine with a heart of gold, who enjoys nothing more than grazing in the fields and singing her favorite songs to the moo-n.")
        };
        0x1::string::utf8(b"The forgotten member of the Ethos Squad.")
    }

    fun get_image_url(arg0: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"https://ethos-nft.s3.us-east-2.amazonaws.com/");
        0x1::string::append(&mut v0, get_name(arg0));
        0x1::string::append(&mut v0, 0x1::string::utf8(b".gif"));
        v0
    }

    fun get_name(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            return 0x1::string::utf8(b"Bonezy")
        };
        if (arg0 == 2) {
            return 0x1::string::utf8(b"Chirp")
        };
        if (arg0 == 3) {
            return 0x1::string::utf8(b"Ethmaus")
        };
        if (arg0 == 4) {
            return 0x1::string::utf8(b"Fred")
        };
        if (arg0 == 5) {
            return 0x1::string::utf8(b"Loupe The Flower")
        };
        if (arg0 == 6) {
            return 0x1::string::utf8(b"Mimi The Cat")
        };
        if (arg0 == 7) {
            return 0x1::string::utf8(b"Mystie OK")
        };
        if (arg0 == 8) {
            return 0x1::string::utf8(b"Nano The Mars")
        };
        if (arg0 == 9) {
            return 0x1::string::utf8(b"Suive")
        };
        if (arg0 == 10) {
            return 0x1::string::utf8(b"Ethos Bonezy")
        };
        if (arg0 == 11) {
            return 0x1::string::utf8(b"Ethos Chirp")
        };
        if (arg0 == 12) {
            return 0x1::string::utf8(b"Ethos Ethmaus")
        };
        if (arg0 == 13) {
            return 0x1::string::utf8(b"Ethos Fred")
        };
        if (arg0 == 14) {
            return 0x1::string::utf8(b"Ethos Loupe The Flower")
        };
        if (arg0 == 15) {
            return 0x1::string::utf8(b"Ethos Mimi The Cat")
        };
        if (arg0 == 16) {
            return 0x1::string::utf8(b"Ethos Mystie OK")
        };
        if (arg0 == 17) {
            return 0x1::string::utf8(b"Ethos Nano The Mars")
        };
        if (arg0 == 18) {
            return 0x1::string::utf8(b"Ethos Suive")
        };
        0x1::string::utf8(b"Squad")
    }

    fun init(arg0: ETHOS_SQUAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"{nft}");
        let v1 = 0x1::string::utf8(b"Ethos Squad");
        let v2 = 0x1::string::utf8(b"https://ethoswallet.xyz/dashboard");
        let v3 = 0x1::string::utf8(b"https://ethos-nft.s3.us-east-2.amazonaws.com/Mint_an_NFT.jpg");
        let v4 = 0x1::string::utf8(b"A collection of friends to accompany you on the Ethos and SUI adventure!");
        let v5 = 0x1::string::utf8(b"Ethos");
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = &mut v6;
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_name"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_image_url"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"project_description"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"nft"));
        0x1::vector::push_back<0x1::string::String>(v7, 0x1::string::utf8(b"creator"));
        let v8 = 0x2::package::claim<ETHOS_SQUAD>(arg0, arg1);
        let v9 = 0x1::vector::empty<0x1::string::String>();
        let v10 = &mut v9;
        0x1::vector::push_back<0x1::string::String>(v10, get_name(1));
        0x1::vector::push_back<0x1::string::String>(v10, get_image_url(1));
        0x1::vector::push_back<0x1::string::String>(v10, get_description(1));
        0x1::vector::push_back<0x1::string::String>(v10, v2);
        0x1::vector::push_back<0x1::string::String>(v10, v1);
        0x1::vector::push_back<0x1::string::String>(v10, v3);
        0x1::vector::push_back<0x1::string::String>(v10, v4);
        0x1::vector::push_back<0x1::string::String>(v10, v0);
        0x1::vector::push_back<0x1::string::String>(v10, v5);
        let v11 = 0x2::display::new_with_fields<EthosSquad<EthosSquad1>>(&v8, v6, v9, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad1>>(&mut v11);
        let v12 = 0x1::vector::empty<0x1::string::String>();
        let v13 = &mut v12;
        0x1::vector::push_back<0x1::string::String>(v13, get_name(2));
        0x1::vector::push_back<0x1::string::String>(v13, get_image_url(2));
        0x1::vector::push_back<0x1::string::String>(v13, get_description(2));
        0x1::vector::push_back<0x1::string::String>(v13, v2);
        0x1::vector::push_back<0x1::string::String>(v13, v1);
        0x1::vector::push_back<0x1::string::String>(v13, v3);
        0x1::vector::push_back<0x1::string::String>(v13, v4);
        0x1::vector::push_back<0x1::string::String>(v13, v0);
        0x1::vector::push_back<0x1::string::String>(v13, v5);
        let v14 = 0x2::display::new_with_fields<EthosSquad<EthosSquad2>>(&v8, v6, v12, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad2>>(&mut v14);
        let v15 = 0x1::vector::empty<0x1::string::String>();
        let v16 = &mut v15;
        0x1::vector::push_back<0x1::string::String>(v16, get_name(3));
        0x1::vector::push_back<0x1::string::String>(v16, get_image_url(3));
        0x1::vector::push_back<0x1::string::String>(v16, get_description(3));
        0x1::vector::push_back<0x1::string::String>(v16, v2);
        0x1::vector::push_back<0x1::string::String>(v16, v1);
        0x1::vector::push_back<0x1::string::String>(v16, v3);
        0x1::vector::push_back<0x1::string::String>(v16, v4);
        0x1::vector::push_back<0x1::string::String>(v16, v0);
        0x1::vector::push_back<0x1::string::String>(v16, v5);
        let v17 = 0x2::display::new_with_fields<EthosSquad<EthosSquad3>>(&v8, v6, v15, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad3>>(&mut v17);
        let v18 = 0x1::vector::empty<0x1::string::String>();
        let v19 = &mut v18;
        0x1::vector::push_back<0x1::string::String>(v19, get_name(4));
        0x1::vector::push_back<0x1::string::String>(v19, get_image_url(4));
        0x1::vector::push_back<0x1::string::String>(v19, get_description(4));
        0x1::vector::push_back<0x1::string::String>(v19, v2);
        0x1::vector::push_back<0x1::string::String>(v19, v1);
        0x1::vector::push_back<0x1::string::String>(v19, v3);
        0x1::vector::push_back<0x1::string::String>(v19, v4);
        0x1::vector::push_back<0x1::string::String>(v19, v0);
        0x1::vector::push_back<0x1::string::String>(v19, v5);
        let v20 = 0x2::display::new_with_fields<EthosSquad<EthosSquad4>>(&v8, v6, v18, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad4>>(&mut v20);
        let v21 = 0x1::vector::empty<0x1::string::String>();
        let v22 = &mut v21;
        0x1::vector::push_back<0x1::string::String>(v22, get_name(5));
        0x1::vector::push_back<0x1::string::String>(v22, get_image_url(5));
        0x1::vector::push_back<0x1::string::String>(v22, get_description(5));
        0x1::vector::push_back<0x1::string::String>(v22, v2);
        0x1::vector::push_back<0x1::string::String>(v22, v1);
        0x1::vector::push_back<0x1::string::String>(v22, v3);
        0x1::vector::push_back<0x1::string::String>(v22, v4);
        0x1::vector::push_back<0x1::string::String>(v22, v0);
        0x1::vector::push_back<0x1::string::String>(v22, v5);
        let v23 = 0x2::display::new_with_fields<EthosSquad<EthosSquad5>>(&v8, v6, v21, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad5>>(&mut v23);
        let v24 = 0x1::vector::empty<0x1::string::String>();
        let v25 = &mut v24;
        0x1::vector::push_back<0x1::string::String>(v25, get_name(6));
        0x1::vector::push_back<0x1::string::String>(v25, get_image_url(6));
        0x1::vector::push_back<0x1::string::String>(v25, get_description(6));
        0x1::vector::push_back<0x1::string::String>(v25, v2);
        0x1::vector::push_back<0x1::string::String>(v25, v1);
        0x1::vector::push_back<0x1::string::String>(v25, v3);
        0x1::vector::push_back<0x1::string::String>(v25, v4);
        0x1::vector::push_back<0x1::string::String>(v25, v0);
        0x1::vector::push_back<0x1::string::String>(v25, v5);
        let v26 = 0x2::display::new_with_fields<EthosSquad<EthosSquad6>>(&v8, v6, v24, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad6>>(&mut v26);
        let v27 = 0x1::vector::empty<0x1::string::String>();
        let v28 = &mut v27;
        0x1::vector::push_back<0x1::string::String>(v28, get_name(7));
        0x1::vector::push_back<0x1::string::String>(v28, get_image_url(7));
        0x1::vector::push_back<0x1::string::String>(v28, get_description(7));
        0x1::vector::push_back<0x1::string::String>(v28, v2);
        0x1::vector::push_back<0x1::string::String>(v28, v1);
        0x1::vector::push_back<0x1::string::String>(v28, v3);
        0x1::vector::push_back<0x1::string::String>(v28, v4);
        0x1::vector::push_back<0x1::string::String>(v28, v0);
        0x1::vector::push_back<0x1::string::String>(v28, v5);
        let v29 = 0x2::display::new_with_fields<EthosSquad<EthosSquad7>>(&v8, v6, v27, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad7>>(&mut v29);
        let v30 = 0x1::vector::empty<0x1::string::String>();
        let v31 = &mut v30;
        0x1::vector::push_back<0x1::string::String>(v31, get_name(8));
        0x1::vector::push_back<0x1::string::String>(v31, get_image_url(8));
        0x1::vector::push_back<0x1::string::String>(v31, get_description(8));
        0x1::vector::push_back<0x1::string::String>(v31, v2);
        0x1::vector::push_back<0x1::string::String>(v31, v1);
        0x1::vector::push_back<0x1::string::String>(v31, v3);
        0x1::vector::push_back<0x1::string::String>(v31, v4);
        0x1::vector::push_back<0x1::string::String>(v31, v0);
        0x1::vector::push_back<0x1::string::String>(v31, v5);
        let v32 = 0x2::display::new_with_fields<EthosSquad<EthosSquad8>>(&v8, v6, v30, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad8>>(&mut v32);
        let v33 = 0x1::vector::empty<0x1::string::String>();
        let v34 = &mut v33;
        0x1::vector::push_back<0x1::string::String>(v34, get_name(9));
        0x1::vector::push_back<0x1::string::String>(v34, get_image_url(9));
        0x1::vector::push_back<0x1::string::String>(v34, get_description(9));
        0x1::vector::push_back<0x1::string::String>(v34, v2);
        0x1::vector::push_back<0x1::string::String>(v34, v1);
        0x1::vector::push_back<0x1::string::String>(v34, v3);
        0x1::vector::push_back<0x1::string::String>(v34, v4);
        0x1::vector::push_back<0x1::string::String>(v34, v0);
        0x1::vector::push_back<0x1::string::String>(v34, v5);
        let v35 = 0x2::display::new_with_fields<EthosSquad<EthosSquad9>>(&v8, v6, v33, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad9>>(&mut v35);
        let v36 = 0x1::vector::empty<0x1::string::String>();
        let v37 = &mut v36;
        0x1::vector::push_back<0x1::string::String>(v37, get_name(10));
        0x1::vector::push_back<0x1::string::String>(v37, get_image_url(10));
        0x1::vector::push_back<0x1::string::String>(v37, get_description(10));
        0x1::vector::push_back<0x1::string::String>(v37, v2);
        0x1::vector::push_back<0x1::string::String>(v37, v1);
        0x1::vector::push_back<0x1::string::String>(v37, v3);
        0x1::vector::push_back<0x1::string::String>(v37, v4);
        0x1::vector::push_back<0x1::string::String>(v37, v0);
        0x1::vector::push_back<0x1::string::String>(v37, v5);
        let v38 = 0x2::display::new_with_fields<EthosSquad<EthosSquad10>>(&v8, v6, v36, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad10>>(&mut v38);
        let v39 = 0x1::vector::empty<0x1::string::String>();
        let v40 = &mut v39;
        0x1::vector::push_back<0x1::string::String>(v40, get_name(11));
        0x1::vector::push_back<0x1::string::String>(v40, get_image_url(11));
        0x1::vector::push_back<0x1::string::String>(v40, get_description(11));
        0x1::vector::push_back<0x1::string::String>(v40, v2);
        0x1::vector::push_back<0x1::string::String>(v40, v1);
        0x1::vector::push_back<0x1::string::String>(v40, v3);
        0x1::vector::push_back<0x1::string::String>(v40, v4);
        0x1::vector::push_back<0x1::string::String>(v40, v0);
        0x1::vector::push_back<0x1::string::String>(v40, v5);
        let v41 = 0x2::display::new_with_fields<EthosSquad<EthosSquad11>>(&v8, v6, v39, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad11>>(&mut v41);
        let v42 = 0x1::vector::empty<0x1::string::String>();
        let v43 = &mut v42;
        0x1::vector::push_back<0x1::string::String>(v43, get_name(12));
        0x1::vector::push_back<0x1::string::String>(v43, get_image_url(12));
        0x1::vector::push_back<0x1::string::String>(v43, get_description(12));
        0x1::vector::push_back<0x1::string::String>(v43, v2);
        0x1::vector::push_back<0x1::string::String>(v43, v1);
        0x1::vector::push_back<0x1::string::String>(v43, v3);
        0x1::vector::push_back<0x1::string::String>(v43, v4);
        0x1::vector::push_back<0x1::string::String>(v43, v0);
        0x1::vector::push_back<0x1::string::String>(v43, v5);
        let v44 = 0x2::display::new_with_fields<EthosSquad<EthosSquad12>>(&v8, v6, v42, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad12>>(&mut v44);
        let v45 = 0x1::vector::empty<0x1::string::String>();
        let v46 = &mut v45;
        0x1::vector::push_back<0x1::string::String>(v46, get_name(13));
        0x1::vector::push_back<0x1::string::String>(v46, get_image_url(13));
        0x1::vector::push_back<0x1::string::String>(v46, get_description(13));
        0x1::vector::push_back<0x1::string::String>(v46, v2);
        0x1::vector::push_back<0x1::string::String>(v46, v1);
        0x1::vector::push_back<0x1::string::String>(v46, v3);
        0x1::vector::push_back<0x1::string::String>(v46, v4);
        0x1::vector::push_back<0x1::string::String>(v46, v0);
        0x1::vector::push_back<0x1::string::String>(v46, v5);
        let v47 = 0x2::display::new_with_fields<EthosSquad<EthosSquad13>>(&v8, v6, v45, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad13>>(&mut v47);
        let v48 = 0x1::vector::empty<0x1::string::String>();
        let v49 = &mut v48;
        0x1::vector::push_back<0x1::string::String>(v49, get_name(14));
        0x1::vector::push_back<0x1::string::String>(v49, get_image_url(14));
        0x1::vector::push_back<0x1::string::String>(v49, get_description(14));
        0x1::vector::push_back<0x1::string::String>(v49, v2);
        0x1::vector::push_back<0x1::string::String>(v49, v1);
        0x1::vector::push_back<0x1::string::String>(v49, v3);
        0x1::vector::push_back<0x1::string::String>(v49, v4);
        0x1::vector::push_back<0x1::string::String>(v49, v0);
        0x1::vector::push_back<0x1::string::String>(v49, v5);
        let v50 = 0x2::display::new_with_fields<EthosSquad<EthosSquad14>>(&v8, v6, v48, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad14>>(&mut v50);
        let v51 = 0x1::vector::empty<0x1::string::String>();
        let v52 = &mut v51;
        0x1::vector::push_back<0x1::string::String>(v52, get_name(15));
        0x1::vector::push_back<0x1::string::String>(v52, get_image_url(15));
        0x1::vector::push_back<0x1::string::String>(v52, get_description(15));
        0x1::vector::push_back<0x1::string::String>(v52, v2);
        0x1::vector::push_back<0x1::string::String>(v52, v1);
        0x1::vector::push_back<0x1::string::String>(v52, v3);
        0x1::vector::push_back<0x1::string::String>(v52, v4);
        0x1::vector::push_back<0x1::string::String>(v52, v0);
        0x1::vector::push_back<0x1::string::String>(v52, v5);
        let v53 = 0x2::display::new_with_fields<EthosSquad<EthosSquad15>>(&v8, v6, v51, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad15>>(&mut v53);
        let v54 = 0x1::vector::empty<0x1::string::String>();
        let v55 = &mut v54;
        0x1::vector::push_back<0x1::string::String>(v55, get_name(16));
        0x1::vector::push_back<0x1::string::String>(v55, get_image_url(16));
        0x1::vector::push_back<0x1::string::String>(v55, get_description(16));
        0x1::vector::push_back<0x1::string::String>(v55, v2);
        0x1::vector::push_back<0x1::string::String>(v55, v1);
        0x1::vector::push_back<0x1::string::String>(v55, v3);
        0x1::vector::push_back<0x1::string::String>(v55, v4);
        0x1::vector::push_back<0x1::string::String>(v55, v0);
        0x1::vector::push_back<0x1::string::String>(v55, v5);
        let v56 = 0x2::display::new_with_fields<EthosSquad<EthosSquad16>>(&v8, v6, v54, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad16>>(&mut v56);
        let v57 = 0x1::vector::empty<0x1::string::String>();
        let v58 = &mut v57;
        0x1::vector::push_back<0x1::string::String>(v58, get_name(17));
        0x1::vector::push_back<0x1::string::String>(v58, get_image_url(17));
        0x1::vector::push_back<0x1::string::String>(v58, get_description(17));
        0x1::vector::push_back<0x1::string::String>(v58, v2);
        0x1::vector::push_back<0x1::string::String>(v58, v1);
        0x1::vector::push_back<0x1::string::String>(v58, v3);
        0x1::vector::push_back<0x1::string::String>(v58, v4);
        0x1::vector::push_back<0x1::string::String>(v58, v0);
        0x1::vector::push_back<0x1::string::String>(v58, v5);
        let v59 = 0x2::display::new_with_fields<EthosSquad<EthosSquad17>>(&v8, v6, v57, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad17>>(&mut v59);
        let v60 = 0x1::vector::empty<0x1::string::String>();
        let v61 = &mut v60;
        0x1::vector::push_back<0x1::string::String>(v61, get_name(18));
        0x1::vector::push_back<0x1::string::String>(v61, get_image_url(18));
        0x1::vector::push_back<0x1::string::String>(v61, get_description(18));
        0x1::vector::push_back<0x1::string::String>(v61, v2);
        0x1::vector::push_back<0x1::string::String>(v61, v1);
        0x1::vector::push_back<0x1::string::String>(v61, v3);
        0x1::vector::push_back<0x1::string::String>(v61, v4);
        0x1::vector::push_back<0x1::string::String>(v61, v0);
        0x1::vector::push_back<0x1::string::String>(v61, v5);
        let v62 = 0x2::display::new_with_fields<EthosSquad<EthosSquad18>>(&v8, v6, v60, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad18>>(&mut v62);
        let v63 = 0x1::vector::empty<0x1::string::String>();
        let v64 = &mut v63;
        0x1::vector::push_back<0x1::string::String>(v64, get_name(19));
        0x1::vector::push_back<0x1::string::String>(v64, get_image_url(19));
        0x1::vector::push_back<0x1::string::String>(v64, get_description(19));
        0x1::vector::push_back<0x1::string::String>(v64, v2);
        0x1::vector::push_back<0x1::string::String>(v64, v1);
        0x1::vector::push_back<0x1::string::String>(v64, v3);
        0x1::vector::push_back<0x1::string::String>(v64, v4);
        0x1::vector::push_back<0x1::string::String>(v64, v0);
        0x1::vector::push_back<0x1::string::String>(v64, v5);
        let v65 = 0x2::display::new_with_fields<EthosSquad<EthosSquad19>>(&v8, v6, v63, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad19>>(&mut v65);
        let v66 = 0x1::vector::empty<0x1::string::String>();
        let v67 = &mut v66;
        0x1::vector::push_back<0x1::string::String>(v67, get_name(20));
        0x1::vector::push_back<0x1::string::String>(v67, get_image_url(20));
        0x1::vector::push_back<0x1::string::String>(v67, get_description(20));
        0x1::vector::push_back<0x1::string::String>(v67, v2);
        0x1::vector::push_back<0x1::string::String>(v67, v1);
        0x1::vector::push_back<0x1::string::String>(v67, v3);
        0x1::vector::push_back<0x1::string::String>(v67, v4);
        0x1::vector::push_back<0x1::string::String>(v67, v0);
        0x1::vector::push_back<0x1::string::String>(v67, v5);
        let v68 = 0x2::display::new_with_fields<EthosSquad<EthosSquad20>>(&v8, v6, v66, arg1);
        0x2::display::update_version<EthosSquad<EthosSquad20>>(&mut v68);
        let v69 = create_maintainer(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad1>>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad2>>>(v14, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad3>>>(v17, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad4>>>(v20, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad5>>>(v23, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad6>>>(v26, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad7>>>(v29, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad8>>>(v32, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad9>>>(v35, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad10>>>(v38, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad11>>>(v41, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad12>>>(v44, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad13>>>(v47, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad14>>>(v50, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad15>>>(v53, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad16>>>(v56, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad17>>>(v59, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad18>>>(v62, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad19>>>(v65, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<EthosSquad<EthosSquad20>>>(v68, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<EthosSquadMaintainer>(v69);
    }

    fun merge_and_split(arg0: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x1::vector::pop_back<0x2::coin::Coin<0x2::sui::SUI>>(&mut arg0);
        0x2::pay::join_vec<0x2::sui::SUI>(&mut v0, arg0);
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&v0);
        assert!(v1 >= arg1, v1);
        (0x2::coin::split<0x2::sui::SUI>(&mut v0, arg1, arg2), v0)
    }

    public entry fun mint_to_sender(arg0: &mut EthosSquadMaintainer, arg1: vector<0x2::coin::Coin<0x2::sui::SUI>>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let (v1, v2) = merge_and_split(arg1, arg0.fee, arg2);
        0x2::coin::put<0x2::sui::SUI>(&mut arg0.balance, v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, v0);
        let v3 = 0x2::object::new(arg2);
        let v4 = 0x2::object::uid_to_bytes(&v3);
        let v5 = (*0x1::vector::borrow<u8>(&v4, 1) % 2 * 10 + *0x1::vector::borrow<u8>(&v4, 0) % 10) % 18 + 1;
        if (v5 == 1) {
            let v6 = EthosSquad<EthosSquad1>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v7 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad1>>(&v6),
                creator   : v0,
                name      : get_name(1),
            };
            0x2::event::emit<NFTMinted>(v7);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad1>>(v6, v0);
        } else if (v5 == 2) {
            let v8 = EthosSquad<EthosSquad2>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v9 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad2>>(&v8),
                creator   : v0,
                name      : get_name(2),
            };
            0x2::event::emit<NFTMinted>(v9);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad2>>(v8, v0);
        } else if (v5 == 3) {
            let v10 = EthosSquad<EthosSquad3>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v11 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad3>>(&v10),
                creator   : v0,
                name      : get_name(3),
            };
            0x2::event::emit<NFTMinted>(v11);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad3>>(v10, v0);
        } else if (v5 == 4) {
            let v12 = EthosSquad<EthosSquad4>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v13 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad4>>(&v12),
                creator   : v0,
                name      : get_name(4),
            };
            0x2::event::emit<NFTMinted>(v13);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad4>>(v12, v0);
        } else if (v5 == 5) {
            let v14 = EthosSquad<EthosSquad5>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v15 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad5>>(&v14),
                creator   : v0,
                name      : get_name(5),
            };
            0x2::event::emit<NFTMinted>(v15);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad5>>(v14, v0);
        } else if (v5 == 6) {
            let v16 = EthosSquad<EthosSquad6>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v17 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad6>>(&v16),
                creator   : v0,
                name      : get_name(6),
            };
            0x2::event::emit<NFTMinted>(v17);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad6>>(v16, v0);
        } else if (v5 == 7) {
            let v18 = EthosSquad<EthosSquad7>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v19 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad7>>(&v18),
                creator   : v0,
                name      : get_name(7),
            };
            0x2::event::emit<NFTMinted>(v19);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad7>>(v18, v0);
        } else if (v5 == 8) {
            let v20 = EthosSquad<EthosSquad8>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v21 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad8>>(&v20),
                creator   : v0,
                name      : get_name(8),
            };
            0x2::event::emit<NFTMinted>(v21);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad8>>(v20, v0);
        } else if (v5 == 9) {
            let v22 = EthosSquad<EthosSquad9>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v23 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad9>>(&v22),
                creator   : v0,
                name      : get_name(9),
            };
            0x2::event::emit<NFTMinted>(v23);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad9>>(v22, v0);
        } else if (v5 == 10) {
            let v24 = EthosSquad<EthosSquad10>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v25 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad10>>(&v24),
                creator   : v0,
                name      : get_name(10),
            };
            0x2::event::emit<NFTMinted>(v25);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad10>>(v24, v0);
        } else if (v5 == 11) {
            let v26 = EthosSquad<EthosSquad11>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v27 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad11>>(&v26),
                creator   : v0,
                name      : get_name(11),
            };
            0x2::event::emit<NFTMinted>(v27);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad11>>(v26, v0);
        } else if (v5 == 12) {
            let v28 = EthosSquad<EthosSquad12>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v29 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad12>>(&v28),
                creator   : v0,
                name      : get_name(12),
            };
            0x2::event::emit<NFTMinted>(v29);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad12>>(v28, v0);
        } else if (v5 == 13) {
            let v30 = EthosSquad<EthosSquad13>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v31 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad13>>(&v30),
                creator   : v0,
                name      : get_name(13),
            };
            0x2::event::emit<NFTMinted>(v31);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad13>>(v30, v0);
        } else if (v5 == 14) {
            let v32 = EthosSquad<EthosSquad14>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v33 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad14>>(&v32),
                creator   : v0,
                name      : get_name(14),
            };
            0x2::event::emit<NFTMinted>(v33);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad14>>(v32, v0);
        } else if (v5 == 15) {
            let v34 = EthosSquad<EthosSquad15>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v35 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad15>>(&v34),
                creator   : v0,
                name      : get_name(15),
            };
            0x2::event::emit<NFTMinted>(v35);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad15>>(v34, v0);
        } else if (v5 == 16) {
            let v36 = EthosSquad<EthosSquad16>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v37 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad16>>(&v36),
                creator   : v0,
                name      : get_name(16),
            };
            0x2::event::emit<NFTMinted>(v37);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad16>>(v36, v0);
        } else if (v5 == 17) {
            let v38 = EthosSquad<EthosSquad17>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v39 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad17>>(&v38),
                creator   : v0,
                name      : get_name(17),
            };
            0x2::event::emit<NFTMinted>(v39);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad17>>(v38, v0);
        } else if (v5 == 18) {
            let v40 = EthosSquad<EthosSquad18>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v41 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad18>>(&v40),
                creator   : v0,
                name      : get_name(18),
            };
            0x2::event::emit<NFTMinted>(v41);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad18>>(v40, v0);
        } else if (v5 == 19) {
            let v42 = EthosSquad<EthosSquad19>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v43 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad19>>(&v42),
                creator   : v0,
                name      : get_name(19),
            };
            0x2::event::emit<NFTMinted>(v43);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad19>>(v42, v0);
        } else {
            let v44 = EthosSquad<EthosSquad20>{
                id  : v3,
                nft : arg0.nft_count + 1,
            };
            let v45 = NFTMinted{
                object_id : 0x2::object::id<EthosSquad<EthosSquad20>>(&v44),
                creator   : v0,
                name      : get_name(20),
            };
            0x2::event::emit<NFTMinted>(v45);
            0x2::transfer::public_transfer<EthosSquad<EthosSquad20>>(v44, v0);
        };
        arg0.nft_count = arg0.nft_count + 1;
    }

    public entry fun pay_maintainer(arg0: &mut EthosSquadMaintainer, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.maintainer_address, 1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.balance);
        assert!(v0 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg0.balance, v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

