module 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::snotra_nft {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct SnotraNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata: 0x2::table::Table<0x1::string::String, 0x1::string::String>,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        owners: 0x2::table::Table<address, bool>,
    }

    struct SNOTRA_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNOTRA_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://snotra.tech"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nmthfmcy2nzq5rpzs7zbgdymgvv666hluqgr65ay267ib6hp4b6q.arweave.net/ayZysFjTcw7F-ZfyEw8MNWvveOukDR90GNe-gPjv4H0"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"A true Hero of the Sui ecosystem!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nmthfmcy2nzq5rpzs7zbgdymgvv666hluqgr65ay267ib6hp4b6q.arweave.net/ayZysFjTcw7F-ZfyEw8MNWvveOukDR90GNe-gPjv4H0"));
        let v4 = 0x2::package::claim<SNOTRA_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SnotraNft>(&v4, v0, v2, arg1);
        0x2::display::update_version<SnotraNft>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        let v7 = Storage{
            id     : 0x2::object::new(arg1),
            owners : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<Storage>(v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SnotraNft>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint_nft(arg0: &AdminCap, arg1: &mut Storage, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, bool>(&arg1.owners, arg2) == false, 1);
        0x2::table::add<address, bool>(&mut arg1.owners, arg2, true);
        let v0 = SnotraNft{
            id        : 0x2::object::new(arg3),
            name      : 0x1::string::utf8(b"Snotra Early Access"),
            image_url : 0x1::string::utf8(b"https://nmthfmcy2nzq5rpzs7zbgdymgvv666hluqgr65ay267ib6hp4b6q.arweave.net/ayZysFjTcw7F-ZfyEw8MNWvveOukDR90GNe-gPjv4H0"),
            metadata  : 0x2::table::new<0x1::string::String, 0x1::string::String>(arg3),
        };
        0x2::transfer::transfer<SnotraNft>(v0, arg2);
    }

    public fun update_nft_metadata(arg0: &AdminCap, arg1: &mut SnotraNft, arg2: 0x1::string::String, arg3: 0x1::string::String) {
        0x2::table::add<0x1::string::String, 0x1::string::String>(&mut arg1.metadata, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

