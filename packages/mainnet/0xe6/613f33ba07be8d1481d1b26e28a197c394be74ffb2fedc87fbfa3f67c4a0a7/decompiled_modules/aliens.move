module 0x6c66bd368aca2053985589095ae4d56a9237c20b3c8e1b79388910ec2883905f::aliens {
    struct ALIENS has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        max_supply: u64,
        minted: u64,
    }

    struct Alien has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        number: u64,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
        revealed: bool,
    }

    struct AlienMinted has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        recipient: address,
    }

    struct AlienRevealed has copy, drop {
        object_id: 0x2::object::ID,
        number: u64,
        image_url: 0x1::string::String,
        rarity: 0x1::string::String,
    }

    public fun attributes(arg0: &Alien) : &0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        &arg0.attributes
    }

    public fun burn(arg0: Alien) {
        let Alien {
            id          : v0,
            name        : _,
            description : _,
            image_url   : _,
            number      : _,
            attributes  : _,
            revealed    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Alien) : 0x1::string::String {
        arg0.description
    }

    public fun image_url(arg0: &Alien) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: ALIENS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<ALIENS>(arg0, arg1);
        let v2 = 0x2::display::new<Alien>(&v1, arg1);
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"#{number}"));
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"link"), 0x1::string::utf8(b"https://aliens.example/alien/{id}"));
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://aliens.example"));
        0x2::display::add<Alien>(&mut v2, 0x1::string::utf8(b"creator"), 0x1::string::utf8(b"Aliens Team"));
        0x2::display::update_version<Alien>(&mut v2);
        let (v3, v4) = 0x2::transfer_policy::new<Alien>(&v1, arg1);
        let v5 = v4;
        let v6 = v3;
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::royalty_rule::add<Alien>(&mut v6, &v5, 500, 125000000);
        0x434b5bd8f6a7b05fede0ff46c6e511d71ea326ed38056e3bcd681d2d7c2a7879::kiosk_lock_rule::add<Alien>(&mut v6, &v5);
        let v7 = Collection{
            id         : 0x2::object::new(arg1),
            name       : 0x1::string::utf8(b"Aliens"),
            max_supply : 10000,
            minted     : 0,
        };
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Alien>>(v6);
        0x2::transfer::share_object<Collection>(v7);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Alien>>(v5, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
        0x2::transfer::public_transfer<0x2::display::Display<Alien>>(v2, v0);
        let v8 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v8, v0);
    }

    public fun is_revealed(arg0: &Alien) : bool {
        arg0.revealed
    }

    public fun max_supply(arg0: &Collection) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &AdminCap, arg1: &mut Collection, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg1.minted < arg1.max_supply, 0);
        arg1.minted = arg1.minted + 1;
        let v0 = arg1.minted;
        let v1 = 0x1::string::utf8(b"Alien #");
        0x1::string::append(&mut v1, u64_to_string(v0));
        let v2 = Alien{
            id          : 0x2::object::new(arg3),
            name        : v1,
            description : 0x1::string::utf8(b"A mysterious alien from a distant galaxy. (unrevealed)"),
            image_url   : 0x1::string::utf8(b"https://i.pinimg.com/736x/74/f0/fa/74f0fa16a6e57e48c16499081d7bedf5.jpg"),
            number      : v0,
            attributes  : mock_attributes(v0),
            revealed    : false,
        };
        let v3 = 0x2::object::id<Alien>(&v2);
        let v4 = AlienMinted{
            object_id : v3,
            number    : v0,
            recipient : arg2,
        };
        0x2::event::emit<AlienMinted>(v4);
        0x2::transfer::public_transfer<Alien>(v2, arg2);
        v3
    }

    public fun mint_many(arg0: &AdminCap, arg1: &mut Collection, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg2) {
            mint(arg0, arg1, arg3, arg4);
            v0 = v0 + 1;
        };
    }

    public fun minted(arg0: &Collection) : u64 {
        arg0.minted
    }

    fun mock_attributes(arg0: u64) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        let v0 = 0x2::vec_map::empty<0x1::string::String, 0x1::string::String>();
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Species"), nth(vector[b"Grey", b"Reptilian", b"Nordic", b"Insectoid", b"Energy Being"], arg0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Planet"), nth(vector[b"Zeta Reticuli", b"Sirius B", b"Andromeda", b"Proxima b", b"Kepler-442b"], arg0 / 5));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Skin"), nth(vector[b"Emerald", b"Violet", b"Obsidian", b"Golden", b"Translucent"], arg0 / 3));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Eyes"), nth(vector[b"Single", b"Compound", b"Triple", b"Glowing", b"Void"], arg0 / 7));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Aura"), nth(vector[b"Plasma", b"Quantum", b"Cosmic", b"Toxic", b"Stellar"], arg0 / 11));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Rarity"), nth(vector[b"Common", b"Common", b"Common", b"Common", b"Common", b"Uncommon", b"Uncommon", b"Uncommon", b"Rare", b"Rare", b"Epic", b"Legendary"], arg0));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Power"), u64_to_string((arg0 * 37 + 13) % 100 + 1));
        0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut v0, 0x1::string::utf8(b"Status"), 0x1::string::utf8(b"Unrevealed"));
        v0
    }

    public fun name(arg0: &Alien) : 0x1::string::String {
        arg0.name
    }

    fun nth(arg0: vector<vector<u8>>, arg1: u64) : 0x1::string::String {
        0x1::string::utf8(*0x1::vector::borrow<vector<u8>>(&arg0, arg1 % 0x1::vector::length<vector<u8>>(&arg0)))
    }

    public fun number(arg0: &Alien) : u64 {
        arg0.number
    }

    public fun reveal(arg0: &AdminCap, arg1: &mut Alien, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(!arg1.revealed, 1);
        arg1.image_url = 0x1::string::utf8(arg2);
        arg1.description = 0x1::string::utf8(b"A fully revealed Alien specimen.");
        let v0 = 0x1::string::utf8(arg3);
        set_attr(arg1, 0x1::string::utf8(b"Rarity"), v0);
        set_attr(arg1, 0x1::string::utf8(b"Status"), 0x1::string::utf8(b"Revealed"));
        arg1.revealed = true;
        let v1 = AlienRevealed{
            object_id : 0x2::object::id<Alien>(arg1),
            number    : arg1.number,
            image_url : arg1.image_url,
            rarity    : v0,
        };
        0x2::event::emit<AlienRevealed>(v1);
    }

    public fun royalty_bps() : u16 {
        500
    }

    public fun royalty_min() : u64 {
        125000000
    }

    fun set_attr(arg0: &mut Alien, arg1: 0x1::string::String, arg2: 0x1::string::String) {
        if (0x2::vec_map::contains<0x1::string::String, 0x1::string::String>(&arg0.attributes, &arg1)) {
            *0x2::vec_map::get_mut<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, &arg1) = arg2;
        } else {
            0x2::vec_map::insert<0x1::string::String, 0x1::string::String>(&mut arg0.attributes, arg1, arg2);
        };
    }

    public fun set_attribute(arg0: &AdminCap, arg1: &mut Alien, arg2: vector<u8>, arg3: vector<u8>) {
        set_attr(arg1, 0x1::string::utf8(arg2), 0x1::string::utf8(arg3));
    }

    fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v7
}

