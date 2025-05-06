module 0x13a7b54401a0ed6abe6160c82f0c1e4cb03b21124d81c172c5bc1fa50de7e94a::nft {
    struct PoorlaxNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct MintRegistry has key {
        id: 0x2::object::UID,
        minters: 0x2::table::Table<address, bool>,
        mint_end_time: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    struct NFTMinted has copy, drop {
        nft_id: address,
        creator: address,
        recipient: address,
        name: 0x1::string::String,
    }

    public fun url(arg0: &PoorlaxNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &PoorlaxNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun has_minted(arg0: &MintRegistry, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.minters, arg1)
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT>(arg0, arg1);
        let v1 = 0x2::display::new<PoorlaxNFT>(&v0, arg1);
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PoorlaxNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        let v2 = MintRegistry{
            id            : 0x2::object::new(arg1),
            minters       : 0x2::table::new<address, bool>(arg1),
            mint_end_time : 0x2::tx_context::epoch_timestamp_ms(arg1) + 93600000,
        };
        0x2::display::update_version<PoorlaxNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::display::Display<PoorlaxNFT>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<MintRegistry>(v2);
    }

    public fun is_minting_active(arg0: &MintRegistry, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) <= arg0.mint_end_time
    }

    public entry fun mint(arg0: &mut MintRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg5) <= arg0.mint_end_time, 2);
        assert!(!has_minted(arg0, arg4), 1);
        0x2::table::add<address, bool>(&mut arg0.minters, arg4, true);
        let v0 = PoorlaxNFT{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg1),
            description : 0x1::string::utf8(arg2),
            url         : 0x2::url::new_unsafe_from_bytes(arg3),
        };
        let v1 = NFTMinted{
            nft_id    : 0x2::object::uid_to_address(&v0.id),
            creator   : 0x2::tx_context::sender(arg6),
            recipient : arg4,
            name      : v0.name,
        };
        0x2::event::emit<NFTMinted>(v1);
        0x2::transfer::public_transfer<PoorlaxNFT>(v0, arg4);
    }

    public fun name(arg0: &PoorlaxNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun time_remaining(arg0: &MintRegistry, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 >= arg0.mint_end_time) {
            0
        } else {
            arg0.mint_end_time - v0
        }
    }

    // decompiled from Move bytecode v6
}

