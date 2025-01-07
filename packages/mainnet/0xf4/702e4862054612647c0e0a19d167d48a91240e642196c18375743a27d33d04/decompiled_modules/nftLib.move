module 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::nftLib {
    struct NFTLIB has drop {
        dummy_field: bool,
    }

    struct AchievementCollection has key {
        id: 0x2::object::UID,
        achievements: 0x2::vec_map::VecMap<u64, Achievement>,
    }

    struct Achievement has store {
        maxCount: u32,
        factCount: u32,
        lowerBound: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        externalUrl: 0x2::url::Url,
        achievementType: u8,
        communityId: 0x2::object::ID,
        properties: 0x2::vec_map::VecMap<u8, vector<u8>>,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        usersNFTIsMinted: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        externalUrl: 0x2::url::Url,
        achievementType: u8,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct ConfigureAchievementEvent has copy, drop {
        achievementId: u64,
    }

    struct UnlockAchievementEvent has copy, drop {
        userObjectId: 0x2::object::ID,
        achievementId: u64,
    }

    struct MintNftEvent has copy, drop {
        userObjectId: 0x2::object::ID,
        achievementId: u64,
        nftId: 0x2::object::ID,
    }

    public entry fun burn(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let NFT {
            id              : v0,
            name            : _,
            description     : _,
            url             : _,
            externalUrl     : _,
            achievementType : _,
            attributes      : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public(friend) fun configureAchievement(arg0: &mut AchievementCollection, arg1: 0x2::object::ID, arg2: u32, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: vector<u8>, arg7: u8, arg8: vector<u8>, arg9: vector<0x1::string::String>, arg10: vector<0x1::string::String>, arg11: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 < 1000000, 300);
        assert!(0x1::vector::length<0x1::string::String>(&arg9) == 0x1::vector::length<0x1::string::String>(&arg10), 301);
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::string::String>(&arg9)) {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, *0x1::vector::borrow<0x1::string::String>(&arg9, v1), *0x1::vector::borrow<0x1::string::String>(&arg10, v1));
            v1 = v1 + 1;
        };
        let v2 = Achievement{
            maxCount         : arg2,
            factCount        : 0,
            lowerBound       : arg3,
            name             : arg4,
            description      : arg5,
            url              : 0x2::url::new_unsafe_from_bytes(arg6),
            externalUrl      : 0x2::url::new_unsafe_from_bytes(arg8),
            achievementType  : arg7,
            communityId      : arg1,
            properties       : 0x2::vec_map::empty<u8, vector<u8>>(),
            attributes       : v0,
            usersNFTIsMinted : 0x2::table::new<0x2::object::ID, bool>(arg11),
        };
        let v3 = 0x2::vec_map::size<u64, Achievement>(&arg0.achievements) + 1;
        0x2::vec_map::insert<u64, Achievement>(&mut arg0.achievements, v3, v2);
        let v4 = ConfigureAchievementEvent{achievementId: v3};
        0x2::event::emit<ConfigureAchievementEvent>(v4);
    }

    public fun getAchievement(arg0: &mut AchievementCollection, arg1: u64) : &mut Achievement {
        getMutableAchievement(arg0, arg1)
    }

    public fun getAchievementTypeManual() : u8 {
        1
    }

    public fun getAchievementTypeRating() : u8 {
        0
    }

    fun getMutableAchievement(arg0: &mut AchievementCollection, arg1: u64) : &mut Achievement {
        assert!(arg1 >= 0, 302);
        assert!(0x2::vec_map::size<u64, Achievement>(&arg0.achievements) >= arg1, 303);
        0x2::vec_map::get_mut<u64, Achievement>(&mut arg0.achievements, &arg1)
    }

    fun init(arg0: NFTLIB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AchievementCollection{
            id           : 0x2::object::new(arg1),
            achievements : 0x2::vec_map::empty<u64, Achievement>(),
        };
        0x2::transfer::share_object<AchievementCollection>(v0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"Website"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{externalUrl}"));
        let v5 = 0x2::package::claim<NFTLIB>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<NFT>(&v5, v1, v3, arg1);
        0x2::display::update_version<NFT>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v6, 0x2::tx_context::sender(arg1));
    }

    fun is_achievement_available(arg0: u32, arg1: u32) : bool {
        arg0 > arg1 || arg0 == 0 && arg1 < 1000000
    }

    public(friend) fun mint(arg0: &mut AchievementCollection, arg1: 0x2::object::ID, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg2)) {
            let v1 = *0x1::vector::borrow<u64>(&arg2, v0);
            let v2 = getAchievement(arg0, v1);
            if (!0x2::table::contains<0x2::object::ID, bool>(&mut v2.usersNFTIsMinted, arg1)) {
                abort 307
            };
            let v3 = 0x2::table::borrow_mut<0x2::object::ID, bool>(&mut v2.usersNFTIsMinted, arg1);
            if (*v3) {
                abort 306
            };
            let v4 = NFT{
                id              : 0x2::object::new(arg3),
                name            : v2.name,
                description     : v2.description,
                url             : v2.url,
                externalUrl     : v2.externalUrl,
                achievementType : v2.achievementType,
                attributes      : v2.attributes,
            };
            let v5 = MintNftEvent{
                userObjectId  : arg1,
                achievementId : v1,
                nftId         : 0x2::object::id<NFT>(&v4),
            };
            0x2::event::emit<MintNftEvent>(v5);
            *v3 = true;
            0x2::transfer::public_transfer<NFT>(v4, 0x2::tx_context::sender(arg3));
            v0 = v0 + 1;
        };
    }

    public(friend) fun unlockAchievements(arg0: &mut AchievementCollection, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 1;
        while (v0 <= 0x2::vec_map::size<u64, Achievement>(&arg0.achievements)) {
            let v1 = getAchievement(arg0, v0);
            let v2 = 0;
            while (v2 < 0x1::vector::length<u8>(&arg4)) {
                let v3 = *0x1::vector::borrow<u8>(&arg4, v2);
                v2 = v2 + 1;
                if (v3 == v1.achievementType) {
                    if (v1.communityId != arg2 && v1.communityId != 0xf4702e4862054612647c0e0a19d167d48a91240e642196c18375743a27d33d04::commonLib::getZeroId()) {
                        continue
                    };
                    if (!is_achievement_available(v1.maxCount, v1.factCount)) {
                        continue
                    };
                    if (v1.lowerBound > arg3) {
                        continue
                    };
                    if (0x2::table::contains<0x2::object::ID, bool>(&mut v1.usersNFTIsMinted, arg1)) {
                        continue
                    };
                    0x2::table::add<0x2::object::ID, bool>(&mut v1.usersNFTIsMinted, arg1, false);
                    v1.factCount = v1.factCount + 1;
                    let v4 = UnlockAchievementEvent{
                        userObjectId  : arg1,
                        achievementId : v0,
                    };
                    0x2::event::emit<UnlockAchievementEvent>(v4);
                };
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun unlockManualNft(arg0: &mut AchievementCollection, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = getAchievement(arg0, arg2);
        assert!(v0.achievementType == 1, 304);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&mut v0.usersNFTIsMinted, arg1), 305);
        0x2::table::add<0x2::object::ID, bool>(&mut v0.usersNFTIsMinted, arg1, false);
        v0.factCount = v0.factCount + 1;
        let v1 = UnlockAchievementEvent{
            userObjectId  : arg1,
            achievementId : arg2,
        };
        0x2::event::emit<UnlockAchievementEvent>(v1);
    }

    public entry fun update_description(arg0: &mut NFT, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

