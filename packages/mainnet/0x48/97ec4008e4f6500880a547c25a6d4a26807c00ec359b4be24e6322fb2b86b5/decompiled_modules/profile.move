module 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::profile {
    struct Promise {
        master_id: 0x2::object::ID,
        profile: address,
    }

    struct Profile has key {
        id: 0x2::object::UID,
        user_id: 0x1::string::String,
        username: 0x1::string::String,
        authorizations: 0x2::table::Table<address, u8>,
        watch_time: u64,
        videos_watched: u64,
        adverts_watched: u64,
        number_of_followers: u64,
        number_of_following: u64,
        ad_revenue: u64,
        commission_revenue: u64,
    }

    public fun delete(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: Profile) : (0x1::string::String, 0x1::string::String, u64, u64, u64, u64, u64, u64, u64) {
        let Profile {
            id                  : v0,
            user_id             : v1,
            username            : v2,
            authorizations      : v3,
            watch_time          : v4,
            videos_watched      : v5,
            adverts_watched     : v6,
            number_of_followers : v7,
            number_of_following : v8,
            ad_revenue          : v9,
            commission_revenue  : v10,
        } = arg1;
        let v11 = v3;
        assert!(0x2::table::is_empty<address, u8>(&v11), 9);
        0x2::table::destroy_empty<address, u8>(v11);
        0x2::object::delete(v0);
        (v1, v2, v4, v5, v6, v7, v8, v9, v10)
    }

    public fun access_rights(arg0: &Profile, arg1: address) : &u8 {
        assert!(0x2::table::contains<address, u8>(&arg0.authorizations, arg1), 4);
        0x2::table::borrow<address, u8>(&arg0.authorizations, arg1)
    }

    public fun ad_revenue(arg0: &Profile) : &u64 {
        &arg0.ad_revenue
    }

    public fun admin_receive_master<T0: drop>(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: 0x2::transfer::Receiving<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>) : 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0> {
        receive_master_<T0>(arg1, arg2)
    }

    public fun adverts_watched(arg0: &Profile) : &u64 {
        &arg0.adverts_watched
    }

    public fun authorize(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: address, arg3: u8) {
        0x2::table::add<address, u8>(&mut arg1.authorizations, arg2, arg3);
    }

    public fun borrow_master<T0: drop>(arg0: &mut Profile, arg1: 0x2::transfer::Receiving<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>, arg2: &mut 0x2::tx_context::TxContext) : (0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>, Promise) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 110, 2);
        let v0 = receive_master_<T0>(arg0, arg1);
        assert!(0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::sale_status<T0>(&v0) != 4 && 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::sale_status<T0>(&v0) != 3, 8);
        let v1 = Promise{
            master_id : 0x2::object::id<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(&v0),
            profile   : 0x2::object::id_address<Profile>(arg0),
        };
        (v0, v1)
    }

    public fun buy<T0: drop>(arg0: &mut Profile, arg1: 0x2::transfer::Receiving<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>, arg2: &mut Profile, arg3: 0x2::transfer::Receiving<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::receipt::Receipt>) {
        let (v0, v1) = 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::receipt::burn(0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::receipt::receive(&mut arg2.id, arg3));
        let v2 = receive_master_<T0>(arg0, arg1);
        assert!(0x2::object::id<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(&v2) == v0, 3);
        assert!(0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::sale_status<T0>(&v2) == 4, 6);
        0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::update_sale_status<T0>(&mut v2, 1);
        0x2::transfer::public_transfer<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(v2, v1);
    }

    public fun commission_revenue(arg0: &Profile) : &u64 {
        &arg0.commission_revenue
    }

    public fun deauthorize(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: address) {
        0x2::table::remove<address, u8>(&mut arg1.authorizations, arg2);
    }

    public fun new(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        abort 9223372483532029963
    }

    public fun number_of_followers(arg0: &Profile) : &u64 {
        &arg0.number_of_followers
    }

    public fun number_of_following(arg0: &Profile) : &u64 {
        &arg0.number_of_following
    }

    fun receive_master_<T0: drop>(arg0: &mut Profile, arg1: 0x2::transfer::Receiving<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>) : 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0> {
        0x2::transfer::public_receive<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(&mut arg0.id, arg1)
    }

    public fun return_master<T0: drop>(arg0: 0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>, arg1: Promise) {
        let Promise {
            master_id : v0,
            profile   : v1,
        } = arg1;
        assert!(0x2::object::id<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(&arg0) == v0, 3);
        0x2::transfer::public_transfer<0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::master::Master<T0>>(arg0, v1);
    }

    public fun update_ad_revenue(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: u64) {
        assert!(arg2 > arg1.ad_revenue, 0);
        arg1.ad_revenue = arg2;
    }

    public fun update_adverts_watched(arg0: &mut Profile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 120, 7);
        assert!(arg1 > arg0.adverts_watched, 0);
        arg0.adverts_watched = arg1;
    }

    public fun update_authorization(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: address, arg3: u8) {
        update_authorization_(arg1, arg2, arg3);
    }

    fun update_authorization_(arg0: &mut Profile, arg1: address, arg2: u8) {
        assert!(0x2::table::contains<address, u8>(&arg0.authorizations, arg1), 4);
        *0x2::table::borrow_mut<address, u8>(&mut arg0.authorizations, arg1) = arg2;
    }

    public fun update_commission_revenue(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: u64) {
        assert!(arg2 > arg1.commission_revenue, 0);
        arg1.commission_revenue = arg2;
    }

    public fun update_number_of_followers(arg0: &mut Profile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 120, 7);
        arg0.number_of_followers = arg1;
    }

    public fun update_number_of_following(arg0: &mut Profile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 120, 7);
        arg0.number_of_following = arg1;
    }

    public fun update_user_id(arg0: &0x218ed9e5b2f6dff13a2f668d2b405cf3fbdf10e6ecf3749a5acffe07fb380cf6::core::AdminCap, arg1: &mut Profile, arg2: 0x1::string::String) {
        arg1.user_id = arg2;
    }

    public fun update_username(arg0: &mut Profile, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 120, 7);
        arg0.username = arg1;
    }

    public fun update_videos_watched(arg0: &mut Profile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 120, 7);
        assert!(arg1 > arg0.videos_watched, 0);
        arg0.videos_watched = arg1;
    }

    public fun update_watch_time(arg0: &mut Profile, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(*access_rights(arg0, 0x2::tx_context::sender(arg2)) >= 120, 7);
        assert!(arg1 > arg0.watch_time, 0);
        arg0.watch_time = arg1;
    }

    public fun user_id(arg0: &Profile) : &0x1::string::String {
        &arg0.user_id
    }

    public fun username(arg0: &Profile) : &0x1::string::String {
        &arg0.username
    }

    public fun videos_watched(arg0: &Profile) : &u64 {
        &arg0.videos_watched
    }

    public fun watch_time(arg0: &Profile) : &u64 {
        &arg0.watch_time
    }

    // decompiled from Move bytecode v6
}

