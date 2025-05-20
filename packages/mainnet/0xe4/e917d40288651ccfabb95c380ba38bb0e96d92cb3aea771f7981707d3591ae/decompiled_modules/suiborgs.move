module 0xe4e917d40288651ccfabb95c380ba38bb0e96d92cb3aea771f7981707d3591ae::suiborgs {
    struct SUIBORGS has drop {
        dummy_field: bool,
    }

    struct INIT_WHITELIST has drop {
        dummy_field: bool,
    }

    struct Whitelist has store, key {
        id: 0x2::object::UID,
        roles: 0x2::table::Table<address, u8>,
    }

    struct GeneratedNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        metadata: 0x1::string::String,
    }

    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : GeneratedNFT {
        GeneratedNFT{
            id          : 0x2::object::new(arg4),
            name        : arg0,
            description : arg1,
            image_url   : arg2,
            metadata    : arg3,
        }
    }

    public fun transfer(arg0: GeneratedNFT, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<GeneratedNFT>(arg0, arg1);
    }

    public fun add_wl_batch(arg0: &mut Whitelist, arg1: vector<address>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(is_borgs_owner(arg3), 1027);
        let v0 = 0x1::vector::length<address>(&arg1);
        assert!(v0 == 0x1::vector::length<u8>(&arg2), 57005);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = *0x1::vector::borrow<u8>(&arg2, v1);
            assert!(v2 == 1 || v2 == 2, 48879);
            0x2::table::add<address, u8>(&mut arg0.roles, *0x1::vector::borrow<address>(&arg1, v1), v2);
            v1 = v1 + 1;
        };
    }

    public fun amout_to_pay(arg0: &Whitelist, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::tx_context::sender(arg1);
        if (!exists(arg0, v0)) {
            5000000000
        } else if (get_role(arg0, v0) == 2) {
            3000000000
        } else {
            0
        }
    }

    public fun exists(arg0: &Whitelist, arg1: address) : bool {
        0x2::table::contains<address, u8>(&arg0.roles, arg1)
    }

    public fun get_role(arg0: &Whitelist, arg1: address) : u8 {
        if (0x2::table::contains<address, u8>(&arg0.roles, arg1)) {
            *0x2::table::borrow<address, u8>(&arg0.roles, arg1)
        } else {
            255
        }
    }

    fun init(arg0: SUIBORGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIBORGS>(arg0, arg1);
        let v1 = 0x2::display::new<GeneratedNFT>(&v0, arg1);
        0x2::display::add<GeneratedNFT>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<GeneratedNFT>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<GeneratedNFT>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<GeneratedNFT>(&mut v1, 0x1::string::utf8(b"metadata"), 0x1::string::utf8(b"{metadata}"));
        0x2::display::update_version<GeneratedNFT>(&mut v1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<GeneratedNFT>>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Whitelist{
            id    : 0x2::object::new(arg1),
            roles : 0x2::table::new<address, u8>(arg1),
        };
        0x2::transfer::share_object<Whitelist>(v2);
    }

    public fun is_borgs_owner(arg0: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg0) == @0x63cb64db89b5bdbad83a94c38b562cbd4b0481c778f10dd2c7315ba9f984e6f9
    }

    public fun mint_to_sender(arg0: &Whitelist, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        amout_to_pay(arg0, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg5, @0x63cb64db89b5bdbad83a94c38b562cbd4b0481c778f10dd2c7315ba9f984e6f9);
        let v1 = new(arg1, arg2, arg3, arg4, arg6);
        let v2 = NFTMinted{
            object_id : 0x2::object::id<GeneratedNFT>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::transfer<GeneratedNFT>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

