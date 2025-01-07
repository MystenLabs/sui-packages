module 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::mine_nft {
    struct Mine has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x2::url::Url,
        generation: u64,
        quality: u64,
    }

    struct Info has key {
        id: 0x2::object::UID,
        base_uri: vector<u8>,
        owner: address,
        verifier: vector<u8>,
    }

    struct Minter has store, key {
        id: 0x2::object::UID,
    }

    struct MintNftMessage has drop {
        minter: vector<u8>,
        owner: address,
        timestamp: u64,
        generation: u64,
        quality: u64,
    }

    struct NftMinted has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        quality: u64,
        generation: u64,
    }

    struct NftTransferred has copy, drop {
        nft_id: 0x2::object::ID,
        recipient: address,
        sender: address,
    }

    struct TransferOwnership has copy, drop {
        owner: address,
    }

    struct AddMinter has copy, drop {
        minter: address,
    }

    struct DeleteMinter has copy, drop {
        minter: address,
    }

    struct SetBaseUri has copy, drop {
        value: vector<u8>,
    }

    struct SetVerifier has copy, drop {
        recepient: vector<u8>,
    }

    struct NftMintedBy has copy, drop {
        minter: vector<u8>,
        player: address,
        generation: u64,
        quality: u64,
    }

    public entry fun transfer(arg0: Mine, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = NftTransferred{
            nft_id    : 0x2::object::id<Mine>(&arg0),
            recipient : arg1,
            sender    : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<NftTransferred>(v0);
        0x2::transfer::transfer<Mine>(arg0, arg1);
    }

    public entry fun add_minter(arg0: &mut Info, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(!0x2::dynamic_object_field::exists_with_type<address, Minter>(&arg0.id, arg1), 2);
        let v0 = Minter{id: 0x2::object::new(arg2)};
        0x2::dynamic_object_field::add<address, Minter>(&mut arg0.id, arg1, v0);
        let v1 = AddMinter{minter: arg1};
        0x2::event::emit<AddMinter>(v1);
    }

    public fun generation(arg0: &Mine) : u64 {
        arg0.generation
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Info{
            id       : 0x2::object::new(arg0),
            base_uri : b"https://sui-api.miniminersgame.com/meta/",
            owner    : v0,
            verifier : x"3b1a85602794135bc124a5464c9989b888098777",
        };
        let v2 = &mut v1;
        add_minter(v2, v0, arg0);
        0x2::transfer::share_object<Info>(v1);
        let v3 = SetBaseUri{value: b"https://sui-api.miniminersgame.com/meta/"};
        0x2::event::emit<SetBaseUri>(v3);
        let v4 = TransferOwnership{owner: v0};
        0x2::event::emit<TransferOwnership>(v4);
    }

    public entry fun mint(arg0: &Info, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::dynamic_object_field::exists_with_type<address, Minter>(&arg0.id, 0x2::tx_context::sender(arg4)), 1);
        mint_internal(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun mint_by(arg0: &Info, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        let v1 = MintNftMessage{
            minter     : arg6,
            owner      : v0,
            timestamp  : arg4,
            generation : arg2,
            quality    : arg3,
        };
        assert!(arg0.verifier == 0x366765d8f2082df14f5c23593537d7a186268b8c624817bacfdc0cdc595db29f::verifier::ecrecover_to_eth_address(arg5, 0x2::bcs::to_bytes<MintNftMessage>(&v1)), 4);
        mint_internal(arg0, arg1, arg2, arg3, arg7);
        let v2 = NftMintedBy{
            minter     : arg6,
            player     : v0,
            generation : arg2,
            quality    : arg3,
        };
        0x2::event::emit<NftMintedBy>(v2);
    }

    fun mint_internal(arg0: &Info, arg1: address, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x1::string::utf8(arg0.base_uri);
        0x1::string::append(&mut v1, 0x2::address::to_string(0x2::object::uid_to_address(&v0)));
        let v2 = Mine{
            id         : v0,
            name       : 0x1::string::utf8(b"MINES"),
            url        : 0x2::url::new_unsafe(0x1::string::to_ascii(v1)),
            generation : arg2,
            quality    : arg3,
        };
        let v3 = NftMinted{
            nft_id     : 0x2::object::id<Mine>(&v2),
            recipient  : arg1,
            quality    : arg3,
            generation : arg2,
        };
        0x2::event::emit<NftMinted>(v3);
        0x2::transfer::transfer<Mine>(v2, arg1);
    }

    public fun name(arg0: &Mine) : vector<u8> {
        b"MINES"
    }

    public fun quality(arg0: &Mine) : u64 {
        arg0.quality
    }

    public entry fun remove_minter(arg0: &mut Info, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        assert!(0x2::dynamic_object_field::exists_with_type<address, Minter>(&arg0.id, arg1), 1);
        let Minter { id: v0 } = 0x2::dynamic_object_field::remove<address, Minter>(&mut arg0.id, arg1);
        0x2::object::delete(v0);
        let v1 = DeleteMinter{minter: arg1};
        0x2::event::emit<DeleteMinter>(v1);
    }

    public entry fun set_verifier(arg0: &mut Info, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.verifier = arg1;
        let v0 = SetVerifier{recepient: arg1};
        0x2::event::emit<SetVerifier>(v0);
    }

    public entry fun transfer_ownership(arg0: &mut Info, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 1);
        arg0.owner = arg1;
        let v0 = TransferOwnership{owner: arg1};
        0x2::event::emit<TransferOwnership>(v0);
    }

    // decompiled from Move bytecode v6
}

