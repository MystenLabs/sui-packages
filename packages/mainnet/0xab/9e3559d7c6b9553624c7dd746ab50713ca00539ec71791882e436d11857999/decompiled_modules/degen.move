module 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::degen {
    struct Degen<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        token_id: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        url: 0x1::string::String,
        img_url: 0x1::string::String,
        code: u64,
        description: 0x1::string::String,
    }

    struct AppCap has drop, store {
        cohort: u32,
        time_limit: u64,
        generations: u64,
        minting_counter: u64,
        base_url: 0x1::string::String,
        display_name_prefix: 0x1::string::String,
        display_link: 0x1::string::String,
        display_project_url: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AppKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct DEGEN has drop {
        dummy_field: bool,
    }

    struct DegenMinted has copy, drop {
        id: 0x2::object::ID,
        token_id: u64,
        code: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        created_by: address,
    }

    public fun authorize_app<T0>(arg0: &mut 0x2::object::UID, arg1: u32, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &AdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        let v1 = AppCap{
            cohort              : arg1,
            time_limit          : arg2,
            generations         : arg3,
            minting_counter     : 0,
            base_url            : arg4,
            display_name_prefix : 0x1::string::utf8(b""),
            display_link        : 0x1::string::utf8(b""),
            display_project_url : 0x1::string::utf8(b"https://degensdragonsgame.com"),
        };
        0x2::dynamic_field::add<AppKey<T0>, AppCap>(arg0, v0, v1);
    }

    public fun burn<T0>(arg0: &mut 0x2::object::UID, arg1: Degen<T0>) : 0x2::object::UID {
        assert!(is_authorized<T0>(arg0), 0);
        let Degen {
            id          : v0,
            name        : _,
            token_id    : _,
            attributes  : _,
            url         : _,
            img_url     : _,
            code        : _,
            description : _,
        } = arg1;
        v0
    }

    fun get_app_cap<T0>(arg0: &mut 0x2::object::UID) : &mut AppCap {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<AppKey<T0>, AppCap>(arg0, v0)
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name} #{token_id}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://mint.degensdragonsgame.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}/{code}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Pre-sale invitational NFT granting access to the Degens and Dragons Tournament. \"{description}\""));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Comet Labs"));
        let v4 = 0x2::package::claim<DEGEN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Degen<0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::collectible::Collectible>>(&v4, v0, v2, arg1);
        0x2::display::update_version<Degen<0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::collectible::Collectible>>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Degen<0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::collectible::Collectible>>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_authorized<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(arg0, v0)
    }

    public fun mint<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Degen<T0> {
        assert!(is_authorized<T0>(arg0), 0);
        let v0 = get_app_cap<T0>(arg0);
        v0.minting_counter = v0.minting_counter + 1;
        let v1 = 0x2::object::new(arg4);
        let v2 = 0xab9e3559d7c6b9553624c7dd746ab50713ca00539ec71791882e436d11857999::random::get_random_number(v0.generations, arg4);
        let v3 = DegenMinted{
            id         : 0x2::object::uid_to_inner(&v1),
            token_id   : v0.minting_counter,
            code       : v2,
            attributes : arg2,
            created_by : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<DegenMinted>(v3);
        Degen<T0>{
            id          : v1,
            name        : 0x1::string::utf8(b"Degens & Dragons Tournament Invitation"),
            token_id    : v0.minting_counter,
            attributes  : arg2,
            url         : v0.display_project_url,
            img_url     : v0.base_url,
            code        : v2,
            description : arg1,
        }
    }

    public fun revoke_auth<T0>(arg0: &mut 0x2::object::UID, arg1: &AdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        let AppCap {
            cohort              : _,
            time_limit          : _,
            generations         : _,
            minting_counter     : _,
            base_url            : _,
            display_name_prefix : _,
            display_link        : _,
            display_project_url : _,
        } = 0x2::dynamic_field::remove<AppKey<T0>, AppCap>(arg0, v0);
    }

    public fun set_base_url<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: &AdminCap) {
        get_app_cap<T0>(arg0).base_url = arg1;
    }

    public fun set_display_attributes<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &AdminCap) {
        let v0 = get_app_cap<T0>(arg0);
        v0.base_url = arg1;
        v0.display_name_prefix = arg2;
        v0.display_link = arg3;
        v0.display_project_url = arg4;
    }

    public fun uid<T0>(arg0: &Degen<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut Degen<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

