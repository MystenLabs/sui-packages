module 0xd79d252b6b977493c0e0ad8b62c68b7d4ac594850358b7fe9cc6e6736436d5a5::artwork {
    struct ARTWORK has drop {
        dummy_field: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        issuer: address,
        name: 0x1::string::String,
        description: 0x1::string::String,
        metadata_sealed: bool,
        minting_closed: bool,
        issued: u64,
        open_drafts: u64,
        royalty_basis_points: u16,
        royalty_recipient: address,
    }

    struct Metadata has store {
        name: 0x1::string::String,
        description: 0x1::string::String,
        artwork_url: 0x1::string::String,
        artwork_fallback_url: 0x1::string::String,
        image_url: 0x1::string::String,
        arweave_transaction: 0x1::string::String,
        source_sha256: 0x1::string::String,
        image_arweave_transaction: 0x1::string::String,
        image_sha256: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct DraftNFT has key {
        id: 0x2::object::UID,
        collection_id: 0x2::object::ID,
        metadata: Metadata,
    }

    struct ArtworkNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        artwork_url: 0x1::string::String,
        artwork_fallback_url: 0x1::string::String,
        image_url: 0x1::string::String,
        arweave_transaction: 0x1::string::String,
        source_sha256: 0x1::string::String,
        image_arweave_transaction: 0x1::string::String,
        image_sha256: 0x1::string::String,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        collection_id: 0x2::object::ID,
        edition: u64,
        issuer: address,
        finalized: bool,
    }

    struct RetiredDisplayAuthority has key {
        id: 0x2::object::UID,
        cap: 0x2::display_registry::DisplayCap<ArtworkNFT>,
    }

    struct RetiredPolicyAuthority has key {
        id: 0x2::object::UID,
        cap: 0x2::transfer_policy::TransferPolicyCap<ArtworkNFT>,
        recipient: address,
    }

    struct Finalized has copy, drop {
        draft_id: 0x2::object::ID,
        nft_id: 0x2::object::ID,
        collection_id: 0x2::object::ID,
        edition: u64,
        kiosk_id: 0x2::object::ID,
    }

    struct MintingClosed has copy, drop {
        collection_id: 0x2::object::ID,
        final_supply: u64,
    }

    fun authorize(arg0: &Collection, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.issuer, 0);
        assert!(!arg0.minting_closed, 1);
    }

    fun authorize_draft(arg0: &Collection, arg1: &DraftNFT, arg2: &0x2::tx_context::TxContext) {
        authorize(arg0, arg2);
        assert!(arg1.collection_id == 0x2::object::id<Collection>(arg0), 4);
    }

    public fun close_minting(arg0: &mut Collection, arg1: &0x2::tx_context::TxContext) {
        authorize(arg0, arg1);
        assert!(arg0.metadata_sealed, 3);
        assert!(arg0.open_drafts == 0, 5);
        arg0.minting_closed = true;
        let v0 = MintingClosed{
            collection_id : 0x2::object::id<Collection>(arg0),
            final_supply  : arg0.issued,
        };
        0x2::event::emit<MintingClosed>(v0);
    }

    public fun create_draft(arg0: &mut Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        authorize(arg0, arg3);
        assert!(0x1::vector::length<u8>(&arg1) <= 256 && 0x1::vector::length<u8>(&arg2) <= 16384, 6);
        let v0 = Metadata{
            name                      : 0x1::string::utf8(arg1),
            description               : 0x1::string::utf8(arg2),
            artwork_url               : 0x1::string::utf8(b""),
            artwork_fallback_url      : 0x1::string::utf8(b""),
            image_url                 : 0x1::string::utf8(b""),
            arweave_transaction       : 0x1::string::utf8(b""),
            source_sha256             : 0x1::string::utf8(b""),
            image_arweave_transaction : 0x1::string::utf8(b""),
            image_sha256              : 0x1::string::utf8(b""),
            attributes                : 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>(),
        };
        let v1 = DraftNFT{
            id            : 0x2::object::new(arg3),
            collection_id : 0x2::object::id<Collection>(arg0),
            metadata      : v0,
        };
        arg0.open_drafts = arg0.open_drafts + 1;
        0x2::transfer::transfer<DraftNFT>(v1, 0x2::tx_context::sender(arg3));
        0x2::object::id<DraftNFT>(&v1)
    }

    fun destroy_metadata(arg0: Metadata) {
        let Metadata {
            name                      : _,
            description               : _,
            artwork_url               : _,
            artwork_fallback_url      : _,
            image_url                 : _,
            arweave_transaction       : _,
            source_sha256             : _,
            image_arweave_transaction : _,
            image_sha256              : _,
            attributes                : _,
        } = arg0;
    }

    public fun discard_draft(arg0: &mut Collection, arg1: DraftNFT, arg2: &0x2::tx_context::TxContext) {
        authorize_draft(arg0, &arg1, arg2);
        let DraftNFT {
            id            : v0,
            collection_id : _,
            metadata      : v2,
        } = arg1;
        destroy_metadata(v2);
        0x2::object::delete(v0);
        arg0.open_drafts = arg0.open_drafts - 1;
    }

    public fun finalize(arg0: &mut Collection, arg1: DraftNFT, arg2: &0x2::transfer_policy::TransferPolicy<ArtworkNFT>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        authorize_draft(arg0, &arg1, arg3);
        assert!(arg0.metadata_sealed, 3);
        assert!(0x1::string::length(&arg1.metadata.name) > 0, 6);
        valid_url(&arg1.metadata.artwork_url, false);
        valid_url(&arg1.metadata.artwork_fallback_url, true);
        valid_url(&arg1.metadata.image_url, false);
        valid_hash(&arg1.metadata.source_sha256);
        valid_hash(&arg1.metadata.image_sha256);
        valid_id(&arg1.metadata.arweave_transaction);
        valid_id(&arg1.metadata.image_arweave_transaction);
        let DraftNFT {
            id            : v0,
            collection_id : v1,
            metadata      : v2,
        } = arg1;
        0x2::object::delete(v0);
        let Metadata {
            name                      : v3,
            description               : v4,
            artwork_url               : v5,
            artwork_fallback_url      : v6,
            image_url                 : v7,
            arweave_transaction       : v8,
            source_sha256             : v9,
            image_arweave_transaction : v10,
            image_sha256              : v11,
            attributes                : v12,
        } = v2;
        arg0.issued = arg0.issued + 1;
        arg0.open_drafts = arg0.open_drafts - 1;
        let v13 = ArtworkNFT{
            id                        : 0x2::object::new(arg3),
            name                      : v3,
            description               : v4,
            artwork_url               : v5,
            artwork_fallback_url      : v6,
            image_url                 : v7,
            arweave_transaction       : v8,
            source_sha256             : v9,
            image_arweave_transaction : v10,
            image_sha256              : v11,
            attributes                : v12,
            collection_id             : v1,
            edition                   : arg0.issued,
            issuer                    : arg0.issuer,
            finalized                 : true,
        };
        let v14 = 0x2::object::id<ArtworkNFT>(&v13);
        let (v15, v16) = 0x2::kiosk::new(arg3);
        let v17 = v16;
        let v18 = v15;
        0x2::kiosk::lock<ArtworkNFT>(&mut v18, &v17, arg2, v13);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk::create_for(&mut v18, v17, 0x2::tx_context::sender(arg3), arg3);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v18);
        let v19 = Finalized{
            draft_id      : 0x2::object::id<DraftNFT>(&arg1),
            nft_id        : v14,
            collection_id : v1,
            edition       : arg0.issued,
            kiosk_id      : 0x2::object::id<0x2::kiosk::Kiosk>(&v18),
        };
        0x2::event::emit<Finalized>(v19);
        v14
    }

    fun init(arg0: ARTWORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ARTWORK>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<ArtworkNFT>(&v0, arg1);
        let v3 = v2;
        let v4 = v1;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<ArtworkNFT>(&mut v4, &v3, 200, 1);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<ArtworkNFT>(&mut v4, &v3);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::personal_kiosk_rule::add<ArtworkNFT>(&mut v4, &v3);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<ArtworkNFT>>(v4);
        let v5 = RetiredPolicyAuthority{
            id        : 0x2::object::new(arg1),
            cap       : v3,
            recipient : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::freeze_object<RetiredPolicyAuthority>(v5);
        0x2::package::burn_publisher(v0);
        0x2::transfer::share_object<Collection>(new_collection(arg1));
    }

    fun new_collection(arg0: &mut 0x2::tx_context::TxContext) : Collection {
        Collection{
            id                   : 0x2::object::new(arg0),
            issuer               : 0x2::tx_context::sender(arg0),
            name                 : 0x1::string::utf8(b""),
            description          : 0x1::string::utf8(b""),
            metadata_sealed      : false,
            minting_closed       : false,
            issued               : 0,
            open_drafts          : 0,
            royalty_basis_points : 200,
            royalty_recipient    : 0x2::tx_context::sender(arg0),
        }
    }

    public fun remove_attribute(arg0: &Collection, arg1: &mut DraftNFT, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        authorize_draft(arg0, arg1, arg3);
        let v0 = 0x1::string::utf8(arg2);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.metadata.attributes, &v0)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x1::string::String>(&mut arg1.metadata.attributes, &v0);
        };
    }

    public fun seal_collection(arg0: &mut Collection, arg1: &mut 0x2::display_registry::DisplayRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        authorize(arg0, arg2);
        assert!(!arg0.metadata_sealed, 2);
        assert!(0x1::string::length(&arg0.name) > 0, 6);
        let (v0, v1) = 0x2::display_registry::new<ArtworkNFT>(arg1, 0x1::internal::permit<ArtworkNFT>(), arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"{artwork_url}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"artwork_fallback_url"), 0x1::string::utf8(b"{artwork_fallback_url}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"collection"), arg0.name);
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"collection_description"), arg0.description);
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"collection_id"), 0x1::string::utf8(b"{collection_id}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"finalized"), 0x1::string::utf8(b"{finalized}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"royalty_basis_points"), 0x1::string::utf8(b"200"));
        0x2::display_registry::share<ArtworkNFT>(v3);
        let v4 = RetiredDisplayAuthority{
            id  : 0x2::object::new(arg2),
            cap : v2,
        };
        0x2::transfer::freeze_object<RetiredDisplayAuthority>(v4);
        arg0.metadata_sealed = true;
    }

    public fun set_attribute(arg0: &Collection, arg1: &mut DraftNFT, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        authorize_draft(arg0, arg1, arg4);
        let v0 = if (0x1::vector::length<u8>(&arg2) > 0) {
            if (0x1::vector::length<u8>(&arg2) <= 128) {
                0x1::vector::length<u8>(&arg3) <= 4096
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        let v1 = 0x1::string::utf8(arg2);
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg1.metadata.attributes, &v1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg1.metadata.attributes, &v1) = 0x1::string::utf8(arg3);
        } else {
            assert!(0x2::vec_map::length<0x1::string::String, 0x1::string::String>(&arg1.metadata.attributes) < 64, 6);
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg1.metadata.attributes, v1, 0x1::string::utf8(arg3));
        };
    }

    public fun set_collection(arg0: &mut Collection, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) {
        authorize(arg0, arg3);
        assert!(!arg0.metadata_sealed, 2);
        let v0 = if (0x1::vector::length<u8>(&arg1) > 0) {
            if (0x1::vector::length<u8>(&arg1) <= 256) {
                0x1::vector::length<u8>(&arg2) <= 16384
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 6);
        arg0.name = 0x1::string::utf8(arg1);
        arg0.description = 0x1::string::utf8(arg2);
    }

    public fun set_field(arg0: &Collection, arg1: &mut DraftNFT, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        authorize_draft(arg0, arg1, arg4);
        assert!(0x1::vector::length<u8>(&arg3) <= 16384, 6);
        let v0 = 0x1::string::utf8(arg3);
        if (arg2 == b"name") {
            assert!(0x1::string::length(&v0) <= 256, 6);
            arg1.metadata.name = v0;
        } else if (arg2 == b"description") {
            arg1.metadata.description = v0;
        } else if (arg2 == b"artwork_url") {
            arg1.metadata.artwork_url = v0;
        } else if (arg2 == b"artwork_fallback_url") {
            arg1.metadata.artwork_fallback_url = v0;
        } else if (arg2 == b"image_url") {
            arg1.metadata.image_url = v0;
        } else if (arg2 == b"arweave_transaction") {
            arg1.metadata.arweave_transaction = v0;
        } else if (arg2 == b"source_sha256") {
            arg1.metadata.source_sha256 = v0;
        } else if (arg2 == b"image_arweave_transaction") {
            arg1.metadata.image_arweave_transaction = v0;
        } else {
            assert!(arg2 == b"image_sha256", 7);
            arg1.metadata.image_sha256 = v0;
        };
    }

    fun valid_hash(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        assert!(0x1::vector::length<u8>(v0) == 64, 6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            assert!(v2 >= 48 && v2 <= 57 || v2 >= 97 && v2 <= 102, 6);
            v1 = v1 + 1;
        };
    }

    fun valid_id(arg0: &0x1::string::String) {
        let v0 = 0x1::string::as_bytes(arg0);
        if (0x1::vector::is_empty<u8>(v0)) {
            return
        };
        assert!(0x1::vector::length<u8>(v0) == 43, 6);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(v0)) {
            let v2 = *0x1::vector::borrow<u8>(v0, v1);
            let v3 = if (v2 >= 65 && v2 <= 90) {
                true
            } else if (v2 >= 97 && v2 <= 122) {
                true
            } else if (v2 >= 48 && v2 <= 57) {
                true
            } else if (v2 == 45) {
                true
            } else {
                v2 == 95
            };
            assert!(v3, 6);
            v1 = v1 + 1;
        };
    }

    fun valid_url(arg0: &0x1::string::String, arg1: bool) {
        let v0 = 0x1::string::as_bytes(arg0);
        if (arg1 && 0x1::vector::is_empty<u8>(v0)) {
            return
        };
        assert!(0x1::vector::length<u8>(v0) > 8 && 0x1::vector::length<u8>(v0) <= 4096, 6);
        let v1 = if (*0x1::vector::borrow<u8>(v0, 0) == 104) {
            if (*0x1::vector::borrow<u8>(v0, 1) == 116) {
                if (*0x1::vector::borrow<u8>(v0, 2) == 116) {
                    if (*0x1::vector::borrow<u8>(v0, 3) == 112) {
                        if (*0x1::vector::borrow<u8>(v0, 4) == 115) {
                            if (*0x1::vector::borrow<u8>(v0, 5) == 58) {
                                if (*0x1::vector::borrow<u8>(v0, 6) == 47) {
                                    *0x1::vector::borrow<u8>(v0, 7) == 47
                                } else {
                                    false
                                }
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 6);
    }

    public fun withdraw_royalties(arg0: &mut 0x2::transfer_policy::TransferPolicy<ArtworkNFT>, arg1: &RetiredPolicyAuthority, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::transfer_policy::withdraw<ArtworkNFT>(arg0, &arg1.cap, 0x1::option::none<u64>(), arg2), arg1.recipient);
    }

    // decompiled from Move bytecode v7
}

