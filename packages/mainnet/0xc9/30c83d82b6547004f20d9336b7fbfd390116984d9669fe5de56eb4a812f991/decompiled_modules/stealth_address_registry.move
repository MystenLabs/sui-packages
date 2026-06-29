module 0xb9fe4d78d216e98b6229e97f93972cb7c3493d8d9f123880f781ab920c66db50::stealth_address_registry {
    struct Announcement has copy, drop, store {
        ephemeral_pub_key: vector<u8>,
        view_tag: vector<u8>,
        stealth_hash: vector<u8>,
        announcer: address,
        timestamp_ms: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        next_id: u64,
        announcements: 0x2::table::Table<u64, Announcement>,
        by_view_tag: 0x2::table::Table<vector<u8>, u64>,
    }

    struct StealthAnnouncement has copy, drop {
        id: u64,
        view_tag: vector<u8>,
        announcer: address,
        stealth_hash: vector<u8>,
        ephemeral_pub_key: vector<u8>,
        timestamp_ms: u64,
    }

    public fun timestamp_ms(arg0: &Announcement) : u64 {
        arg0.timestamp_ms
    }

    public entry fun announce(arg0: &0x2::tx_context::TxContext, arg1: &mut Registry, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &0x2::clock::Clock) {
        announce_impl(arg1, arg2, arg3, arg4, arg5, arg0);
    }

    public entry fun announce_entry(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        announce_impl(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    fun announce_impl(arg0: &mut Registry, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(!0x1::vector::is_empty<u8>(&arg1), 1);
        assert!(!0x1::vector::is_empty<u8>(&arg2), 2);
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = 0x2::tx_context::sender(arg5);
        if (!0x2::table::contains<vector<u8>, u64>(&arg0.by_view_tag, arg2)) {
            0x2::table::add<vector<u8>, u64>(&mut arg0.by_view_tag, arg2, v0);
        };
        let v3 = Announcement{
            ephemeral_pub_key : arg1,
            view_tag          : arg2,
            stealth_hash      : arg3,
            announcer         : v2,
            timestamp_ms      : v1,
        };
        0x2::table::add<u64, Announcement>(&mut arg0.announcements, v0, v3);
        let v4 = StealthAnnouncement{
            id                : v0,
            view_tag          : arg2,
            announcer         : v2,
            stealth_hash      : arg3,
            ephemeral_pub_key : arg1,
            timestamp_ms      : v1,
        };
        0x2::event::emit<StealthAnnouncement>(v4);
    }

    public fun announcement_count(arg0: &Registry) : u64 {
        arg0.next_id
    }

    public fun announcer(arg0: &Announcement) : address {
        arg0.announcer
    }

    public fun ephemeral_pub_key(arg0: &Announcement) : &vector<u8> {
        &arg0.ephemeral_pub_key
    }

    public fun get_announcement(arg0: &Registry, arg1: u64) : &Announcement {
        assert!(0x2::table::contains<u64, Announcement>(&arg0.announcements, arg1), 3);
        0x2::table::borrow<u64, Announcement>(&arg0.announcements, arg1)
    }

    public fun id_for_view_tag(arg0: &Registry, arg1: vector<u8>) : 0x1::option::Option<u64> {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.by_view_tag, arg1)) {
            0x1::option::some<u64>(*0x2::table::borrow<vector<u8>, u64>(&arg0.by_view_tag, arg1))
        } else {
            0x1::option::none<u64>()
        }
    }

    public fun id_for_view_tag_or_abort(arg0: &Registry, arg1: vector<u8>) : u64 {
        assert!(0x2::table::contains<vector<u8>, u64>(&arg0.by_view_tag, arg1), 3);
        *0x2::table::borrow<vector<u8>, u64>(&arg0.by_view_tag, arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Registry{
            id            : 0x2::object::new(arg0),
            next_id       : 0,
            announcements : 0x2::table::new<u64, Announcement>(arg0),
            by_view_tag   : 0x2::table::new<vector<u8>, u64>(arg0),
        };
        0x2::transfer::share_object<Registry>(v0);
    }

    public fun stealth_hash(arg0: &Announcement) : &vector<u8> {
        &arg0.stealth_hash
    }

    public fun view_tag(arg0: &Announcement) : &vector<u8> {
        &arg0.view_tag
    }

    // decompiled from Move bytecode v7
}

