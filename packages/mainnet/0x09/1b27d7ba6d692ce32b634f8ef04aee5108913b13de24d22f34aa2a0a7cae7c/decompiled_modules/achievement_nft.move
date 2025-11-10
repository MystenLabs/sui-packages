module 0x91b27d7ba6d692ce32b634f8ef04aee5108913b13de24d22f34aa2a0a7cae7c::achievement_nft {
    struct ACHIEVEMENT_NFT has drop {
        dummy_field: bool,
    }

    struct AchievementNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
        achievement_type: 0x1::string::String,
        rarity: u8,
        earned_at: u64,
        game_id: 0x1::option::Option<0x2::object::ID>,
        player: address,
    }

    struct MinterCap has store, key {
        id: 0x2::object::UID,
    }

    struct AchievementConfig has drop, store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        rarity: u8,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        achievement_type: 0x1::string::String,
        rarity: u8,
        earned_at: u64,
    }

    struct NFTBurned has copy, drop {
        nft_id: 0x2::object::ID,
        achievement_type: 0x1::string::String,
        burned_by: address,
    }

    public fun burn(arg0: AchievementNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let AchievementNFT {
            id               : v0,
            name             : _,
            description      : _,
            image_url        : _,
            achievement_type : v4,
            rarity           : _,
            earned_at        : _,
            game_id          : _,
            player           : _,
        } = arg0;
        let v9 = v0;
        let v10 = NFTBurned{
            nft_id           : 0x2::object::uid_to_inner(&v9),
            achievement_type : v4,
            burned_by        : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTBurned>(v10);
        0x2::object::delete(v9);
    }

    fun get_achievement_config(arg0: &0x1::string::String) : AchievementConfig {
        let v0 = 0x1::string::utf8(b"first_win");
        let v1 = 0x1::string::utf8(b"ten_wins");
        let v2 = 0x1::string::utf8(b"fifty_wins");
        let v3 = 0x1::string::utf8(b"hundred_wins");
        let v4 = 0x1::string::utf8(b"perfect_game");
        let v5 = 0x1::string::utf8(b"speed_demon");
        let v6 = 0x1::string::utf8(b"comeback_king");
        let v7 = 0x1::string::utf8(b"domino_master");
        if (arg0 == &v0) {
            AchievementConfig{name: 0x1::string::utf8(b"First Victory"), description: 0x1::string::utf8(b"Won your first game!"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/first_win.png"), rarity: 1}
        } else if (arg0 == &v1) {
            AchievementConfig{name: 0x1::string::utf8(b"10 Victories"), description: 0x1::string::utf8(b"Accumulated 10 victories"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/ten_wins.png"), rarity: 1}
        } else if (arg0 == &v2) {
            AchievementConfig{name: 0x1::string::utf8(b"50 Victories"), description: 0x1::string::utf8(b"Accumulated 50 victories"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/fifty_wins.png"), rarity: 2}
        } else if (arg0 == &v3) {
            AchievementConfig{name: 0x1::string::utf8(b"100 Victories"), description: 0x1::string::utf8(b"Accumulated 100 victories"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/hundred_wins.png"), rarity: 3}
        } else if (arg0 == &v4) {
            AchievementConfig{name: 0x1::string::utf8(b"Perfect Game"), description: 0x1::string::utf8(b"Won without opponent scoring"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/perfect_game.png"), rarity: 3}
        } else if (arg0 == &v5) {
            AchievementConfig{name: 0x1::string::utf8(b"Speed Demon"), description: 0x1::string::utf8(b"Won a game in under 2 minutes"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/speed_demon.png"), rarity: 2}
        } else if (arg0 == &v6) {
            AchievementConfig{name: 0x1::string::utf8(b"Comeback King"), description: 0x1::string::utf8(b"Won after being behind by 50+ points"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/comeback_king.png"), rarity: 3}
        } else if (arg0 == &v7) {
            AchievementConfig{name: 0x1::string::utf8(b"Domino Master"), description: 0x1::string::utf8(b"Reached 1000 total victories"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/domino_master.png"), rarity: 4}
        } else {
            AchievementConfig{name: 0x1::string::utf8(b"Unknown Achievement"), description: 0x1::string::utf8(b"A mysterious achievement"), image_url: 0x1::string::utf8(b"https://cdn.domino.game/nft/unknown.png"), rarity: 1}
        }
    }

    public fun get_achievement_type(arg0: &AchievementNFT) : &0x1::string::String {
        &arg0.achievement_type
    }

    public fun get_game_id(arg0: &AchievementNFT) : &0x1::option::Option<0x2::object::ID> {
        &arg0.game_id
    }

    public fun get_image_url(arg0: &AchievementNFT) : &0x2::url::Url {
        &arg0.image_url
    }

    public fun get_nft_info(arg0: &AchievementNFT) : (0x1::string::String, 0x1::string::String, u8, u64, address) {
        (arg0.name, arg0.achievement_type, arg0.rarity, arg0.earned_at, arg0.player)
    }

    public fun get_rarity(arg0: &AchievementNFT) : u8 {
        arg0.rarity
    }

    fun init(arg0: ACHIEVEMENT_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ACHIEVEMENT_NFT>(arg0, arg1);
        let v2 = 0x2::display::new<AchievementNFT>(&v1, arg1);
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://domino.game"));
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Domino Game"));
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"achievement_type"), 0x1::string::utf8(b"{achievement_type}"));
        0x2::display::add<AchievementNFT>(&mut v2, 0x1::string::utf8(b"rarity"), 0x1::string::utf8(b"{rarity}"));
        0x2::display::update_version<AchievementNFT>(&mut v2);
        let v3 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<AchievementNFT>>(v2, v0);
        0x2::transfer::public_transfer<MinterCap>(v3, v0);
    }

    public fun mint(arg0: &MinterCap, arg1: address, arg2: 0x1::string::String, arg3: 0x1::option::Option<0x2::object::ID>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = get_achievement_config(&arg2);
        assert!(v0.rarity >= 1 && v0.rarity <= 4, 0);
        let v1 = AchievementNFT{
            id               : 0x2::object::new(arg5),
            name             : v0.name,
            description      : v0.description,
            image_url        : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&v0.image_url)),
            achievement_type : arg2,
            rarity           : v0.rarity,
            earned_at        : arg4,
            game_id          : arg3,
            player           : arg1,
        };
        let v2 = NFTMinted{
            nft_id           : 0x2::object::id<AchievementNFT>(&v1),
            recipient        : arg1,
            achievement_type : v1.achievement_type,
            rarity           : v0.rarity,
            earned_at        : arg4,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<AchievementNFT>(v1, arg1);
    }

    public fun rarity_to_string(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"Common")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"Rare")
        } else if (arg0 == 3) {
            0x1::string::utf8(b"Epic")
        } else if (arg0 == 4) {
            0x1::string::utf8(b"Legendary")
        } else {
            0x1::string::utf8(b"Unknown")
        }
    }

    public fun transfer_minter_cap(arg0: MinterCap, arg1: address) {
        0x2::transfer::public_transfer<MinterCap>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

