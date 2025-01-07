module 0x20c39cf9f65e9d27a42a662ce5e52d43bcd449ab8feb39aa052dcfd8c727b968::hero {
    struct HERO has drop {
        dummy_field: bool,
    }

    struct Hero has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        class: 0x1::string::String,
        faction: 0x1::string::String,
        rarity: 0x1::string::String,
        external_id: 0x1::string::String,
        pending_upgrade: u64,
    }

    struct HeroMinted has copy, drop {
        id: 0x2::object::ID,
        external_id: 0x1::string::String,
    }

    struct HeroBurned has copy, drop {
        id: 0x2::object::ID,
        external_id: 0x1::string::String,
    }

    public(friend) fun add_field<T0: drop + store>(arg0: &mut Hero, arg1: 0x1::string::String, arg2: T0) {
        0x2::dynamic_field::add<0x1::string::String, T0>(&mut arg0.id, arg1, arg2);
    }

    public(friend) fun add_pending_upgrade(arg0: &mut Hero, arg1: u64) {
        arg0.pending_upgrade = arg1;
    }

    public fun appearance_values(arg0: &Hero) : &vector<u16> {
        0x2::dynamic_field::borrow<0x1::string::String, vector<u16>>(&arg0.id, 0x1::string::utf8(b"appearance"))
    }

    public fun base_values(arg0: &Hero) : &vector<u16> {
        0x2::dynamic_field::borrow<0x1::string::String, vector<u16>>(&arg0.id, 0x1::string::utf8(b"base"))
    }

    public(friend) fun burn(arg0: Hero) {
        0x2::dynamic_field::remove<0x1::string::String, vector<u16>>(&mut arg0.id, 0x1::string::utf8(b"base"));
        0x2::dynamic_field::remove<0x1::string::String, vector<u16>>(&mut arg0.id, 0x1::string::utf8(b"skill"));
        0x2::dynamic_field::remove<0x1::string::String, vector<u16>>(&mut arg0.id, 0x1::string::utf8(b"appearance"));
        0x2::dynamic_field::remove<0x1::string::String, vector<u16>>(&mut arg0.id, 0x1::string::utf8(b"growth"));
        let Hero {
            id              : v0,
            name            : _,
            class           : _,
            faction         : _,
            rarity          : _,
            external_id     : v5,
            pending_upgrade : _,
        } = arg0;
        let v7 = v0;
        let v8 = HeroBurned{
            id          : 0x2::object::uid_to_inner(&v7),
            external_id : v5,
        };
        0x2::event::emit<HeroBurned>(v8);
        0x2::object::delete(v7);
    }

    public fun class(arg0: &Hero) : &0x1::string::String {
        &arg0.class
    }

    public(friend) fun edit_fields<T0: copy + drop + store>(arg0: &mut Hero, arg1: 0x1::string::String, arg2: vector<T0>) {
        *0x2::dynamic_field::borrow_mut<0x1::string::String, vector<T0>>(&mut arg0.id, arg1) = arg2;
    }

    public fun external_id(arg0: &Hero) : &0x1::string::String {
        &arg0.external_id
    }

    public fun faction(arg0: &Hero) : &0x1::string::String {
        &arg0.faction
    }

    public fun field<T0: drop + store>(arg0: &Hero, arg1: 0x1::string::String) : &T0 {
        0x2::dynamic_field::borrow<0x1::string::String, T0>(&arg0.id, arg1)
    }

    public fun growth_values(arg0: &Hero) : &vector<u16> {
        0x2::dynamic_field::borrow<0x1::string::String, vector<u16>>(&arg0.id, 0x1::string::utf8(b"growth"))
    }

    fun init(arg0: HERO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<HERO>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"project_url"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Hero"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://legendofarcadia.io/heroes/images/{external_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://legendofarcadia.io/heroes/{external_id}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Heroes of Arcadia"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"https://legendofarcadia.io"));
        let v5 = 0x2::display::new_with_fields<Hero>(&v0, v1, v3, arg1);
        0x2::display::update_version<Hero>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Hero>>(v5, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u16>, arg5: vector<u16>, arg6: vector<u16>, arg7: vector<u16>, arg8: 0x1::string::String, arg9: &mut 0x2::tx_context::TxContext) : Hero {
        let v0 = Hero{
            id              : 0x2::object::new(arg9),
            name            : arg0,
            class           : arg1,
            faction         : arg2,
            rarity          : arg3,
            external_id     : arg8,
            pending_upgrade : 0,
        };
        0x2::dynamic_field::add<0x1::string::String, vector<u16>>(&mut v0.id, 0x1::string::utf8(b"base"), arg4);
        0x2::dynamic_field::add<0x1::string::String, vector<u16>>(&mut v0.id, 0x1::string::utf8(b"skill"), arg5);
        0x2::dynamic_field::add<0x1::string::String, vector<u16>>(&mut v0.id, 0x1::string::utf8(b"appearance"), arg6);
        0x2::dynamic_field::add<0x1::string::String, vector<u16>>(&mut v0.id, 0x1::string::utf8(b"growth"), arg7);
        let v1 = HeroMinted{
            id          : 0x2::object::uid_to_inner(&v0.id),
            external_id : v0.external_id,
        };
        0x2::event::emit<HeroMinted>(v1);
        v0
    }

    public fun name(arg0: &Hero) : &0x1::string::String {
        &arg0.name
    }

    public fun pending_upgrade(arg0: &Hero) : &u64 {
        &arg0.pending_upgrade
    }

    public fun rarity(arg0: &Hero) : &0x1::string::String {
        &arg0.rarity
    }

    public(friend) fun remove_field<T0: drop + store>(arg0: &mut Hero, arg1: 0x1::string::String) {
        0x2::dynamic_field::remove<0x1::string::String, T0>(&mut arg0.id, arg1);
    }

    public fun skill_values(arg0: &Hero) : &vector<u16> {
        0x2::dynamic_field::borrow<0x1::string::String, vector<u16>>(&arg0.id, 0x1::string::utf8(b"skill"))
    }

    // decompiled from Move bytecode v6
}

