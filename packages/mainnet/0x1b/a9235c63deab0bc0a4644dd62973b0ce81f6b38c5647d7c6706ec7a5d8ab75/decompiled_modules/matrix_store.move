module 0x1ba9235c63deab0bc0a4644dd62973b0ce81f6b38c5647d7c6706ec7a5d8ab75::matrix_store {
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

    struct MATRIX_STORE has drop {
        dummy_field: bool,
    }

    struct PersonalKioskCap has key {
        id: 0x2::object::UID,
        cap: 0x1::option::Option<0x2::kiosk::KioskOwnerCap>,
    }

    struct Borrow has copy, drop {
        owned_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public entry fun add_royalty_rule(arg0: &mut 0x2::transfer_policy::TransferPolicy<NFT>, arg1: &0x2::transfer_policy::TransferPolicyCap<NFT>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
    }

    public fun borrow_val(arg0: &mut PersonalKioskCap) : (0x2::kiosk::KioskOwnerCap, Borrow) {
        let v0 = 0x1::option::extract<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap);
        let v1 = Borrow{
            owned_id : 0x2::object::id<PersonalKioskCap>(arg0),
            cap_id   : 0x2::object::id<0x2::kiosk::KioskOwnerCap>(&v0),
        };
        (v0, v1)
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

    fun init(arg0: MATRIX_STORE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Store{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<Store>(v0);
        let v1 = 0x2::package::claim<MATRIX_STORE>(arg0, arg1);
        let (v2, v3) = 0x2::transfer_policy::new<NFT>(&v1, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<NFT>>(v2);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<NFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, 0x2::tx_context::sender(arg1));
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

    public entry fun list_nft_personal<T0: store + key>(arg0: &mut Store, arg1: &mut 0x2::kiosk::Kiosk, arg2: &mut PersonalKioskCap, arg3: 0x2::object::ID, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = borrow_val(arg2);
        let v2 = v0;
        return_val(arg2, v2, v1);
        let v3 = Listing<T0>{
            id          : 0x2::object::new(arg5),
            seller      : 0x2::tx_context::sender(arg5),
            kiosk_id    : 0x2::object::id<0x2::kiosk::Kiosk>(arg1),
            nft_id      : arg3,
            cap         : 0x2::kiosk::list_with_purchase_cap<T0>(arg1, &v2, arg3, arg4, arg5),
            price       : arg4,
            commission  : 0,
            beneficiary : 0x2::tx_context::sender(arg5),
        };
        0x2::dynamic_object_field::add<0x2::object::ID, Listing<T0>>(&mut arg0.id, arg3, v3);
        let v4 = NFTListed{
            id    : arg3,
            price : arg4,
            owner : 0x2::kiosk::owner(arg1),
        };
        0x2::event::emit<NFTListed>(v4);
    }

    public entry fun place_nft_in_kiosk(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: NFT, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::kiosk::owner(arg0) == 0x2::tx_context::sender(arg3), 3);
        0x2::kiosk::place<NFT>(arg0, arg1, arg2);
    }

    public fun return_val(arg0: &mut PersonalKioskCap, arg1: 0x2::kiosk::KioskOwnerCap, arg2: Borrow) {
        let Borrow {
            owned_id : v0,
            cap_id   : v1,
        } = arg2;
        assert!(0x2::object::id<PersonalKioskCap>(arg0) == v0, 101);
        assert!(0x2::object::id<0x2::kiosk::KioskOwnerCap>(&arg1) == v1, 102);
        0x1::option::fill<0x2::kiosk::KioskOwnerCap>(&mut arg0.cap, arg1);
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

