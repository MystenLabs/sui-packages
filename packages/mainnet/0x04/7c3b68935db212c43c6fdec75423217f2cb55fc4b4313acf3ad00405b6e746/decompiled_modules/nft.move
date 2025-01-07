module 0x47c3b68935db212c43c6fdec75423217f2cb55fc4b4313acf3ad00405b6e746::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct MinerNFT has store, key {
        id: 0x2::object::UID,
        tier: u8,
        effect_level: u8,
        reinvest_count: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        hatchery_miners: u64,
        claimed_eggs: u64,
        last_hatch: u64,
        current_deposit: u64,
        current_withdrawn: u64,
        creator: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct NFTMinted has copy, drop {
        nft_id: 0x2::object::ID,
        tier: u8,
        hatchery_miners: u64,
        owner: address,
    }

    struct NFTUpgraded has copy, drop {
        nft_id: 0x2::object::ID,
        new_effect_level: u8,
        new_miners_count: u64,
    }

    public fun add_deposit(arg0: &mut MinerNFT, arg1: u64) {
        arg0.current_deposit = arg0.current_deposit + arg1;
    }

    public fun add_miners(arg0: &mut MinerNFT, arg1: u64) {
        arg0.hatchery_miners = arg0.hatchery_miners + arg1;
    }

    public fun add_withdrawn(arg0: &mut MinerNFT, arg1: u64) {
        arg0.current_withdrawn = arg0.current_withdrawn + arg1;
    }

    fun calculate_tier(arg0: u64) : u8 {
        if (arg0 >= 1000000000) {
            3
        } else if (arg0 >= 500000000) {
            2
        } else {
            assert!(arg0 >= 100000000, 3);
            1
        }
    }

    public fun get_claimed_eggs(arg0: &MinerNFT) : u64 {
        arg0.claimed_eggs
    }

    public fun get_creator(arg0: &MinerNFT) : address {
        arg0.creator
    }

    public fun get_current_deposit(arg0: &MinerNFT) : u64 {
        arg0.current_deposit
    }

    public fun get_current_withdrawn(arg0: &MinerNFT) : u64 {
        arg0.current_withdrawn
    }

    public fun get_effect_level(arg0: &MinerNFT) : u8 {
        arg0.effect_level
    }

    public fun get_hatchery_miners(arg0: &MinerNFT) : u64 {
        arg0.hatchery_miners
    }

    public fun get_last_hatch(arg0: &MinerNFT) : u64 {
        arg0.last_hatch
    }

    public fun get_reinvest_count(arg0: &MinerNFT) : u64 {
        arg0.reinvest_count
    }

    public fun get_tier(arg0: &MinerNFT) : u8 {
        arg0.tier
    }

    public fun increment_reinvest_count(arg0: &mut MinerNFT) {
        arg0.reinvest_count = arg0.reinvest_count + 1;
        if (arg0.reinvest_count % 10 == 0 && arg0.effect_level < 4) {
            arg0.effect_level = arg0.effect_level + 1;
            let v0 = NFTUpgraded{
                nft_id           : 0x2::object::uid_to_inner(&arg0.id),
                new_effect_level : arg0.effect_level,
                new_miners_count : arg0.hatchery_miners,
            };
            0x2::event::emit<NFTUpgraded>(v0);
        };
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<MinerNFT>(&v0, arg1);
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"tier"), 0x1::string::utf8(b"Tier {tier}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"effect_level"), 0x1::string::utf8(b"Effect Level {effect_level}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"miners"), 0x1::string::utf8(b"Miners: {hatchery_miners}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"reinvest_count"), 0x1::string::utf8(b"Reinvest Count: {reinvest_count}"));
        0x2::display::update_version<MinerNFT>(&mut v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::display::Display<MinerNFT>>(v1);
    }

    public fun mint(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x2::url::Url, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : MinerNFT {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = 0x2::object::new(arg7);
        let v2 = calculate_tier(arg5);
        let v3 = MinerNFT{
            id                : v1,
            tier              : v2,
            effect_level      : 1,
            reinvest_count    : 0,
            name              : arg1,
            description       : arg2,
            url               : arg3,
            hatchery_miners   : arg4,
            claimed_eggs      : 0,
            last_hatch        : arg6,
            current_deposit   : arg5,
            current_withdrawn : 0,
            creator           : v0,
        };
        let v4 = NFTMinted{
            nft_id          : 0x2::object::uid_to_inner(&v1),
            tier            : v2,
            hatchery_miners : arg4,
            owner           : v0,
        };
        0x2::event::emit<NFTMinted>(v4);
        v3
    }

    public fun reset_claimed_eggs(arg0: &mut MinerNFT) {
        arg0.claimed_eggs = 0;
    }

    public fun set_last_hatch(arg0: &mut MinerNFT, arg1: u64) {
        arg0.last_hatch = arg1;
    }

    public fun update_miner_data(arg0: &mut MinerNFT, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        arg0.hatchery_miners = arg1;
        arg0.claimed_eggs = arg2;
        arg0.last_hatch = arg3;
        arg0.current_deposit = arg4;
        arg0.current_withdrawn = arg5;
        arg0.reinvest_count = arg6;
        if (arg6 % 10 == 0 && arg0.effect_level < 4) {
            arg0.effect_level = arg0.effect_level + 1;
            let v0 = NFTUpgraded{
                nft_id           : 0x2::object::uid_to_inner(&arg0.id),
                new_effect_level : arg0.effect_level,
                new_miners_count : arg1,
            };
            0x2::event::emit<NFTUpgraded>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

