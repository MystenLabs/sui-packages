module 0x70ba05f967df5348bb7f3a3a614ca48353a340adffba1e4c6046aa974a26664c::SuiFlow {
    struct NFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct NFTUpdated has copy, drop {
        object_id: 0x2::object::ID,
        updater: address,
        name: 0x1::string::String,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        url: 0x2::url::Url,
        symbol: 0x1::option::Option<0x1::string::String>,
        attribute_keys: vector<0x1::string::String>,
        attribute_values: vector<0x1::string::String>,
        creator: address,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Config has key {
        id: 0x2::object::UID,
        allowed_minters: 0x2::table::Table<address, bool>,
    }

    struct SUIFLOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIFLOW>(arg0, arg1);
        let v1 = 0x2::display::new<Nft>(&v0, arg1);
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Nft>(&mut v1, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"{creator}"));
        0x2::display::update_version<Nft>(&mut v1);
        let v2 = 0x2::table::new<address, bool>(arg1);
        let v3 = @0xfff953ec5eac874d97ef8b771f9b2bda6eeaf633197784838b45c66ad8cbabe;
        let v4 = @0xdb8cbeb195e772d2e7d76d7f5a310b8f0c146c5048dab479007187a510db034;
        0x2::table::add<address, bool>(&mut v2, v3, true);
        0x2::table::add<address, bool>(&mut v2, v4, true);
        let v5 = Config{
            id              : 0x2::object::new(arg1),
            allowed_minters : v2,
        };
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        let v7 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Nft>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Config>(v5);
        0x2::transfer::transfer<AdminCap>(v6, v3);
        0x2::transfer::transfer<AdminCap>(v7, v4);
    }

    public entry fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &AdminCap, arg6: &Config, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::table::contains<address, bool>(&arg6.allowed_minters, v0) && *0x2::table::borrow<address, bool>(&arg6.allowed_minters, v0), 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg3) == 0x1::vector::length<0x1::string::String>(&arg4), 2);
        let v1 = Nft{
            id               : 0x2::object::new(arg7),
            name             : arg0,
            description      : arg1,
            image_url        : arg2,
            url              : 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg2)),
            symbol           : 0x1::option::none<0x1::string::String>(),
            attribute_keys   : arg3,
            attribute_values : arg4,
            creator          : v0,
        };
        let v2 = NFTMinted{
            object_id : 0x2::object::id<Nft>(&v1),
            creator   : v0,
            name      : v1.name,
        };
        0x2::event::emit<NFTMinted>(v2);
        0x2::transfer::public_transfer<Nft>(v1, v0);
    }

    public entry fun update_metadata(arg0: &mut Nft, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: &AdminCap, arg7: &Config, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(0x2::table::contains<address, bool>(&arg7.allowed_minters, v0) && *0x2::table::borrow<address, bool>(&arg7.allowed_minters, v0), 1);
        assert!(0x1::vector::length<0x1::string::String>(&arg4) == 0x1::vector::length<0x1::string::String>(&arg5), 2);
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.image_url = arg3;
        arg0.url = 0x2::url::new_unsafe_from_bytes(*0x1::string::as_bytes(&arg3));
        arg0.attribute_keys = arg4;
        arg0.attribute_values = arg5;
        let v1 = NFTUpdated{
            object_id : 0x2::object::id<Nft>(arg0),
            updater   : v0,
            name      : arg0.name,
        };
        0x2::event::emit<NFTUpdated>(v1);
    }

    // decompiled from Move bytecode v6
}

