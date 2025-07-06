module 0xf7ed71550eb29ca3fcf1d4282f2a80f9b7f6970fcb9b6203b414e8d47b4c15fb::nft_manager {
    struct NFT_MANAGER has drop {
        dummy_field: bool,
    }

    struct RivalNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        creator: address,
        tournament_history: vector<0x2::object::ID>,
        total_votes_received: u64,
        tournaments_won: u64,
    }

    struct NFTMintedEvent has copy, drop {
        nft_id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTTournamentResultEvent has copy, drop {
        nft_id: 0x2::object::ID,
        tournament_id: 0x2::object::ID,
        votes_received: u64,
        won: bool,
    }

    public fun get_nft_details(arg0: &RivalNFT) : (0x1::string::String, 0x1::string::String, address, u64, u64) {
        (arg0.name, arg0.description, arg0.creator, arg0.total_votes_received, arg0.tournaments_won)
    }

    public fun get_tournament_history(arg0: &RivalNFT) : vector<0x2::object::ID> {
        arg0.tournament_history
    }

    fun init(arg0: NFT_MANAGER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<NFT_MANAGER>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"creator"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"tournaments_won"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{creator}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{tournaments_won}"));
        let v5 = 0x2::display::new_with_fields<RivalNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<RivalNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<RivalNFT>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : RivalNFT {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = NFTMintedEvent{
            nft_id  : 0x2::object::uid_to_inner(&v0),
            name    : arg0,
            creator : v1,
        };
        0x2::event::emit<NFTMintedEvent>(v2);
        RivalNFT{
            id                   : v0,
            name                 : arg0,
            description          : arg1,
            url                  : 0x2::url::new_unsafe_from_bytes(arg2),
            creator              : v1,
            tournament_history   : 0x1::vector::empty<0x2::object::ID>(),
            total_votes_received : 0,
            tournaments_won      : 0,
        }
    }

    public fun mint_and_transfer(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: vector<u8>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<RivalNFT>(mint(arg0, arg1, arg2, arg4), arg3);
    }

    public fun transfer_nft(arg0: RivalNFT, arg1: address) {
        0x2::transfer::public_transfer<RivalNFT>(arg0, arg1);
    }

    public fun update_after_tournament(arg0: &mut RivalNFT, arg1: 0x2::object::ID, arg2: u64, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.creator, 1);
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.tournament_history, arg1);
        arg0.total_votes_received = arg0.total_votes_received + arg2;
        if (arg3) {
            arg0.tournaments_won = arg0.tournaments_won + 1;
        };
        let v0 = NFTTournamentResultEvent{
            nft_id         : 0x2::object::id<RivalNFT>(arg0),
            tournament_id  : arg1,
            votes_received : arg2,
            won            : arg3,
        };
        0x2::event::emit<NFTTournamentResultEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

