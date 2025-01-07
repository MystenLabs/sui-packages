module 0x420b560c293374b3775080b1aaa176e0716d592feffab1e8b7ee5e76a2f7bfa6::zombie_house {
    struct ZOMBIE_HOUSE has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct ZombieNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        token_id: u64,
    }

    struct ZombieInfo has copy, drop, store {
        zombie_owner: address,
        zombie_id: u32,
        level: u8,
        type: u8,
    }

    struct GameInfo has key {
        id: 0x2::object::UID,
        owner: address,
        game_master: address,
        domain: 0x1::string::String,
        sig_verify_pk: vector<u8>,
        zombies: vector<ZombieInfo>,
        zpt_pot: 0x2::balance::Balance<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>,
        price_token_per_zombie: u64,
        max_zombie_per_player: u64,
        current_nft_index: u64,
        earned_zpt_amt: u64,
        claim_nonce: u64,
        airdrop_amount: u64,
        airdrop_status: u8,
        claimed_users: vector<address>,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct PayerBuyZombies has copy, drop {
        player: address,
        zombie_ids: vector<u32>,
        zombie_types: vector<u8>,
    }

    struct PlayerClaimedEarnedZPT has copy, drop {
        player: address,
        amount: u64,
        nonce: u64,
    }

    public entry fun buy_zombie(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(arg2 != 0, 4);
        let v1 = arg2 * arg0.price_token_per_zombie;
        assert!(0x2::coin::value<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&arg1) >= v1, 5);
        assert!(verify_types_sig(arg3, arg0.current_nft_index, arg0.sig_verify_pk, arg4) == true, 10);
        assert!(get_zombie_amount(&arg0.zombies, v0) < arg0.max_zombie_per_player, 7);
        let v2 = 0x2::coin::into_balance<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>>(0x2::coin::take<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut v2, 0x2::coin::value<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&arg1) - v1, arg5), v0);
        0x2::balance::join<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut arg0.zpt_pot, v2);
        arg0.earned_zpt_amt = arg0.earned_zpt_amt + v1;
        let v3 = 0x1::vector::empty<u32>();
        let v4 = 0;
        while (v4 < arg2) {
            let v5 = *0x1::vector::borrow<u8>(&arg3, v4);
            arg0.current_nft_index = arg0.current_nft_index + 1;
            let v6 = ZombieInfo{
                zombie_owner : v0,
                zombie_id    : (arg0.current_nft_index as u32),
                level        : 1,
                type         : v5,
            };
            0x1::vector::push_back<ZombieInfo>(&mut arg0.zombies, v6);
            mint_nft(get_nft_name(v5), 0x1::string::utf8(b"This is a Zombie NFT which mines ZBS coins."), get_nft_uri(arg0.domain, v5), arg0.current_nft_index, arg5);
            0x1::vector::push_back<u32>(&mut v3, (arg0.current_nft_index as u32));
            v4 = v4 + 1;
        };
        let v7 = PayerBuyZombies{
            player       : v0,
            zombie_ids   : v3,
            zombie_types : arg3,
        };
        0x2::event::emit<PayerBuyZombies>(v7);
    }

    public entry fun claim_earned_zpt(arg0: &mut GameInfo, arg1: u64, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(verify_claim_sig(arg1, arg0.claim_nonce, arg0.sig_verify_pk, arg2), 10);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1 < 0x2::balance::value<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&arg0.zpt_pot), 9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>>(0x2::coin::take<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut arg0.zpt_pot, arg1, arg3), v0);
        arg0.claim_nonce = arg0.claim_nonce + 1;
        let v1 = PlayerClaimedEarnedZPT{
            player : v0,
            amount : arg1,
            nonce  : arg0.claim_nonce,
        };
        0x2::event::emit<PlayerClaimedEarnedZPT>(v1);
    }

    public entry fun deposit_zpt(arg0: &mut GameInfo, arg1: 0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.owner, 1);
        let v1 = 0x2::coin::into_balance<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>>(0x2::coin::take<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut v1, 0x2::coin::value<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&arg1) - arg2, arg3), v0);
        0x2::balance::join<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut arg0.zpt_pot, v1);
    }

    public entry fun get_airdrop(arg0: &mut GameInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(arg0.airdrop_status == 1, 12);
        assert!(!0x1::vector::contains<address>(&arg0.claimed_users, &v0), 11);
        assert!(arg0.airdrop_amount <= 0x2::balance::value<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&arg0.zpt_pot), 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>>(0x2::coin::take<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut arg0.zpt_pot, arg0.airdrop_amount, arg1), v0);
        0x1::vector::push_back<address>(&mut arg0.claimed_users, v0);
    }

    fun get_nft_name(arg0: u8) : 0x1::string::String {
        if (arg0 > 4) {
            arg0 = 4;
        };
        let v0 = vector[b"Baby", b"Butcher", b"Clown", b"Police", b"Priate"];
        let v1 = 0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&mut v0, (arg0 as u64)));
        0x1::string::append(&mut v1, 0x1::string::utf8(b" Zombie NFT"));
        v1
    }

    fun get_nft_uri(arg0: 0x1::string::String, arg1: u8) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0");
        if (arg1 == 1) {
            v0 = 0x1::string::utf8(b"1");
        };
        if (arg1 == 2) {
            v0 = 0x1::string::utf8(b"2");
        };
        if (arg1 == 3) {
            v0 = 0x1::string::utf8(b"3");
        };
        if (arg1 == 4) {
            v0 = 0x1::string::utf8(b"4");
        };
        0x1::string::append(&mut arg0, v0);
        arg0
    }

    fun get_zombie_amount(arg0: &vector<ZombieInfo>, arg1: address) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<ZombieInfo>(arg0)) {
            if (0x1::vector::borrow<ZombieInfo>(arg0, v0).zombie_owner == arg1) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun init(arg0: ZOMBIE_HOUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ZOMBIE_HOUSE>(arg0, arg1);
        let v2 = 0x2::display::new<ZombieNFT>(&v1, arg1);
        0x2::display::add<ZombieNFT>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<ZombieNFT>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<ZombieNFT>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://{url}"));
        0x2::display::update_version<ZombieNFT>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<ZombieNFT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        let v3 = GameInfo{
            id                     : 0x2::object::new(arg1),
            owner                  : v0,
            game_master            : v0,
            domain                 : 0x1::string::utf8(b"gateway.pinata.cloud/ipfs/QmR7vqrR3eHuW2LmJq7P5i915M6pvHqoJmcQrdunDEYL4j/"),
            sig_verify_pk          : 0x1::vector::empty<u8>(),
            zombies                : 0x1::vector::empty<ZombieInfo>(),
            zpt_pot                : 0x2::balance::zero<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(),
            price_token_per_zombie : 1000 * 1000000000,
            max_zombie_per_player  : 20,
            current_nft_index      : 0,
            earned_zpt_amt         : 0,
            claim_nonce            : 0,
            airdrop_amount         : 1000000000000,
            airdrop_status         : 1,
            claimed_users          : 0x1::vector::empty<address>(),
        };
        0x2::transfer::share_object<GameInfo>(v3);
    }

    public entry fun master_mint_zombie(arg0: &mut GameInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.game_master, 6);
        let v0 = 0;
        while (v0 < arg1) {
            arg0.current_nft_index = arg0.current_nft_index + 1;
            let v1 = 4;
            mint_nft(get_nft_name(v1), 0x1::string::utf8(b"This is a Zombie NFT which mines ZBS coins."), get_nft_uri(arg0.domain, v1), arg0.current_nft_index, arg2);
            v0 = v0 + 1;
        };
    }

    fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = ZombieNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            url         : 0x2::url::new_unsafe(0x1::string::to_ascii(arg2)),
            token_id    : arg3,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<ZombieNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<ZombieNFT>(v1, v0);
    }

    public entry fun set_verify_pk(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.sig_verify_pk = 0x2::hex::decode(*0x1::string::bytes(&arg1));
    }

    public entry fun update_airdrop_amount(arg0: &mut GameInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.airdrop_amount = arg1;
    }

    public entry fun update_airdrop_status(arg0: &mut GameInfo, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.airdrop_status = arg1;
    }

    public entry fun update_domain(arg0: &mut GameInfo, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.domain = arg1;
    }

    public entry fun update_master_address(arg0: &mut GameInfo, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.game_master = arg1;
    }

    public entry fun update_max_zombies_per_player(arg0: &mut GameInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.max_zombie_per_player = arg1;
    }

    public entry fun update_zpt_per_zombie(arg0: &mut GameInfo, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.price_token_per_zombie = arg1;
    }

    fun verify_claim_sig(arg0: u64, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : bool {
        let v0 = (arg0 as u64);
        let v1 = 0x1::bcs::to_bytes<u64>(&v0);
        let v2 = (arg1 as u64);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&v2));
        0x2::ed25519::ed25519_verify(&arg3, &arg2, &v1)
    }

    fun verify_types_sig(arg0: vector<u8>, arg1: u64, arg2: vector<u8>, arg3: vector<u8>) : bool {
        0x1::vector::append<u8>(&mut arg0, 0x1::bcs::to_bytes<u64>(&arg1));
        let v0 = 0x1::string::utf8(b"verify_types_sig");
        0x1::debug::print<0x1::string::String>(&v0);
        0x1::debug::print<vector<u8>>(&arg0);
        0x2::ed25519::ed25519_verify(&arg3, &arg2, &arg0)
    }

    public entry fun withdraw_zpt(arg0: &mut GameInfo, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>>(0x2::coin::take<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&mut arg0.zpt_pot, 0x2::balance::value<0x70ee7a2d2517565ff0aaaee442f5950aa55f53a765674e4074f409c474011b14::dzbs::DZBS>(&arg0.zpt_pot), arg1), v0);
    }

    // decompiled from Move bytecode v6
}

