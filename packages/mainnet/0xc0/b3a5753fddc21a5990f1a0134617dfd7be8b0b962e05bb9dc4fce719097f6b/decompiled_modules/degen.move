module 0xc0b3a5753fddc21a5990f1a0134617dfd7be8b0b962e05bb9dc4fce719097f6b::degen {
    struct Degen<phantom T0> has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        token_id: u64,
        url: 0x1::string::String,
        base_image_url: 0x1::string::String,
        total_attack: u64,
        owner: address,
        item_types: vector<0x1::string::String>,
        head: 0x1::string::String,
        body: 0x1::string::String,
        weapon: 0x1::string::String,
        admin_id: 0x2::object::ID,
    }

    struct AdminDegen has store, key {
        id: 0x2::object::UID,
        degen_id: 0x2::object::ID,
        is_dead: bool,
        total_score: u64,
    }

    struct AppCap has drop, store {
        admin: address,
        base_image_url: 0x1::string::String,
        minting_counter: u64,
        nonces: 0x2::vec_set::VecSet<0x1::string::String>,
        version: u64,
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

    public fun add_item_type<T0>(arg0: &mut Degen<T0>, arg1: 0x1::string::String, arg2: u64) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.item_types, arg1);
        arg0.total_attack = arg0.total_attack + arg2;
    }

    public fun authorize_app<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: &AdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AppKey<T0>{dummy_field: false};
        let v1 = AppCap{
            admin           : 0x2::tx_context::sender(arg3),
            base_image_url  : arg1,
            minting_counter : 0,
            nonces          : 0x2::vec_set::empty<0x1::string::String>(),
            version         : 1,
        };
        0x2::dynamic_field::add<AppKey<T0>, AppCap>(arg0, v0, v1);
    }

    public fun burn<T0>(arg0: &mut 0x2::object::UID, arg1: Degen<T0>) : 0x2::object::UID {
        assert!(is_authorized<T0>(arg0), 0);
        let Degen {
            id             : v0,
            name           : _,
            description    : _,
            token_id       : _,
            url            : _,
            base_image_url : _,
            total_attack   : _,
            owner          : _,
            item_types     : _,
            head           : _,
            body           : _,
            weapon         : _,
            admin_id       : _,
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://degensdragonsgame.com"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://api.degensdragonsgame.com/degen-avatars/DEGEN_{head}_{body}_{weapon}.webp"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Degens & Dragons Degen"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Comet Labs"));
        let v4 = 0x2::package::claim<DEGEN>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Degen<0xc0b3a5753fddc21a5990f1a0134617dfd7be8b0b962e05bb9dc4fce719097f6b::collectible::Collectible>>(&v4, v0, v2, arg1);
        0x2::display::update_version<Degen<0xc0b3a5753fddc21a5990f1a0134617dfd7be8b0b962e05bb9dc4fce719097f6b::collectible::Collectible>>(&mut v5);
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Degen<0xc0b3a5753fddc21a5990f1a0134617dfd7be8b0b962e05bb9dc4fce719097f6b::collectible::Collectible>>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_authorized<T0>(arg0: &0x2::object::UID) : bool {
        let v0 = AppKey<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<AppKey<T0>>(arg0, v0)
    }

    public fun kill_degen(arg0: &AdminCap, arg1: &mut AdminDegen) {
        arg1.is_dead = true;
    }

    public fun kill_degens(arg0: &AdminCap, arg1: vector<AdminDegen>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AdminDegen>(&arg1)) {
            let v1 = 0x1::vector::pop_back<AdminDegen>(&mut arg1);
            let v2 = &mut v1;
            kill_degen(arg0, v2);
            0x2::transfer::transfer<AdminDegen>(v1, 0x2::tx_context::sender(arg2));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<AdminDegen>(arg1);
    }

    public fun leave_arena<T0>(arg0: &mut 0x2::object::UID, arg1: Degen<T0>) {
        assert!(is_authorized<T0>(arg0), 0);
        0x2::transfer::public_transfer<Degen<T0>>(arg1, arg1.owner);
    }

    public fun mint<T0>(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : Degen<T0> {
        assert!(is_authorized<T0>(arg0), 0);
        let v0 = get_app_cap<T0>(arg0);
        v0.minting_counter = v0.minting_counter + 1;
        let v1 = 0x2::object::new(arg5);
        let v2 = 0x2::object::new(arg5);
        let v3 = AdminDegen{
            id          : v2,
            degen_id    : 0x2::object::uid_to_inner(&v1),
            is_dead     : false,
            total_score : 0,
        };
        let v4 = Degen<T0>{
            id             : v1,
            name           : 0x1::string::utf8(b"Degen"),
            description    : arg1,
            token_id       : arg2,
            url            : 0x1::string::utf8(b""),
            base_image_url : 0x1::string::utf8(b""),
            total_attack   : 0,
            owner          : 0x2::tx_context::sender(arg5),
            item_types     : 0x1::vector::empty<0x1::string::String>(),
            head           : 0x1::string::utf8(b"BLANK"),
            body           : 0x1::string::utf8(b"BLANK"),
            weapon         : 0x1::string::utf8(b"BLANK"),
            admin_id       : 0x2::object::uid_to_inner(&v2),
        };
        0x2::transfer::public_transfer<AdminDegen>(v3, v0.admin);
        v4
    }

    public fun remove_item_type<T0>(arg0: &mut Degen<T0>, arg1: 0x1::string::String, arg2: u64) {
        let (v0, v1) = 0x1::vector::index_of<0x1::string::String>(&arg0.item_types, &arg1);
        if (v0 == true) {
            arg0.total_attack = arg0.total_attack - arg2;
            0x1::vector::remove<0x1::string::String>(&mut arg0.item_types, v1);
        };
    }

    public fun revoke_auth<T0>(arg0: &mut 0x2::object::UID, arg1: &AdminCap) {
        let v0 = AppKey<T0>{dummy_field: false};
        let AppCap {
            admin           : _,
            base_image_url  : _,
            minting_counter : _,
            nonces          : _,
            version         : _,
        } = 0x2::dynamic_field::remove<AppKey<T0>, AppCap>(arg0, v0);
    }

    public fun uid<T0>(arg0: &Degen<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public fun uid_mut<T0>(arg0: &mut Degen<T0>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun update_admin(arg0: &AdminCap, arg1: &mut AdminDegen, arg2: bool, arg3: u64) {
        arg1.is_dead = arg2;
        arg1.total_score = arg3;
    }

    public fun update_admin_is_dead(arg0: &AdminCap, arg1: &mut AdminDegen, arg2: bool) {
        arg1.is_dead = arg2;
    }

    public fun update_admin_score(arg0: &AdminCap, arg1: &mut AdminDegen, arg2: u64) {
        arg1.total_score = arg2;
    }

    public fun update_body<T0>(arg0: &mut Degen<T0>, arg1: 0x1::string::String) {
        arg0.body = arg1;
    }

    public fun update_head<T0>(arg0: &mut Degen<T0>, arg1: 0x1::string::String) {
        arg0.head = arg1;
    }

    public fun update_image_url<T0>(arg0: &mut Degen<T0>, arg1: 0x1::string::String) {
        arg0.base_image_url = arg1;
    }

    public fun update_weapon<T0>(arg0: &mut Degen<T0>, arg1: 0x1::string::String) {
        arg0.weapon = arg1;
    }

    // decompiled from Move bytecode v6
}

