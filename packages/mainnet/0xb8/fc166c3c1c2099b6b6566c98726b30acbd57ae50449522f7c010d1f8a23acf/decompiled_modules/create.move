module 0xb8fc166c3c1c2099b6b6566c98726b30acbd57ae50449522f7c010d1f8a23acf::create {
    struct NFTCreated has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        creator: address,
    }

    struct NFTListed has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        owner: address,
    }

    struct NFTDelisted has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    struct NFTPurchased has copy, drop {
        id: 0x2::object::ID,
        price: u64,
        seller: address,
        buyer: address,
    }

    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x1::string::String,
        creator: address,
    }

    struct Store has key {
        id: 0x2::object::UID,
    }

    struct Listing<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        seller: address,
        kiosk_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        cap: 0x2::kiosk::PurchaseCap<T0>,
        price: u64,
        commission: u64,
        beneficiary: address,
    }

    struct CREATE has drop {
        dummy_field: bool,
    }

    public entry fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<NFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<NFT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun create_kiosk(arg0: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg0);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v0);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = NFT{
            id          : 0x2::object::new(arg3),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x1::string::utf8(arg2),
            creator     : v0,
        };
        let v2 = NFTCreated{
            id      : 0x2::object::id<NFT>(&v1),
            name    : v1.name,
            creator : v0,
        };
        0x2::event::emit<NFTCreated>(v2);
        0x2::transfer::public_transfer<NFT>(v1, v0);
    }

    public entry fun delist_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::owner(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg3), 3);
        assert!(0x2::kiosk::is_listed(arg0, arg2), 1);
        0x2::kiosk::delist<NFT>(arg0, arg1, arg2);
        let v1 = NFTDelisted{
            id    : arg2,
            owner : v0,
        };
        0x2::event::emit<NFTDelisted>(v1);
    }

    fun init(arg0: CREATE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CREATE>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<NFT>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun list_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::owner(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg4), 3);
        0x2::kiosk::list<NFT>(arg0, arg1, arg2, arg3);
        let v1 = NFTListed{
            id    : arg2,
            price : arg3,
            owner : v0,
        };
        0x2::event::emit<NFTListed>(v1);
    }

    public entry fun place_nft_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: NFT, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 3);
        0x2::kiosk::place<NFT>(arg0, arg1, arg2);
    }

    public entry fun take_nft(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: 0x2::object::ID, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::kiosk::owner(arg0);
        assert!(v0 == 0x2::tx_context::sender(arg3), 3);
        if (0x2::kiosk::is_listed(arg0, arg2)) {
            0x2::kiosk::delist<NFT>(arg0, arg1, arg2);
        };
        0x2::transfer::public_transfer<NFT>(0x2::kiosk::take<NFT>(arg0, arg1, arg2), v0);
    }

    // decompiled from Move bytecode v6
}

