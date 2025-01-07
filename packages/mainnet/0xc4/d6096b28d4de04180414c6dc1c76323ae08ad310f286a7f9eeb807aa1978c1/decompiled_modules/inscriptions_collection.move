module 0xc4d6096b28d4de04180414c6dc1c76323ae08ad310f286a7f9eeb807aa1978c1::inscriptions_collection {
    struct CoinConfig has store, key {
        id: 0x2::object::UID,
        current_id: u256,
        version: u64,
        admin: address,
        total: u64,
    }

    struct CoinStore has store, key {
        id: 0x2::object::UID,
        tick: 0x1::string::String,
        max: u64,
        lim: u64,
        total_minted: u64,
        user_minted: 0x2::table::Table<address, UserAmount>,
    }

    struct UserAmount has store {
        tick: 0x1::string::String,
        amount: u64,
    }

    struct Inscriptions has store, key {
        id: 0x2::object::UID,
        current_id: u256,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        p: 0x1::string::String,
        op: 0x1::string::String,
        tick: 0x1::string::String,
        amt: 0x1::option::Option<u64>,
        max: 0x1::option::Option<u64>,
        lim: 0x1::option::Option<u64>,
        contents: vector<0x1::string::String>,
        content_size: u64,
        extention_type: 0x1::string::String,
    }

    struct InstructionsCoin has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        current_id: u256,
        p: 0x1::string::String,
        op: 0x1::string::String,
        tick: 0x1::string::String,
        amt: 0x1::option::Option<u64>,
        max: 0x1::option::Option<u64>,
        lim: 0x1::option::Option<u64>,
    }

    struct BurnInstructionsCoin has copy, drop {
        id: 0x2::object::ID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        external_link: 0x1::string::String,
        current_id: u256,
        p: 0x1::string::String,
        op: 0x1::string::String,
        tick: 0x1::string::String,
        amt: 0x1::option::Option<u64>,
        max: 0x1::option::Option<u64>,
        lim: 0x1::option::Option<u64>,
    }

    fun assert_version(arg0: u64) {
        assert!(arg0 == 1, 1);
    }

    public entry fun burn(arg0: Inscriptions, arg1: &mut 0x2::tx_context::TxContext) {
        let Inscriptions {
            id             : v0,
            current_id     : v1,
            name           : v2,
            description    : v3,
            image_url      : v4,
            external_link  : v5,
            p              : v6,
            op             : v7,
            tick           : v8,
            amt            : v9,
            max            : v10,
            lim            : v11,
            contents       : _,
            content_size   : _,
            extention_type : _,
        } = arg0;
        let v15 = v0;
        let v16 = BurnInstructionsCoin{
            id            : 0x2::object::uid_to_inner(&v15),
            name          : v2,
            description   : v3,
            image_url     : v4,
            external_link : v5,
            current_id    : v1,
            p             : v6,
            op            : v7,
            tick          : v8,
            amt           : v9,
            max           : v10,
            lim           : v11,
        };
        0x2::event::emit<BurnInstructionsCoin>(v16);
        0x2::object::delete(v15);
    }

    public fun deployed_inscriptions(arg0: &mut CoinConfig, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Inscriptions {
        assert_version(arg0.version);
        assert!(!0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 5);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg7) >= 10000000000, 4);
        let v0 = arg0.current_id + 1;
        arg0.current_id = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg7, @0x42767ede98e1d19262103774e0e9fbad54340be037b4b925ed422ef75f0d293a);
        let v1 = CoinStore{
            id           : 0x2::object::new(arg9),
            tick         : arg1,
            max          : arg2,
            lim          : arg3,
            total_minted : 0,
            user_minted  : 0x2::table::new<address, UserAmount>(arg9),
        };
        0x2::dynamic_object_field::add<0x1::string::String, CoinStore>(&mut arg0.id, arg1, v1);
        mint_nft(arg1, 0x1::string::utf8(b"src-20"), v0, arg4, arg5, arg6, arg8, 0x1::string::utf8(b"deploy"), arg1, 0x1::option::none<u64>(), 0x1::option::some<u64>(arg2), 0x1::option::some<u64>(arg3), arg9)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CoinConfig{
            id         : 0x2::object::new(arg0),
            current_id : 0,
            version    : 1,
            admin      : @0x49cc391ab4d3503e03dbb24c4f9e28f3cdd2ddf8a459e0d43012c3868ffefa1,
            total      : 0,
        };
        0x2::transfer::public_share_object<CoinConfig>(v0);
    }

    public fun inscriptions(arg0: &mut CoinConfig, arg1: &mut Inscriptions, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert_version(arg0.version);
        assert!(0x1::string::length(&arg2) + 0x1::vector::length<0x1::string::String>(&arg1.contents) * 12000 <= arg1.content_size, 2);
        0x1::vector::push_back<0x1::string::String>(&mut arg1.contents, arg2);
    }

    public entry fun migrate_version(arg0: &mut CoinConfig, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 0);
        arg0.version = 1;
    }

    public fun mint_inscriptions(arg0: &mut CoinConfig, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: 0x1::string::String, arg8: &mut 0x2::tx_context::TxContext) : Inscriptions {
        let v0 = 0x2::tx_context::sender(arg8);
        assert_version(arg0.version);
        assert!(0x2::dynamic_object_field::exists_<0x1::string::String>(&arg0.id, arg1), 6);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0x1::string::String, CoinStore>(&mut arg0.id, arg1);
        assert!(v1.total_minted + arg2 <= v1.max, 7);
        if (!0x2::table::contains<address, UserAmount>(&v1.user_minted, v0)) {
            let v2 = UserAmount{
                tick   : arg1,
                amount : 0,
            };
            0x2::table::add<address, UserAmount>(&mut v1.user_minted, v0, v2);
        };
        let v3 = 0x2::table::borrow_mut<address, UserAmount>(&mut v1.user_minted, v0);
        assert!(v3.amount + arg2 <= v1.lim, 8);
        v3.amount = v3.amount + arg2;
        v1.total_minted = v1.total_minted + arg2;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg6) >= 500000000, 4);
        let v4 = arg0.current_id + 1;
        arg0.current_id = v4;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg6, @0x42767ede98e1d19262103774e0e9fbad54340be037b4b925ed422ef75f0d293a);
        mint_nft(arg1, 0x1::string::utf8(b"src-20"), v4, arg3, arg4, arg5, arg7, 0x1::string::utf8(b"mint"), arg1, 0x1::option::some<u64>(arg2), 0x1::option::none<u64>(), 0x1::option::none<u64>(), arg8)
    }

    fun mint_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u256, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: 0x1::option::Option<u64>, arg10: 0x1::option::Option<u64>, arg11: 0x1::option::Option<u64>, arg12: &mut 0x2::tx_context::TxContext) : Inscriptions {
        let v0 = Inscriptions{
            id             : 0x2::object::new(arg12),
            current_id     : arg2,
            name           : arg0,
            description    : arg1,
            image_url      : arg3,
            external_link  : arg4,
            p              : 0x1::string::utf8(b"src-20"),
            op             : arg7,
            tick           : arg8,
            amt            : arg9,
            max            : arg10,
            lim            : arg11,
            contents       : 0x1::vector::empty<0x1::string::String>(),
            content_size   : arg5,
            extention_type : arg6,
        };
        let v1 = InstructionsCoin{
            id            : 0x2::object::uid_to_inner(&v0.id),
            name          : arg0,
            description   : arg1,
            image_url     : arg3,
            external_link : arg4,
            current_id    : arg2,
            p             : 0x1::string::utf8(b"src-20"),
            op            : arg7,
            tick          : arg0,
            amt           : arg9,
            max           : arg10,
            lim           : arg11,
        };
        0x2::event::emit<InstructionsCoin>(v1);
        v0
    }

    public entry fun set_new_admin(arg0: &mut CoinConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.admin, 0);
        arg0.admin = arg1;
    }

    // decompiled from Move bytecode v6
}

