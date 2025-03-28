module 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::releap_social {
    struct Witness has drop {
        dummy_field: bool,
    }

    struct RELEAP_SOCIAL has drop {
        dummy_field: bool,
    }

    struct Index has key {
        id: 0x2::object::UID,
        profiles: 0x2::table::Table<0x1::string::String, 0x2::object::ID>,
        profile_cap: u64,
        profile_price: u64,
        beneficiary: address,
    }

    struct RecentPosts has key {
        id: 0x2::object::UID,
        counter: u64,
        posts: vector<0x2::object::ID>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun like_post(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::like_post(arg0, arg1, arg2, arg3);
    }

    public entry fun unlike_post(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::unlike_post(arg0, arg1, arg2, arg3);
    }

    public entry fun create_comment(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg3: &mut RecentPosts, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg3.counter = arg3.counter + 1;
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::create_comment(arg0, arg1, arg2, arg4, arg5, arg3.counter, arg6);
    }

    public entry fun create_post(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg2: &mut RecentPosts, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg2.counter = arg2.counter + 1;
        let v0 = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::create_post(arg0, arg1, arg3, arg4, arg5, arg2.counter, arg6);
        update_recent_post(arg2, v0);
    }

    public entry fun update_profile_description(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::update_profile_description(arg0, arg1, arg2, arg3);
    }

    public entry fun update_profile_image(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::update_profile_image(arg0, arg1, arg2, arg3);
    }

    public entry fun admin_update_beneficiary(arg0: &mut Index, arg1: &mut 0x2::package::Publisher, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Index>(arg1), 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::error::not_publisher());
        arg0.beneficiary = arg2;
    }

    public entry fun admin_update_profile_cap(arg0: &mut Index, arg1: &mut 0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Index>(arg1), 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::error::not_publisher());
        arg0.profile_cap = arg2;
    }

    public entry fun admin_update_profile_price(arg0: &mut Index, arg1: &mut 0x2::package::Publisher, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<Index>(arg1), 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::error::not_publisher());
        arg0.profile_price = arg2;
    }

    public entry fun aquires_admin_cap(arg0: &mut 0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(arg0), 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::error::not_publisher());
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun create_comment_with_admin_cap(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &mut AdminCap, arg3: &mut RecentPosts, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg3.counter = arg3.counter + 1;
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::create_comment_(arg0, arg1, arg4, arg5, arg3.counter, arg6);
    }

    public entry fun create_post_with_admin_cap(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut AdminCap, arg2: &mut RecentPosts, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg2.counter = arg2.counter + 1;
        let v0 = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::create_post_(arg0, arg3, arg4, arg5, arg2.counter, arg6);
        update_recent_post(arg2, v0);
    }

    public entry fun follow(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::profile_follow(arg0, arg1, arg2);
    }

    public entry fun follow_with_admin_cap(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &mut AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::profile_follow_(arg0, arg1);
    }

    public fun get_recent_post_ids(arg0: &RecentPosts) : &vector<0x2::object::ID> {
        &arg0.posts
    }

    fun init(arg0: RELEAP_SOCIAL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Index{
            id            : 0x2::object::new(arg1),
            profiles      : 0x2::table::new<0x1::string::String, 0x2::object::ID>(arg1),
            profile_cap   : 333,
            profile_price : 1000000000,
            beneficiary   : 0x2::tx_context::sender(arg1),
        };
        let v1 = RecentPosts{
            id      : 0x2::object::new(arg1),
            counter : 0,
            posts   : 0x1::vector::empty<0x2::object::ID>(),
        };
        0x2::transfer::share_object<Index>(v0);
        0x2::transfer::share_object<RecentPosts>(v1);
        let v2 = 0x2::package::claim<RELEAP_SOCIAL>(arg0, arg1);
        let (v3, v4) = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::create_display();
        let v5 = 0x2::display::new_with_fields<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(&v2, v3, v4, arg1);
        let (v6, v7) = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::create_cap_display();
        let v8 = 0x2::display::new_with_fields<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap>(&v2, v6, v7, arg1);
        let (v9, v10) = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::create_display();
        let v11 = 0x2::display::new_with_fields<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post>(&v2, v9, v10, arg1);
        let (v12, v13) = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::create_cap_display();
        let v14 = 0x2::display::new_with_fields<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::PostOwnerCap>(&v2, v12, v13, arg1);
        0x2::display::update_version<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(&mut v5);
        0x2::display::update_version<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap>(&mut v8);
        0x2::display::update_version<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post>(&mut v11);
        0x2::display::update_version<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::PostOwnerCap>(&mut v14);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap>>(v8, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post>>(v11, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::PostOwnerCap>>(v14, 0x2::tx_context::sender(arg1));
    }

    public entry fun like_post_with_admin_cap(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &mut AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::like_post(arg0, 0x2::object::id<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(arg1));
    }

    public entry fun new_profile(arg0: &mut Index, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::length<0x1::string::String, 0x2::object::ID>(&arg0.profiles) < arg0.profile_cap, 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::error::profile_cap_limit_reached());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg3), 0x2::coin::value<0x2::sui::SUI>(arg3)), arg4), arg0.beneficiary);
        let (v0, v1, v2) = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::new(arg1, arg2, arg4);
        let v3 = v1;
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.profiles, v0, 0x2::object::id<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(&v3));
        0x2::transfer::public_transfer<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(v3);
    }

    public entry fun new_profile_with_admin_cap(arg0: &mut Index, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::new(arg1, arg2, arg4);
        let v3 = v1;
        0x2::table::add<0x1::string::String, 0x2::object::ID>(&mut arg0.profiles, v0, 0x2::object::id<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(&v3));
        0x2::transfer::public_transfer<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap>(v2, 0x2::tx_context::sender(arg4));
        0x2::transfer::public_share_object<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(v3);
    }

    public entry fun set_profile_df_with_admin_cap<T0: drop + store>(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: 0x1::string::String, arg2: T0, arg3: &mut AdminCap, arg4: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::add_profile_df_<T0>(arg0, arg1, arg2);
    }

    public entry fun unfollow(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::profile_unfollow(arg0, arg1, arg2);
    }

    public entry fun unfollow_with_admin_cap(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &mut AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::profile_unfollow_(arg0, arg1);
    }

    public entry fun unlike_post_with_admin_cap(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::Post, arg1: &0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg2: &mut AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::post::unlike_post(arg0, 0x2::object::id<0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile>(arg1));
    }

    public entry fun update_beneficiary_with_admin_cap(arg0: &mut Index, arg1: &mut AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.beneficiary = arg2;
    }

    public entry fun update_profile_cap_with_admin_cap(arg0: &mut Index, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.profile_cap = arg2;
    }

    public entry fun update_profile_cover_image(arg0: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::Profile, arg1: &mut 0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::ProfileOwnerCap, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0xb5df90bfe40a5edc4fc3a89ef29753cf89d0fda50cc04019cbc7c036709db47a::profile::update_cover_image(arg0, arg1, arg2, arg3);
    }

    public entry fun update_profile_price_with_admin_cap(arg0: &mut Index, arg1: &mut AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.profile_price = arg2;
    }

    fun update_recent_post(arg0: &mut RecentPosts, arg1: 0x2::object::ID) {
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.posts, arg1);
        if (0x1::vector::length<0x2::object::ID>(&arg0.posts) > 30) {
            0x1::vector::remove<0x2::object::ID>(&mut arg0.posts, 0);
        };
    }

    // decompiled from Move bytecode v6
}

