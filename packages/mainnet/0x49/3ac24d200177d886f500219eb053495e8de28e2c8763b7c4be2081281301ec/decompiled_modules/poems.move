module 0x493ac24d200177d886f500219eb053495e8de28e2c8763b7c4be2081281301ec::poems {
    struct POEMS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct ImageArchive has store, key {
        id: 0x2::object::UID,
        poem: 0x1::string::String,
        data: vector<u8>,
        sha256: vector<u8>,
        finalized: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        poem_text: 0x1::string::String,
        licence: 0x1::string::String,
        provenance: 0x1::string::String,
        image_archive: 0x2::object::ID,
        image_sha256: vector<u8>,
        thumb_data_uri: 0x1::string::String,
        royalty_bps: u16,
        cap: u64,
        reserved: u64,
        reserved_minted: u64,
        public_minted: u64,
        finalized: bool,
        sealed: bool,
    }

    struct PoemNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        edition: u64,
        cap: u64,
        collection: 0x2::object::ID,
        image_sha256: vector<u8>,
        thumb_data_uri: 0x1::string::String,
        licence: 0x1::string::String,
        provenance: 0x1::string::String,
    }

    public fun claim(arg0: &mut Collection, arg1: &mut 0x2::kiosk::Kiosk, arg2: &0x2::kiosk::KioskOwnerCap, arg3: &0x2::transfer_policy::TransferPolicy<PoemNFT>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.finalized, 1);
        assert!(!arg0.sealed, 6);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(!0x2::dynamic_field::exists<address>(&arg0.id, v0), 4);
        assert!(arg0.reserved + arg0.public_minted < arg0.cap, 5);
        0x2::dynamic_field::add<address, bool>(&mut arg0.id, v0, true);
        arg0.public_minted = arg0.public_minted + 1;
        0x2::kiosk::lock<PoemNFT>(arg1, arg2, arg3, mint(arg0, arg0.reserved + arg0.public_minted, arg4));
    }

    public fun append_image(arg0: &AdminCap, arg1: &mut ImageArchive, arg2: vector<u8>) {
        assert!(!arg1.finalized, 2);
        0x1::vector::append<u8>(&mut arg1.data, arg2);
    }

    public fun append_thumb(arg0: &AdminCap, arg1: &mut Collection, arg2: 0x1::string::String) {
        assert!(!arg1.finalized, 2);
        0x1::string::append(&mut arg1.thumb_data_uri, arg2);
    }

    public fun archive_len(arg0: &ImageArchive) : u64 {
        0x1::vector::length<u8>(&arg0.data)
    }

    public fun buy_and_lock(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::transfer_policy::TransferPolicy<PoemNFT>, arg5: &mut 0x2::kiosk::Kiosk, arg6: &0x2::kiosk::KioskOwnerCap) {
        let (v0, v1) = 0x2::kiosk::purchase<PoemNFT>(arg0, arg1, arg2);
        let v2 = v1;
        0x2::kiosk::lock<PoemNFT>(arg5, arg6, arg4, v0);
        0x493ac24d200177d886f500219eb053495e8de28e2c8763b7c4be2081281301ec::rules::pay_royalty<PoemNFT>(arg4, &mut v2, arg3);
        0x493ac24d200177d886f500219eb053495e8de28e2c8763b7c4be2081281301ec::rules::prove_lock<PoemNFT>(arg4, &mut v2, arg5);
        let (_, _, _) = 0x2::transfer_policy::confirm_request<PoemNFT>(arg4, v2);
    }

    public fun claim_with_new_kiosk(arg0: &mut Collection, arg1: &0x2::transfer_policy::TransferPolicy<PoemNFT>, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::kiosk::new(arg2);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        claim(arg0, v4, &v2, arg1, arg2);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v3);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v2, 0x2::tx_context::sender(arg2));
    }

    public fun create_collection(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::object::ID, arg6: vector<u8>, arg7: u16, arg8: u64, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = Collection{
            id              : 0x2::object::new(arg10),
            name            : arg1,
            poem_text       : arg2,
            licence         : arg3,
            provenance      : arg4,
            image_archive   : arg5,
            image_sha256    : arg6,
            thumb_data_uri  : 0x1::string::utf8(b""),
            royalty_bps     : arg7,
            cap             : arg8,
            reserved        : arg9,
            reserved_minted : 0,
            public_minted   : 0,
            finalized       : false,
            sealed          : false,
        };
        0x2::transfer::share_object<Collection>(v0);
        0x2::object::id<Collection>(&v0)
    }

    public fun finalize_archive(arg0: &AdminCap, arg1: ImageArchive, arg2: vector<u8>, arg3: vector<u8>) : 0x2::object::ID {
        assert!(!arg1.finalized, 2);
        assert!(0x2::hash::blake2b256(&arg1.data) == arg2, 3);
        arg1.sha256 = arg3;
        arg1.finalized = true;
        0x2::transfer::freeze_object<ImageArchive>(arg1);
        0x2::object::id<ImageArchive>(&arg1)
    }

    public fun finalize_collection(arg0: &AdminCap, arg1: &mut Collection) {
        assert!(!arg1.finalized, 2);
        assert!(!0x1::string::is_empty(&arg1.thumb_data_uri), 1);
        arg1.finalized = true;
    }

    fun init(arg0: POEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<POEMS>(arg0, arg1);
        let v1 = 0x2::display::new<PoemNFT>(&v0, arg1);
        0x2::display::add<PoemNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(x"7b6e616d657d20e280942065646974696f6e207b65646974696f6e7d206f66207b6361707d"));
        0x2::display::add<PoemNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{licence}"));
        0x2::display::add<PoemNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{thumb_data_uri}"));
        0x2::display::add<PoemNFT>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"trackrecord.sui"));
        0x2::display::update_version<PoemNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<PoemNFT>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
    }

    public fun is_finalized(arg0: &Collection) : bool {
        arg0.finalized
    }

    public fun is_sealed(arg0: &Collection) : bool {
        arg0.sealed
    }

    fun mint(arg0: &Collection, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : PoemNFT {
        PoemNFT{
            id             : 0x2::object::new(arg2),
            name           : arg0.name,
            edition        : arg1,
            cap            : arg0.cap,
            collection     : 0x2::object::id<Collection>(arg0),
            image_sha256   : arg0.image_sha256,
            thumb_data_uri : arg0.thumb_data_uri,
            licence        : arg0.licence,
            provenance     : arg0.provenance,
        }
    }

    public fun mint_reserved(arg0: &AdminCap, arg1: &mut Collection, arg2: &mut 0x2::kiosk::Kiosk, arg3: &0x2::kiosk::KioskOwnerCap, arg4: &0x2::transfer_policy::TransferPolicy<PoemNFT>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.finalized, 1);
        assert!(!arg1.sealed, 6);
        assert!(arg1.reserved_minted < arg1.reserved, 7);
        arg1.reserved_minted = arg1.reserved_minted + 1;
        0x2::kiosk::lock<PoemNFT>(arg2, arg3, arg4, mint(arg1, arg1.reserved_minted, arg5));
    }

    public fun minted(arg0: &Collection) : (u64, u64) {
        (arg0.reserved_minted, arg0.public_minted)
    }

    public fun new_archive(arg0: &AdminCap, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ImageArchive{
            id        : 0x2::object::new(arg2),
            poem      : arg1,
            data      : b"",
            sha256    : b"",
            finalized : false,
        };
        0x2::transfer::public_transfer<ImageArchive>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun new_policy(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) : (0x2::transfer_policy::TransferPolicy<PoemNFT>, 0x2::transfer_policy::TransferPolicyCap<PoemNFT>) {
        0x2::transfer_policy::new<PoemNFT>(arg0, arg1)
    }

    public fun seal(arg0: &AdminCap, arg1: &mut Collection) {
        arg1.sealed = true;
    }

    // decompiled from Move bytecode v7
}

