module 0xfa9f6092d26980c76dd8201978c3f589af85a9f03475a1264f4e2c267cc05f7c::nft {
    struct NFTMinted has copy, drop {
        creator: address,
        nft_id: 0x2::object::ID,
        deposit: u64,
        miners: u64,
    }

    struct NFTBurned has copy, drop {
        nft_id: address,
        owner: address,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct MinerNFT has store, key {
        id: 0x2::object::UID,
        creator: address,
        deposit: u64,
        withdrawn: u64,
        last_hatch: u64,
        hatchery_miners: u64,
        claimed_eggs: u64,
        reinvest_count: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public fun add_miners(arg0: &mut MinerNFT, arg1: u64) {
        arg0.hatchery_miners = arg0.hatchery_miners + arg1;
    }

    public fun add_withdrawn(arg0: &mut MinerNFT, arg1: u64) {
        arg0.withdrawn = arg0.withdrawn + arg1;
    }

    public entry fun burn_nft(arg0: MinerNFT, arg1: &mut 0x2::tx_context::TxContext) {
        let MinerNFT {
            id              : v0,
            creator         : _,
            deposit         : _,
            withdrawn       : _,
            last_hatch      : _,
            hatchery_miners : _,
            claimed_eggs    : _,
            reinvest_count  : _,
            name            : _,
            description     : _,
            url             : _,
        } = arg0;
        let v11 = v0;
        let v12 = NFTBurned{
            nft_id : 0x2::object::uid_to_address(&v11),
            owner  : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<NFTBurned>(v12);
        0x2::object::delete(v11);
    }

    public fun get_claimed_eggs(arg0: &MinerNFT) : u64 {
        arg0.claimed_eggs
    }

    public fun get_creator(arg0: &MinerNFT) : address {
        arg0.creator
    }

    public fun get_current_deposit(arg0: &MinerNFT) : u64 {
        arg0.deposit
    }

    public fun get_current_withdrawn(arg0: &MinerNFT) : u64 {
        arg0.withdrawn
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

    public fun increment_reinvest_count(arg0: &mut MinerNFT) {
        arg0.reinvest_count = arg0.reinvest_count + 1;
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"deposit"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"miners"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"withdrawn"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{deposit}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{hatchery_miners}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://example.com"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{withdrawn}"));
        let v5 = 0x2::display::new_with_fields<MinerNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<MinerNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<MinerNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint_nft(arg0: u64, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= arg0, 2);
        let v1 = if (0x2::coin::value<0x2::sui::SUI>(arg2) > arg0) {
            0x2::coin::value<0x2::sui::SUI>(arg2);
            0x2::coin::split<0x2::sui::SUI>(arg2, arg0, arg3)
        } else {
            0x2::coin::split<0x2::sui::SUI>(arg2, 0x2::coin::value<0x2::sui::SUI>(arg2), arg3)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, v0);
        let v2 = MinerNFT{
            id              : 0x2::object::new(arg3),
            creator         : v0,
            deposit         : arg0,
            withdrawn       : 0,
            last_hatch      : 0x2::tx_context::epoch_timestamp_ms(arg3),
            hatchery_miners : arg1,
            claimed_eggs    : 0,
            reinvest_count  : 0,
            name            : 0x1::string::utf8(b"Miner NFT"),
            description     : 0x1::string::utf8(b"Your personal miner NFT"),
            url             : 0x2::url::new_unsafe_from_bytes(b"https://example.com/nft.png"),
        };
        let v3 = NFTMinted{
            creator : v0,
            nft_id  : 0x2::object::id<MinerNFT>(&v2),
            deposit : arg0,
            miners  : arg1,
        };
        0x2::event::emit<NFTMinted>(v3);
        0x2::transfer::transfer<MinerNFT>(v2, v0);
    }

    public fun reset_claimed_eggs(arg0: &mut MinerNFT) {
        arg0.claimed_eggs = 0;
    }

    public fun set_last_hatch(arg0: &mut MinerNFT, arg1: u64) {
        arg0.last_hatch = arg1;
    }

    // decompiled from Move bytecode v6
}

