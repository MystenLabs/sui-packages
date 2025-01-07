module 0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::nft {
    struct ArtfiNFT has store, key {
        id: 0x2::object::UID,
        fraction_id: u64,
        name: 0x1::string::String,
        url: 0x2::url::Url,
    }

    struct Royalty has copy, drop, store {
        artfi: u64,
        artist: u64,
        staking_contract: u64,
    }

    struct NFTInfo has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        royalty_nft: 0x2::vec_map::VecMap<0x2::object::ID, Royalty>,
        default_royalty: Royalty,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct MinterCap has key {
        id: 0x2::object::UID,
    }

    struct RoyaltyUpdated has copy, drop {
        artfi: u64,
        artist: u64,
        staking_contract: u64,
    }

    struct NFT has drop {
        dummy_field: bool,
    }

    public fun id(arg0: &ArtfiNFT) : 0x2::object::ID {
        0x2::object::id<ArtfiNFT>(arg0)
    }

    public fun url(arg0: &ArtfiNFT) : &0x2::url::Url {
        &arg0.url
    }

    public fun artfi_royalty(arg0: &ArtfiNFT, arg1: &NFTInfo) : u64 {
        let v0 = 0x2::object::id<ArtfiNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Royalty>(&arg1.royalty_nft, &v0).artfi
    }

    public fun artist_royalty(arg0: &ArtfiNFT, arg1: &NFTInfo) : u64 {
        let v0 = 0x2::object::id<ArtfiNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Royalty>(&arg1.royalty_nft, &v0).artist
    }

    public entry fun burn(arg0: ArtfiNFT, arg1: &mut NFTInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<ArtfiNFT>(&arg0);
        let (_, _) = 0x2::vec_map::remove<0x2::object::ID, Royalty>(&mut arg1.royalty_nft, &v0);
        let ArtfiNFT {
            id          : v3,
            fraction_id : _,
            name        : _,
            url         : _,
        } = arg0;
        0x2::object::delete(v3);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_burn_nft<ArtfiNFT>(v0);
    }

    public fun fraction_id(arg0: &ArtfiNFT) : u64 {
        arg0.fraction_id
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Artfi NFT"));
        let v4 = 0x2::package::claim<NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<ArtfiNFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<ArtfiNFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<ArtfiNFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Royalty{
            artfi            : 4,
            artist           : 3,
            staking_contract : 3,
        };
        let v7 = NFTInfo{
            id              : 0x2::object::new(arg1),
            name            : 0x1::string::utf8(b"Artfi"),
            royalty_nft     : 0x2::vec_map::empty<0x2::object::ID, Royalty>(),
            default_royalty : v6,
        };
        0x2::transfer::share_object<NFTInfo>(v7);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v8, 0x2::tx_context::sender(arg1));
        let v9 = MinterCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<MinterCap>(v9, 0x2::tx_context::sender(arg1));
    }

    fun mint_func(arg0: vector<u8>, arg1: address, arg2: u64, arg3: &mut NFTInfo, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = ArtfiNFT{
            id          : 0x2::object::new(arg4),
            fraction_id : arg2,
            name        : arg3.name,
            url         : 0x2::url::new_unsafe_from_bytes(arg0),
        };
        let v1 = 0x2::object::id<ArtfiNFT>(&v0);
        let v2 = Royalty{
            artfi            : arg3.default_royalty.artfi,
            artist           : arg3.default_royalty.artist,
            staking_contract : arg3.default_royalty.staking_contract,
        };
        0x2::vec_map::insert<0x2::object::ID, Royalty>(&mut arg3.royalty_nft, v1, v2);
        0x2::transfer::public_transfer<ArtfiNFT>(v0, arg1);
        v1
    }

    public entry fun mint_nft(arg0: &MinterCap, arg1: &mut NFTInfo, arg2: vector<u8>, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = mint_func(arg2, arg3, arg4, arg1, arg5);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_mint_nft(v0, 0x2::tx_context::sender(arg5), arg1.name);
    }

    public fun mint_nft_batch(arg0: &MinterCap, arg1: &mut NFTInfo, arg2: &vector<vector<u8>>, arg3: &vector<address>, arg4: &vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<vector<u8>>(arg2);
        assert!(v0 == 0x1::vector::length<u64>(arg4), 1);
        assert!(v0 == 0x1::vector::length<address>(arg3), 1);
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = mint_func(*0x1::vector::borrow<vector<u8>>(arg2, v2), *0x1::vector::borrow<address>(arg3, v2), *0x1::vector::borrow<u64>(arg4, v2), arg1, arg5);
            v2 = v2 + 1;
            0x1::vector::push_back<0x2::object::ID>(&mut v1, v3);
        };
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_batch_mint_nft(v1, v0, 0x2::tx_context::sender(arg5), arg1.name);
    }

    public fun name(arg0: &ArtfiNFT) : &0x1::string::String {
        &arg0.name
    }

    public fun royalty(arg0: &ArtfiNFT, arg1: &NFTInfo) : Royalty {
        let v0 = 0x2::object::id<ArtfiNFT>(arg0);
        *0x2::vec_map::get<0x2::object::ID, Royalty>(&arg1.royalty_nft, &v0)
    }

    public fun staking_contract_royalty(arg0: &ArtfiNFT, arg1: &NFTInfo) : u64 {
        let v0 = 0x2::object::id<ArtfiNFT>(arg0);
        0x2::vec_map::get<0x2::object::ID, Royalty>(&arg1.royalty_nft, &v0).staking_contract
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_transfer_object<AdminCap>(0x2::object::id<AdminCap>(&arg0), arg1);
    }

    public entry fun transfer_minter_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = MinterCap{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<MinterCap>(v0, arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_transfer_object<MinterCap>(0x2::object::id<MinterCap>(&v0), arg1);
    }

    public entry fun transfer_nft(arg0: ArtfiNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<ArtfiNFT>(arg0, arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_transfer_object<ArtfiNFT>(0x2::object::id<ArtfiNFT>(&arg0), arg1);
    }

    public fun update_metadata(arg0: &AdminCap, arg1: &mut 0x2::display::Display<ArtfiNFT>, arg2: &mut NFTInfo, arg3: 0x1::string::String, arg4: 0x1::string::String) {
        0x2::display::edit<ArtfiNFT>(arg1, 0x1::string::utf8(b"name"), arg4);
        0x2::display::edit<ArtfiNFT>(arg1, 0x1::string::utf8(b"description"), arg3);
        arg2.name = arg4;
        0x2::display::update_version<ArtfiNFT>(arg1);
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::emit_metadat_update(arg4, arg3);
    }

    public entry fun update_nft_royalty(arg0: &MinterCap, arg1: &mut NFTInfo, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = Royalty{
            artfi            : arg3,
            artist           : arg4,
            staking_contract : arg5,
        };
        0xfd86a8938ab9b5a4816f508eb89f4f293e98c64af22fbdbb71ced93224bebe1c::base_nft::update_attribute<0x2::object::ID, Royalty>(&mut arg1.royalty_nft, arg2, v0);
    }

    public entry fun update_royalty(arg0: &MinterCap, arg1: &mut NFTInfo, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        arg1.default_royalty.artfi = arg2;
        arg1.default_royalty.artist = arg3;
        arg1.default_royalty.staking_contract = arg4;
        let v0 = RoyaltyUpdated{
            artfi            : arg2,
            artist           : arg3,
            staking_contract : arg4,
        };
        0x2::event::emit<RoyaltyUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

