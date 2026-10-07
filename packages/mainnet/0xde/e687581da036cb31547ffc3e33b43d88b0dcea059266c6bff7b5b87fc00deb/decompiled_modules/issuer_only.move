module 0xdee687581da036cb31547ffc3e33b43d88b0dcea059266c6bff7b5b87fc00deb::issuer_only {
    struct ISSUER_ONLY has drop {
        dummy_field: bool,
    }

    struct MintCap has key {
        id: 0x2::object::UID,
        issuer: address,
        issued: u64,
        display_ready: bool,
    }

    struct ArtworkNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        arweave_transaction: 0x1::string::String,
        source_sha256: 0x1::string::String,
        edition: u64,
        issuer: address,
    }

    struct RetiredPolicyAuthority has key {
        id: 0x2::object::UID,
        cap: 0x2::transfer_policy::TransferPolicyCap<ArtworkNFT>,
    }

    struct RetiredDisplayAuthority has key {
        id: 0x2::object::UID,
        cap: 0x2::display_registry::DisplayCap<ArtworkNFT>,
    }

    struct NFTIssued has copy, drop {
        object_id: 0x2::object::ID,
        edition: u64,
        issuer: address,
    }

    fun init(arg0: ISSUER_ONLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<ISSUER_ONLY>(arg0, arg1);
        let (v1, v2) = 0x2::transfer_policy::new<ArtworkNFT>(&v0, arg1);
        0x2::transfer::public_freeze_object<0x2::transfer_policy::TransferPolicy<ArtworkNFT>>(v1);
        let v3 = RetiredPolicyAuthority{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::freeze_object<RetiredPolicyAuthority>(v3);
        0x2::package::burn_publisher(v0);
        let v4 = MintCap{
            id            : 0x2::object::new(arg1),
            issuer        : 0x2::tx_context::sender(arg1),
            issued        : 0,
            display_ready : false,
        };
        0x2::transfer::transfer<MintCap>(v4, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_display(arg0: &mut 0x2::display_registry::DisplayRegistry, arg1: &mut MintCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.issuer == 0x2::tx_context::sender(arg2), 0);
        assert!(!arg1.display_ready, 3);
        let (v0, v1) = 0x2::display_registry::new<ArtworkNFT>(arg0, 0x1::internal::permit<ArtworkNFT>(), arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"thumbnail_url"), 0x1::string::utf8(b"{url}"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"collection"), 0x1::string::utf8(b"AI Evolution in Artwork"));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"collection_description"), 0x1::string::utf8(b"Prompt: Create an artistic SVG where you give uncertainty a visual form. Make it beautiful without making it disappear. Dimensions 1200x1200 pixels."));
        0x2::display_registry::set<ArtworkNFT>(&mut v3, &v2, 0x1::string::utf8(b"edition"), 0x1::string::utf8(b"{edition}"));
        0x2::display_registry::share<ArtworkNFT>(v3);
        let v4 = RetiredDisplayAuthority{
            id  : 0x2::object::new(arg2),
            cap : v2,
        };
        0x2::transfer::freeze_object<RetiredDisplayAuthority>(v4);
        arg1.display_ready = true;
    }

    public fun mint(arg0: &mut MintCap, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg0.issuer == 0x2::tx_context::sender(arg5), 0);
        assert!(arg0.display_ready, 4);
        validate_arweave_id(&arg3);
        validate_hash(&arg4);
        arg0.issued = arg0.issued + 1;
        let v0 = b"https://turbo-gateway.com/";
        0x1::vector::append<u8>(&mut v0, arg3);
        let v1 = ArtworkNFT{
            id                  : 0x2::object::new(arg5),
            name                : 0x1::string::utf8(arg1),
            description         : 0x1::string::utf8(arg2),
            url                 : 0x2::url::new_unsafe_from_bytes(v0),
            arweave_transaction : 0x1::string::utf8(arg3),
            source_sha256       : 0x1::string::utf8(arg4),
            edition             : arg0.issued,
            issuer              : arg0.issuer,
        };
        let v2 = 0x2::object::id<ArtworkNFT>(&v1);
        let v3 = NFTIssued{
            object_id : v2,
            edition   : v1.edition,
            issuer    : v1.issuer,
        };
        0x2::event::emit<NFTIssued>(v3);
        0x2::transfer::public_transfer<ArtworkNFT>(v1, 0x2::tx_context::sender(arg5));
        v2
    }

    fun validate_arweave_id(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 43, 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            let v2 = if (v1 >= 65 && v1 <= 90) {
                true
            } else if (v1 >= 97 && v1 <= 122) {
                true
            } else if (v1 >= 48 && v1 <= 57) {
                true
            } else if (v1 == 45) {
                true
            } else {
                v1 == 95
            };
            assert!(v2, 1);
            v0 = v0 + 1;
        };
    }

    fun validate_hash(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 64, 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            assert!(v1 >= 48 && v1 <= 57 || v1 >= 97 && v1 <= 102, 2);
            v0 = v0 + 1;
        };
    }

    // decompiled from Move bytecode v7
}

