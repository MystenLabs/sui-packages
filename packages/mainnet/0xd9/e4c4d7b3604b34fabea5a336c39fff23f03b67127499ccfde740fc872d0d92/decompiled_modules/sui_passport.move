module 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::sui_passport {
    struct SUI_PASSPORT has drop {
        dummy_field: bool,
    }

    struct SuiPassport has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        avatar: 0x1::string::String,
        introduction: 0x1::string::String,
        exhibit: vector<0x2::object::ID>,
        collections: 0x2::table::Table<0x2::object::ID, bool>,
        points: u64,
        x: 0x1::string::String,
        github: 0x1::string::String,
        email: 0x1::string::String,
        last_time: u64,
    }

    struct SuiPassportRecord has key {
        id: 0x2::object::UID,
        record: 0x2::table::Table<address, u64>,
    }

    struct MintPassportEvent has copy, drop {
        sender: address,
        passport: 0x2::object::ID,
    }

    struct DropPassportEvent has copy, drop {
        sender: address,
        passport: 0x2::object::ID,
    }

    struct EditPassportEvent has copy, drop {
        sender: address,
        passport: 0x2::object::ID,
    }

    public fun points(arg0: &SuiPassport) : u64 {
        arg0.points
    }

    public fun drop_passport(arg0: &mut SuiPassportRecord, arg1: SuiPassport, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::table::remove<address, u64>(&mut arg0.record, v0);
        let v1 = DropPassportEvent{
            sender   : v0,
            passport : 0x2::object::id<SuiPassport>(&arg1),
        };
        0x2::event::emit<DropPassportEvent>(v1);
        let SuiPassport {
            id           : v2,
            name         : _,
            avatar       : _,
            introduction : _,
            exhibit      : _,
            collections  : v7,
            points       : _,
            x            : _,
            github       : _,
            email        : _,
            last_time    : _,
        } = arg1;
        0x2::object::delete(v2);
        0x2::table::drop<0x2::object::ID, bool>(v7);
    }

    public fun edit_passport(arg0: &mut SuiPassport, arg1: 0x1::option::Option<0x1::string::String>, arg2: 0x1::option::Option<0x1::string::String>, arg3: 0x1::option::Option<0x1::string::String>, arg4: 0x1::option::Option<0x1::string::String>, arg5: 0x1::option::Option<0x1::string::String>, arg6: 0x1::option::Option<0x1::string::String>, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) {
        if (0x1::option::is_some<0x1::string::String>(&arg1)) {
            arg0.name = 0x1::option::extract<0x1::string::String>(&mut arg1);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg2)) {
            arg0.avatar = 0x1::option::extract<0x1::string::String>(&mut arg2);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg3)) {
            arg0.introduction = 0x1::option::extract<0x1::string::String>(&mut arg3);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg4)) {
            arg0.x = 0x1::option::extract<0x1::string::String>(&mut arg4);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg5)) {
            arg0.github = 0x1::option::extract<0x1::string::String>(&mut arg5);
        };
        if (0x1::option::is_some<0x1::string::String>(&arg6)) {
            arg0.email = 0x1::option::extract<0x1::string::String>(&mut arg6);
        };
        arg0.last_time = 0x2::clock::timestamp_ms(arg7);
        let v0 = EditPassportEvent{
            sender   : 0x2::tx_context::sender(arg8),
            passport : 0x2::object::id<SuiPassport>(arg0),
        };
        0x2::event::emit<EditPassportEvent>(v0);
    }

    public fun hide_stamp(arg0: &mut SuiPassport, arg1: &0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp>(arg1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.collections, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.collections, v0) = false;
        } else {
            arg0.points = arg0.points + 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::points(arg1);
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.collections, v0, false);
        };
        arg0.last_time = 0x2::clock::timestamp_ms(arg2);
    }

    fun init(arg0: SUI_PASSPORT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = SuiPassportRecord{
            id     : 0x2::object::new(arg1),
            record : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<SuiPassportRecord>(v1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        let v4 = b"https://suipassport.com/objectId/";
        0x1::vector::append<u8>(&mut v4, b"{id}");
        let v5 = 0x1::vector::empty<0x1::string::String>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(v4));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"https://suipassport.com/"));
        0x1::vector::push_back<0x1::string::String>(v6, 0x1::string::utf8(b"Get your Sui Passport, start exploring the Sui Universe."));
        let v7 = 0x2::package::claim<SUI_PASSPORT>(arg0, arg1);
        let v8 = 0x2::display::new_with_fields<SuiPassport>(&v7, v2, v5, arg1);
        0x2::display::update_version<SuiPassport>(&mut v8);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v7, v0);
        0x2::transfer::public_transfer<0x2::display::Display<SuiPassport>>(v8, v0);
    }

    public fun last_time(arg0: &SuiPassport) : u64 {
        arg0.last_time
    }

    public fun mint_passport(arg0: &mut SuiPassportRecord, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        0x2::table::add<address, u64>(&mut arg0.record, v0, 0);
        let v1 = SuiPassport{
            id           : 0x2::object::new(arg8),
            name         : arg1,
            avatar       : arg2,
            introduction : arg3,
            exhibit      : 0x1::vector::empty<0x2::object::ID>(),
            collections  : 0x2::table::new<0x2::object::ID, bool>(arg8),
            points       : 0,
            x            : arg4,
            github       : arg5,
            email        : arg6,
            last_time    : 0x2::clock::timestamp_ms(arg7),
        };
        let v2 = MintPassportEvent{
            sender   : v0,
            passport : 0x2::object::id<SuiPassport>(&v1),
        };
        0x2::event::emit<MintPassportEvent>(v2);
        0x2::transfer::transfer<SuiPassport>(v1, v0);
    }

    public fun set_exhibit(arg0: &mut SuiPassport, arg1: vector<0x2::object::ID>, arg2: &0x2::clock::Clock) {
        let v0 = 0;
        let v1 = 0x1::vector::length<0x2::object::ID>(&arg1);
        assert!(v1 <= 3, 1000);
        while (v0 < v1) {
            assert!(0x2::table::contains<0x2::object::ID, bool>(&arg0.collections, *0x1::vector::borrow<0x2::object::ID>(&arg1, v0)), 1001);
            v0 = v0 + 1;
        };
        arg0.exhibit = arg1;
        arg0.last_time = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun set_last_time(arg0: &mut SuiPassport, arg1: &0x2::clock::Clock) {
        arg0.last_time = 0x2::clock::timestamp_ms(arg1);
    }

    public fun show_stamp(arg0: &mut SuiPassport, arg1: &0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::Stamp>(arg1);
        if (0x2::table::contains<0x2::object::ID, bool>(&arg0.collections, v0)) {
            *0x2::table::borrow_mut<0x2::object::ID, bool>(&mut arg0.collections, v0) = true;
        } else {
            arg0.points = arg0.points + 0xd9e4c4d7b3604b34fabea5a336c39fff23f03b67127499ccfde740fc872d0d92::stamp::points(arg1);
            0x2::table::add<0x2::object::ID, bool>(&mut arg0.collections, v0, true);
        };
        arg0.last_time = 0x2::clock::timestamp_ms(arg2);
    }

    public fun update_points(arg0: &mut SuiPassportRecord, arg1: &SuiPassport, arg2: &0x2::tx_context::TxContext) {
        *0x2::table::borrow_mut<address, u64>(&mut arg0.record, 0x2::tx_context::sender(arg2)) = points(arg1);
    }

    // decompiled from Move bytecode v6
}

