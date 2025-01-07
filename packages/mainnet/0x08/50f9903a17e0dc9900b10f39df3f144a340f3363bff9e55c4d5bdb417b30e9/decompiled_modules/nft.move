module 0x850f9903a17e0dc9900b10f39df3f144a340f3363bff9e55c4d5bdb417b30e9::nft {
    struct NFTMinted has copy, drop {
        creator: address,
        nft_id: address,
        deposit: u64,
        miners: u64,
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

    public fun add_deposit(arg0: &mut MinerNFT, arg1: u64) {
        arg0.deposit = arg0.deposit + arg1;
    }

    public fun add_miners(arg0: &mut MinerNFT, arg1: u64) {
        arg0.hatchery_miners = arg0.hatchery_miners + arg1;
    }

    public fun add_withdrawn(arg0: &mut MinerNFT, arg1: u64) {
        arg0.withdrawn = arg0.withdrawn + arg1;
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
        let v1 = 0x2::display::new<MinerNFT>(&v0, arg1);
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<MinerNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<MinerNFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<MinerNFT>>(v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : MinerNFT {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = MinerNFT{
            id              : 0x2::object::new(arg2),
            creator         : v0,
            deposit         : arg0,
            withdrawn       : 0,
            last_hatch      : 0x2::tx_context::epoch_timestamp_ms(arg2),
            hatchery_miners : arg1,
            claimed_eggs    : 0,
            reinvest_count  : 0,
            name            : 0x1::string::utf8(b"Miner NFT"),
            description     : 0x1::string::utf8(b"Your personal miner NFT"),
            url             : 0x2::url::new_unsafe_from_bytes(b"https://example.com/nft.png"),
        };
        let v2 = NFTMinted{
            creator : v0,
            nft_id  : 0x2::object::uid_to_address(&v1.id),
            deposit : arg0,
            miners  : arg1,
        };
        0x2::event::emit<NFTMinted>(v2);
        v1
    }

    public fun reset_claimed_eggs(arg0: &mut MinerNFT) {
        arg0.claimed_eggs = 0;
    }

    public fun set_last_hatch(arg0: &mut MinerNFT, arg1: u64) {
        arg0.last_hatch = arg1;
    }

    // decompiled from Move bytecode v6
}

