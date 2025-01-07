module 0x972d86487974aee0ca33068a134466d7e153c6fba6555fe3b9862d8b93980da6::collection {
    struct InscriptionNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        url: 0x1::string::String,
        attributes: 0x972d86487974aee0ca33068a134466d7e153c6fba6555fe3b9862d8b93980da6::attributes::Attributes,
    }

    struct InscriptionNFTInfo has store, key {
        id: 0x2::object::UID,
        publisher: 0x2::package::Publisher,
        display: 0x2::display::Display<InscriptionNFT>,
        policy_cap: 0x2::transfer_policy::TransferPolicyCap<InscriptionNFT>,
    }

    struct COLLECTION has drop {
        dummy_field: bool,
    }

    struct MintCap has store, key {
        id: 0x2::object::UID,
    }

    struct MintEvent has copy, drop {
        nft: 0x2::object::ID,
    }

    public fun append(arg0: &MintCap, arg1: InscriptionNFT, arg2: 0x1::string::String) : InscriptionNFT {
        0x1::string::append(&mut arg1.url, arg2);
        arg1
    }

    public fun finish(arg0: &MintCap, arg1: &0x2::transfer_policy::TransferPolicy<InscriptionNFT>, arg2: &mut vector<InscriptionNFT>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg4);
        let v2 = v1;
        let v3 = v0;
        while (0x1::vector::length<InscriptionNFT>(arg2) > 0) {
            0x2::kiosk::lock<InscriptionNFT>(&mut v3, &v2, arg1, 0x1::vector::pop_back<InscriptionNFT>(arg2));
        };
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, arg3);
    }

    fun init(arg0: COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<COLLECTION>(arg0, arg1);
        let v1 = 0x2::display::new<InscriptionNFT>(&v0, arg1);
        0x2::display::add<InscriptionNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Neon Nibblers Nexus {name}"));
        0x2::display::add<InscriptionNFT>(&mut v1, 0x1::string::utf8(b"attributes"), 0x1::string::utf8(b"{attributes}"));
        0x2::display::add<InscriptionNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<InscriptionNFT>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<InscriptionNFT>(&v0, arg1);
        let v4 = v3;
        let v5 = v2;
        0x972d86487974aee0ca33068a134466d7e153c6fba6555fe3b9862d8b93980da6::royalty_rule::add<InscriptionNFT>(&mut v5, &v4, 600, 0);
        0x972d86487974aee0ca33068a134466d7e153c6fba6555fe3b9862d8b93980da6::kiosk_lock_rule::add<InscriptionNFT>(&mut v5, &v4);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<InscriptionNFT>>(v5);
        let v6 = InscriptionNFTInfo{
            id         : 0x2::object::new(arg1),
            publisher  : v0,
            display    : v1,
            policy_cap : v4,
        };
        0x2::transfer::public_transfer<InscriptionNFTInfo>(v6, 0x2::tx_context::sender(arg1));
        let v7 = MintCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<MintCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &MintCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) : InscriptionNFT {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Mutation"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Job"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, arg3);
        0x1::vector::push_back<0x1::string::String>(v3, arg4);
        let v4 = InscriptionNFT{
            id         : 0x2::object::new(arg5),
            name       : arg2,
            url        : arg1,
            attributes : 0x972d86487974aee0ca33068a134466d7e153c6fba6555fe3b9862d8b93980da6::attributes::from_vec(&mut v0, &mut v2),
        };
        let v5 = MintEvent{nft: 0x2::object::id<InscriptionNFT>(&v4)};
        0x2::event::emit<MintEvent>(v5);
        v4
    }

    // decompiled from Move bytecode v6
}

