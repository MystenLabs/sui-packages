module 0x34f9e32641795c57d936b3e387b9c7c941fd99b5a8a90e86b61e966e9da1d1f0::unbound_nft {
    struct UNBOUND_NFT has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct UnboundNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
    }

    struct CollectionInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<UnboundNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<UnboundNFT>,
    }

    struct MintCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    public fun add_base64(arg0: &MintCap<UnboundNFT>, arg1: UnboundNFT, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) : UnboundNFT {
        0x1::string::append(&mut arg1.url, arg2);
        arg1
    }

    public fun finalize_nft(arg0: &MintCap<UnboundNFT>, arg1: UnboundNFT, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<UnboundNFT>(arg1, 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: UNBOUND_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<UNBOUND_NFT>(arg0, arg1);
        let v1 = 0x2::display::new<UnboundNFT>(&v0, arg1);
        0x2::display::add<UnboundNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<UnboundNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::add<UnboundNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::update_version<UnboundNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<UnboundNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x34f9e32641795c57d936b3e387b9c7c941fd99b5a8a90e86b61e966e9da1d1f0::royalty_rule::add<UnboundNFT>(&mut v5, &v4, 500, 100);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<UnboundNFT>>(v5);
        let v6 = MintCap<UnboundNFT>{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap<UnboundNFT>>(v6, 0x2::tx_context::sender(arg1));
        let v7 = CollectionInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v1,
            policy_cap : v4,
        };
        0x2::transfer::public_transfer<CollectionInfo>(v7, @0xc333120e29ae0b59f924836c2eff13a06b9009324dee51fe8aa880107c7b08be);
    }

    public fun mint_nft(arg0: &MintCap<UnboundNFT>, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : UnboundNFT {
        let v0 = UnboundNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            url         : arg3,
        };
        let v1 = MintEvent{nft: 0x2::object::id<UnboundNFT>(&v0)};
        0x2::event::emit<MintEvent>(v1);
        v0
    }

    public fun put_all_nfts_into_kiosk(arg0: &MintCap<UnboundNFT>, arg1: vector<UnboundNFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        let v3 = v0;
        while (0x1::vector::length<UnboundNFT>(&arg1) > 0) {
            0x2::kiosk::place<UnboundNFT>(&mut v3, &v2, 0x1::vector::pop_back<UnboundNFT>(&mut arg1));
        };
        0x1::vector::destroy_empty<UnboundNFT>(arg1);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
    }

    // decompiled from Move bytecode v6
}

