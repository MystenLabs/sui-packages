module 0xc6f9841c57096a59b2dc812fcf8e674922e0699244664de857ee71ee1c13b633::SuiGameNFT {
    struct SuiGameNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        degree: u64,
        subDegree: u64,
        feedTime: u64,
        hashrate: u64,
        hp: u64,
        str: u64,
        mag: u64,
        inT: u64,
        gold: u64,
        bMedalNFTs: vector<bool>,
    }

    struct MedalNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct NFTPool has store, key {
        id: 0x2::object::UID,
        addressMint: 0x2::table::Table<address, u64>,
        addressVault: address,
        addressInvite: 0x2::table::Table<address, address>,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun MintMedalNFT(arg0: &mut SuiGameNFT, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.degree >= arg1, 0);
        if (arg0.degree == arg1) {
            assert!(arg0.subDegree == arg1, 0);
        };
        let v0 = 0x1::vector::borrow_mut<bool>(&mut arg0.bMedalNFTs, arg1);
        assert!(*v0 == false, 1);
        *v0 = true;
        let v1 = MedalNFT{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"SuiGameMedalNFT"),
            description : 0x1::string::utf8(b"SuiGameMedalNFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://suitickets.netlify.app/image/claim3.png"),
        };
        if (arg1 == 1) {
            v1.name = 0x1::string::utf8(b"scorpioMedal");
        } else if (arg1 == 2) {
            v1.name = 0x1::string::utf8(b"aquariusMedal");
        } else if (arg1 == 3) {
            v1.name = 0x1::string::utf8(b"piscesMedal");
        } else if (arg1 == 4) {
            v1.name = 0x1::string::utf8(b"ariesMedal");
        } else if (arg1 == 5) {
            v1.name = 0x1::string::utf8(b"taurusMedal");
        } else if (arg1 == 6) {
            v1.name = 0x1::string::utf8(b"geminiMedal");
        } else if (arg1 == 7) {
            v1.name = 0x1::string::utf8(b"cancerMedal");
        } else if (arg1 == 8) {
            v1.name = 0x1::string::utf8(b"leoMedal");
        } else if (arg1 == 9) {
            v1.name = 0x1::string::utf8(b"virgoMedal");
        } else if (arg1 == 10) {
            v1.name = 0x1::string::utf8(b"libraMedal");
        } else if (arg1 == 11) {
            v1.name = 0x1::string::utf8(b"scorpioMedal");
        } else if (arg1 == 12) {
            v1.name = 0x1::string::utf8(b"sagittariusMedal");
        };
        0x2::transfer::public_transfer<MedalNFT>(v1, 0x2::tx_context::sender(arg2));
    }

    public entry fun feed(arg0: &mut NFTPool, arg1: &mut SuiGameNFT, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.degree <= 12, 0);
        assert!(arg1.feedTime + 10000 < 0x2::clock::timestamp_ms(arg3), 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) == 20000000000, 2);
        let v0 = 0x2::tx_context::sender(arg4);
        if (!0x2::table::contains<address, address>(&arg0.addressInvite, v0)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, arg0.addressVault);
        } else {
            let v1 = 0x2::table::borrow<address, address>(&arg0.addressInvite, v0);
            if (!0x2::table::contains<address, address>(&arg0.addressInvite, *v1)) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 20000000000 * 90 / 100, arg4), arg0.addressVault);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, *v1);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 20000000000 * 85 / 100, arg4), arg0.addressVault);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, 20000000000 * 10 / 100, arg4), *v1);
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, *0x2::table::borrow<address, address>(&arg0.addressInvite, *v1));
            };
        };
        arg1.subDegree = arg1.subDegree + 1;
        if (arg1.subDegree >= arg1.degree) {
            arg1.degree = arg1.degree + 1;
            arg1.subDegree = 0;
        };
        arg1.hp = arg1.hp + 1;
        arg1.str = arg1.str + 1;
        arg1.mag = arg1.mag + 10;
        arg1.inT = arg1.inT + 10;
        arg1.gold = arg1.gold + 2;
        if (arg1.hp >= 10) {
            arg1.hp = 10;
        };
        if (arg1.str >= 100) {
            arg1.str = 100;
        };
        if (arg1.mag >= 1000) {
            arg1.mag = 1000;
        };
        if (arg1.inT >= 1000) {
            arg1.inT = 1000;
        };
        if (arg1.gold >= 100) {
            arg1.gold = 100;
        };
        arg1.feedTime = 0x2::clock::timestamp_ms(arg3);
    }

    public fun getHashrateByTokenId(arg0: &SuiGameNFT) : u64 {
        arg0.hashrate
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFTPool{
            id            : 0x2::object::new(arg0),
            addressMint   : 0x2::table::new<address, u64>(arg0),
            addressVault  : 0x2::tx_context::sender(arg0),
            addressInvite : 0x2::table::new<address, address>(arg0),
        };
        0x2::transfer::share_object<NFTPool>(v0);
    }

    public entry fun mint(arg0: &mut NFTPool, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = msgSender(arg1);
        if (!0x2::table::contains<address, u64>(&arg0.addressMint, v0)) {
            0x2::table::add<address, u64>(&mut arg0.addressMint, v0, 0);
        };
        let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.addressMint, v0);
        assert!(*v1 < 20, 0);
        *v1 = *v1 + 1;
        let v2 = SuiGameNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiGameNFT"),
            description : 0x1::string::utf8(b"SuiGameNFT"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://suitickets.netlify.app/image/claim3.png"),
            degree      : 0,
            subDegree   : 0,
            feedTime    : 0,
            hashrate    : 1,
            hp          : 0xc6f9841c57096a59b2dc812fcf8e674922e0699244664de857ee71ee1c13b633::random::rand_u64_range(1, 10, arg1),
            str         : 0xc6f9841c57096a59b2dc812fcf8e674922e0699244664de857ee71ee1c13b633::random::rand_u64_range(1, 100, arg1),
            mag         : 0xc6f9841c57096a59b2dc812fcf8e674922e0699244664de857ee71ee1c13b633::random::rand_u64_range(100, 1000, arg1),
            inT         : 0xc6f9841c57096a59b2dc812fcf8e674922e0699244664de857ee71ee1c13b633::random::rand_u64_range(100, 1000, arg1),
            gold        : 0xc6f9841c57096a59b2dc812fcf8e674922e0699244664de857ee71ee1c13b633::random::rand_u64_range(1, 100, arg1),
            bMedalNFTs  : 0x1::vector::empty<bool>(),
        };
        let v3 = 0;
        while (v3 < 12) {
            0x1::vector::push_back<bool>(&mut v2.bMedalNFTs, false);
            v3 = v3 + 1;
        };
        let v4 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v2.id),
            creator   : v0,
            name      : v2.name,
        };
        0x2::event::emit<MintNFTEvent>(v4);
        0x2::transfer::public_transfer<SuiGameNFT>(v2, v0);
    }

    public entry fun mintInvite(arg0: &mut NFTPool, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, u64>(&arg0.addressMint, v0), 0);
        mint(arg0, arg2);
        if (!0x2::table::contains<address, address>(&arg0.addressInvite, v0)) {
            0x2::table::add<address, address>(&mut arg0.addressInvite, v0, arg1);
        };
    }

    fun msgSender(arg0: &0x2::tx_context::TxContext) : address {
        0x2::tx_context::sender(arg0)
    }

    // decompiled from Move bytecode v6
}

