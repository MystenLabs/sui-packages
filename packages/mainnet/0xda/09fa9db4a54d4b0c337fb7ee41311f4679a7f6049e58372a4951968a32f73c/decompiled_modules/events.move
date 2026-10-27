module 0xda09fa9db4a54d4b0c337fb7ee41311f4679a7f6049e58372a4951968a32f73c::events {
    struct ClassCreated has copy, drop {
        class: 0x2::object::ID,
        cap: 0x2::object::ID,
        policy: 0x2::object::ID,
        marker: 0x1::ascii::String,
        item_type: 0x1::ascii::String,
        game: 0x1::string::String,
        name: 0x1::string::String,
        royalty_bps: u16,
        royalty_min_mist: u64,
        lock: bool,
        issuer: vector<u8>,
        creator: address,
    }

    struct KindAdded has copy, drop {
        class: 0x2::object::ID,
        kind: u64,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        max_supply: u64,
    }

    struct IssuerSet has copy, drop {
        class: 0x2::object::ID,
        public_key: vector<u8>,
    }

    struct ClassPaused has copy, drop {
        class: 0x2::object::ID,
        paused: bool,
    }

    struct RoyaltiesWithdrawn has copy, drop {
        class: 0x2::object::ID,
        amount: u64,
        by: address,
    }

    struct ItemMinted has copy, drop {
        item: 0x2::object::ID,
        class: 0x2::object::ID,
        kind: u64,
        serial: u64,
        source: u8,
        owner: 0x1::option::Option<address>,
        kiosk: 0x1::option::Option<0x2::object::ID>,
        nonce: 0x1::option::Option<u64>,
        keys: vector<0x1::string::String>,
        vals: vector<0x1::string::String>,
    }

    struct ItemUpdated has copy, drop {
        item: 0x2::object::ID,
        class: 0x2::object::ID,
        rev: u64,
        keys: vector<0x1::string::String>,
        vals: vector<0x1::string::String>,
    }

    struct ItemBurned has copy, drop {
        item: 0x2::object::ID,
        class: 0x2::object::ID,
        kind: u64,
        serial: u64,
        by: address,
    }

    struct ConfigPaused has copy, drop {
        config: 0x2::object::ID,
        paused: bool,
    }

    public(friend) fun class_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: u16, arg8: u64, arg9: bool, arg10: vector<u8>, arg11: address) {
        let v0 = ClassCreated{
            class            : arg0,
            cap              : arg1,
            policy           : arg2,
            marker           : arg3,
            item_type        : arg4,
            game             : arg5,
            name             : arg6,
            royalty_bps      : arg7,
            royalty_min_mist : arg8,
            lock             : arg9,
            issuer           : arg10,
            creator          : arg11,
        };
        0x2::event::emit<ClassCreated>(v0);
    }

    public(friend) fun class_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ClassPaused{
            class  : arg0,
            paused : arg1,
        };
        0x2::event::emit<ClassPaused>(v0);
    }

    public(friend) fun config_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = ConfigPaused{
            config : arg0,
            paused : arg1,
        };
        0x2::event::emit<ConfigPaused>(v0);
    }

    public(friend) fun issuer_set(arg0: 0x2::object::ID, arg1: vector<u8>) {
        let v0 = IssuerSet{
            class      : arg0,
            public_key : arg1,
        };
        0x2::event::emit<IssuerSet>(v0);
    }

    public(friend) fun item_burned(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: address) {
        let v0 = ItemBurned{
            item   : arg0,
            class  : arg1,
            kind   : arg2,
            serial : arg3,
            by     : arg4,
        };
        0x2::event::emit<ItemBurned>(v0);
    }

    public(friend) fun item_minted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u8, arg5: 0x1::option::Option<address>, arg6: 0x1::option::Option<0x2::object::ID>, arg7: 0x1::option::Option<u64>, arg8: vector<0x1::string::String>, arg9: vector<0x1::string::String>) {
        let v0 = ItemMinted{
            item   : arg0,
            class  : arg1,
            kind   : arg2,
            serial : arg3,
            source : arg4,
            owner  : arg5,
            kiosk  : arg6,
            nonce  : arg7,
            keys   : arg8,
            vals   : arg9,
        };
        0x2::event::emit<ItemMinted>(v0);
    }

    public(friend) fun item_updated(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>) {
        let v0 = ItemUpdated{
            item  : arg0,
            class : arg1,
            rev   : arg2,
            keys  : arg3,
            vals  : arg4,
        };
        0x2::event::emit<ItemUpdated>(v0);
    }

    public(friend) fun kind_added(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64) {
        let v0 = KindAdded{
            class       : arg0,
            kind        : arg1,
            name        : arg2,
            description : arg3,
            image_url   : arg4,
            max_supply  : arg5,
        };
        0x2::event::emit<KindAdded>(v0);
    }

    public(friend) fun royalties_withdrawn(arg0: 0x2::object::ID, arg1: u64, arg2: address) {
        let v0 = RoyaltiesWithdrawn{
            class  : arg0,
            amount : arg1,
            by     : arg2,
        };
        0x2::event::emit<RoyaltiesWithdrawn>(v0);
    }

    // decompiled from Move bytecode v7
}

