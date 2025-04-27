module 0x92ccbd70faf28e51e3d49fcdcbc47ee372ef4115cf51bbb097fe057d5317599f::nft_mint {
    struct ArtworkCollection has store, key {
        id: 0x2::object::UID,
        artwork_id: 0x1::string::String,
        total_supply: u64,
        minted_count: u64,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        artwork_id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        data: vector<u8>,
    }

    struct CollectionCreated has copy, drop {
        collection_object_id: 0x2::object::ID,
        artwork_id: 0x1::string::String,
        total_supply: u64,
    }

    struct NftMinted has copy, drop {
        collection_object_id: 0x2::object::ID,
        nft_object_id: 0x2::object::ID,
        artwork_id: 0x1::string::String,
        recipient: address,
    }

    public fun artwork_id(arg0: &Nft) : 0x1::string::String {
        arg0.artwork_id
    }

    public fun collection_artwork_id(arg0: &ArtworkCollection) : 0x1::string::String {
        arg0.artwork_id
    }

    public entry fun create_artwork_collection(arg0: &0x92ccbd70faf28e51e3d49fcdcbc47ee372ef4115cf51bbb097fe057d5317599f::admin_control::NFT_MINT_ADMIN, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ArtworkCollection{
            id           : 0x2::object::new(arg3),
            artwork_id   : arg1,
            total_supply : arg2,
            minted_count : 0,
        };
        let v1 = CollectionCreated{
            collection_object_id : 0x2::object::uid_to_inner(&v0.id),
            artwork_id           : v0.artwork_id,
            total_supply         : v0.total_supply,
        };
        0x2::event::emit<CollectionCreated>(v1);
        0x2::transfer::public_share_object<ArtworkCollection>(v0);
    }

    public fun data(arg0: &Nft) : vector<u8> {
        arg0.data
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun mint_and_send(arg0: &mut ArtworkCollection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<u8>, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.minted_count < arg0.total_supply, 2);
        arg0.minted_count = arg0.minted_count + 1;
        let v0 = Nft{
            id          : 0x2::object::new(arg5),
            artwork_id  : arg0.artwork_id,
            name        : arg1,
            description : arg2,
            data        : arg3,
        };
        let v1 = NftMinted{
            collection_object_id : 0x2::object::uid_to_inner(&arg0.id),
            nft_object_id        : 0x2::object::uid_to_inner(&v0.id),
            artwork_id           : arg0.artwork_id,
            recipient            : arg4,
        };
        0x2::event::emit<NftMinted>(v1);
        0x2::transfer::public_transfer<Nft>(v0, arg4);
    }

    public fun minted_count(arg0: &ArtworkCollection) : u64 {
        arg0.minted_count
    }

    public fun total_supply(arg0: &ArtworkCollection) : u64 {
        arg0.total_supply
    }

    // decompiled from Move bytecode v6
}

