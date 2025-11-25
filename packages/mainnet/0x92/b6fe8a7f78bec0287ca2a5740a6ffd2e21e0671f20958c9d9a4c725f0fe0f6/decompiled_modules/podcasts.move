module 0x92b6fe8a7f78bec0287ca2a5740a6ffd2e21e0671f20958c9d9a4c725f0fe0f6::podcasts {
    struct GlobalArchive has key {
        id: 0x2::object::UID,
        podcasts: 0x2::object_table::ObjectTable<0x2::object::ID, Podcast>,
        publishers: 0x2::vec_set::VecSet<address>,
    }

    struct Podcast has store, key {
        id: 0x2::object::UID,
        founder: 0x1::string::String,
        project: 0x1::string::String,
        date: 0x1::string::String,
        keywords: vector<0x1::string::String>,
        description: 0x1::string::String,
        founder_walrus_id: 0x1::string::String,
        pod_walrus_id: 0x1::string::String,
        transcript_walrus_id: 0x1::string::String,
        publisher: address,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun add_publisher(arg0: &AdminCap, arg1: &mut GlobalArchive, arg2: address) {
        0x2::vec_set::insert<address>(&mut arg1.publishers, arg2);
    }

    public fun create_podcast(arg0: &mut GlobalArchive, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<0x1::string::String>, arg5: 0x1::string::String, arg6: 0x1::string::String, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg9);
        assert!(0x2::vec_set::contains<address>(&arg0.publishers, &v0), 0);
        let v1 = Podcast{
            id                   : 0x2::object::new(arg9),
            founder              : arg1,
            project              : arg2,
            date                 : arg3,
            keywords             : arg4,
            description          : arg5,
            founder_walrus_id    : arg6,
            pod_walrus_id        : arg7,
            transcript_walrus_id : arg8,
            publisher            : 0x2::tx_context::sender(arg9),
        };
        0x2::object_table::add<0x2::object::ID, Podcast>(&mut arg0.podcasts, 0x2::object::uid_to_inner(&v1.id), v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = GlobalArchive{
            id         : 0x2::object::new(arg0),
            podcasts   : 0x2::object_table::new<0x2::object::ID, Podcast>(arg0),
            publishers : 0x2::vec_set::empty<address>(),
        };
        0x2::vec_set::insert<address>(&mut v1.publishers, 0x2::tx_context::sender(arg0));
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<GlobalArchive>(v1);
    }

    public fun remove_podcast(arg0: &mut GlobalArchive, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object_table::borrow<0x2::object::ID, Podcast>(&arg0.podcasts, arg1).publisher == 0x2::tx_context::sender(arg2), 1);
        let Podcast {
            id                   : v0,
            founder              : _,
            project              : _,
            date                 : _,
            keywords             : _,
            description          : _,
            founder_walrus_id    : _,
            pod_walrus_id        : _,
            transcript_walrus_id : _,
            publisher            : _,
        } = 0x2::object_table::remove<0x2::object::ID, Podcast>(&mut arg0.podcasts, arg1);
        0x2::object::delete(v0);
    }

    public fun remove_publisher(arg0: &AdminCap, arg1: &mut GlobalArchive, arg2: address) {
        0x2::vec_set::remove<address>(&mut arg1.publishers, &arg2);
    }

    // decompiled from Move bytecode v6
}

