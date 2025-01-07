module 0x8144d2f10fdb390aff73c0c0e53091c0ed40b2419cc82e27c239674a1c13b2f3::suimap {
    struct Config has store, key {
        id: 0x2::object::UID,
        current_id: u256,
        start_time: u64,
        version: u64,
        admin: address,
        block_minted: 0x2::table::Table<u64, bool>,
    }

    struct InscriptionsData has store, key {
        id: 0x2::object::UID,
        current_id: u256,
        sui_number: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        inscription: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        contents: vector<0x1::string::String>,
        content_size: u64,
        extention_type: 0x1::string::String,
    }

    struct InstructionsMintEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        current_id: u256,
        sui_number: u64,
    }

    struct BurnInstructionsBurnEvent has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        current_id: u256,
        sui_number: u64,
    }

    struct SUIMAP has drop {
        dummy_field: bool,
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public entry fun burn(arg0: InscriptionsData, arg1: &mut 0x2::tx_context::TxContext) {
        let InscriptionsData {
            id             : v0,
            current_id     : v1,
            sui_number     : v2,
            name           : v3,
            description    : v4,
            inscription    : _,
            image_url      : v6,
            external_link  : v7,
            contents       : _,
            content_size   : _,
            extention_type : _,
        } = arg0;
        let v11 = v0;
        let v12 = BurnInstructionsBurnEvent{
            id            : 0x2::object::uid_to_inner(&v11),
            name          : v3,
            description   : v4,
            image_url     : v6,
            external_link : v7,
            current_id    : v1,
            sui_number    : v2,
        };
        0x2::event::emit<BurnInstructionsBurnEvent>(v12);
        0x2::object::delete(v11);
    }

    fun init(arg0: SUIMAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"inscription"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{inscription}"));
        let v4 = Config{
            id           : 0x2::object::new(arg1),
            current_id   : 0,
            start_time   : 1703298545000,
            version      : 1,
            admin        : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            block_minted : 0x2::table::new<u64, bool>(arg1),
        };
        0x2::transfer::public_share_object<Config>(v4);
        let v5 = 0x2::package::claim<SUIMAP>(arg0, arg1);
        let v6 = 0x2::display::new_with_fields<InscriptionsData>(&v5, v0, v2, arg1);
        0x2::display::update_version<InscriptionsData>(&mut v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v5, @0x2);
        0x2::transfer::public_transfer<0x2::display::Display<InscriptionsData>>(v6, @0x2);
    }

    public entry fun migrate_version(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.version = 1;
    }

    fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u256, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : InscriptionsData {
        let v0 = InscriptionsData{
            id             : 0x2::object::new(arg8),
            current_id     : arg2,
            sui_number     : arg3,
            name           : arg0,
            description    : arg1,
            inscription    : arg0,
            image_url      : arg4,
            external_link  : arg5,
            contents       : 0x1::vector::empty<0x1::string::String>(),
            content_size   : arg6,
            extention_type : arg7,
        };
        let v1 = InstructionsMintEvent{
            id            : 0x2::object::uid_to_inner(&v0.id),
            name          : arg0,
            description   : arg1,
            image_url     : arg4,
            external_link : arg5,
            current_id    : arg2,
            sui_number    : arg3,
        };
        0x2::event::emit<InstructionsMintEvent>(v1);
        v0
    }

    public entry fun mint_suimap(arg0: &0x2::clock::Clock, arg1: &mut Config, arg2: u64, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert_version(arg1.version);
        assert!(!0x2::table::contains<u64, bool>(&arg1.block_minted, arg2), 5);
        assert!(0x2::clock::timestamp_ms(arg0) > arg1.start_time, 6);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= 5000000, 4);
        let v1 = arg1.current_id + 1;
        arg1.current_id = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, @0x42767ede98e1d19262103774e0e9fbad54340be037b4b925ed422ef75f0d293a);
        assert!(arg2 < 0x2::tx_context::epoch(arg4) * 1000, 7);
        let v2 = num_str(arg2);
        0x1::string::append(&mut v2, 0x1::string::utf8(b".epoch-"));
        0x1::string::append(&mut v2, num_str(arg2 / 1000));
        0x1::string::append(&mut v2, 0x1::string::utf8(b".suimap"));
        let v3 = 0x1::string::utf8(b"https://ipfs.bluemove.net/aptmap/");
        0x1::string::append(&mut v3, num_str(arg2));
        0x1::string::append(&mut v3, 0x1::string::utf8(b".png"));
        let v4 = mint_nft(v2, v2, v1, arg2, v3, 0x1::string::utf8(b"https://sui.bluemove.net/"), 0x1::string::length(&v2), 0x1::string::utf8(b"image"), arg4);
        0x1::vector::push_back<0x1::string::String>(&mut v4.contents, v2);
        0x2::transfer::public_transfer<InscriptionsData>(v4, v0);
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public entry fun set_new_admin(arg0: &mut Config, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    public entry fun update_start_time(arg0: &mut Config, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.start_time = arg1;
    }

    // decompiled from Move bytecode v6
}

