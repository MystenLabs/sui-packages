module 0xf847d969ced8152deec9262d24966cc735ad29a2df01af7f2f0d8c59d9dd032f::simple_portraits {
    struct SIMPLE_PORTRAITS has drop {
        dummy_field: bool,
    }

    struct PortraitNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        creator: address,
        mint_number: u64,
    }

    struct Collection has store, key {
        id: 0x2::object::UID,
        mint_supply: u64,
        minted: u64,
        creator: address,
    }

    public fun create_collection(arg0: u64, arg1: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id          : 0x2::object::new(arg1),
            mint_supply : arg0,
            minted      : 0,
            creator     : 0x2::tx_context::sender(arg1),
        }
    }

    public fun get_minted_count(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun init(arg0: SIMPLE_PORTRAITS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SIMPLE_PORTRAITS>(arg0, arg1);
        let v1 = 0x2::display::new<PortraitNFT>(&v0, arg1);
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{mint_number}"));
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<PortraitNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<PortraitNFT>(&mut v1);
        0x2::transfer::public_share_object<0x2::display::Display<PortraitNFT>>(v1);
        let (v2, v3) = 0x2::transfer_policy::new<PortraitNFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<PortraitNFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<PortraitNFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint_and_transfer(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<PortraitNFT>(mint_nft(arg0, arg1, arg2, arg3, arg5), arg4);
    }

    public fun mint_nft(arg0: &mut Collection, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : PortraitNFT {
        assert!(arg0.minted < arg0.mint_supply, 1);
        assert!(arg0.creator == 0x2::tx_context::sender(arg4), 2);
        arg0.minted = arg0.minted + 1;
        PortraitNFT{
            id          : 0x2::object::new(arg4),
            name        : arg1,
            description : arg2,
            image_url   : arg3,
            creator     : arg0.creator,
            mint_number : arg0.minted,
        }
    }

    public fun update_mint_supply(arg0: &mut Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 2);
        assert!(arg0.minted <= arg1, 1);
        arg0.mint_supply = arg1;
    }

    // decompiled from Move bytecode v6
}

