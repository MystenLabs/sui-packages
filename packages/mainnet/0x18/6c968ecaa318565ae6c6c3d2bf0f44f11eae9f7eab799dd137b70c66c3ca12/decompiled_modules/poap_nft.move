module 0x186c968ecaa318565ae6c6c3d2bf0f44f11eae9f7eab799dd137b70c66c3ca12::poap_nft {
    struct SudoBasecampPoapNft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x2::url::Url,
    }

    struct POAP_NFT has drop {
        dummy_field: bool,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun burn(arg0: SudoBasecampPoapNft) {
        let SudoBasecampPoapNft {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &SudoBasecampPoapNft) : &0x1::string::String {
        &arg0.description
    }

    public fun image_url(arg0: &SudoBasecampPoapNft) : &0x2::url::Url {
        &arg0.image_url
    }

    fun init(arg0: POAP_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://app.sudo.finance"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Sudo Finance"));
        let v4 = 0x2::package::claim<POAP_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SudoBasecampPoapNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<SudoBasecampPoapNft>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SudoBasecampPoapNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SudoBasecampPoapNft{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"Sudo Sui Basecamp 2024 POAP"),
            description : 0x1::string::utf8(b"POAP of your Sui Basecamp Paris attendance issued by Sudo - the fastest growing Perps protocol on Sui. Visit us at https://app.sudo.finance."),
            image_url   : 0x2::url::new_unsafe_from_bytes(b"https://arweave.net/YOF9xGtHOPwHxelm_L2Xx59Lfo39SmZ_9g2Mb_xXT88"),
        };
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<SudoBasecampPoapNft>(v0, v1);
    }

    public fun name(arg0: &SudoBasecampPoapNft) : &0x1::string::String {
        &arg0.name
    }

    // decompiled from Move bytecode v6
}

