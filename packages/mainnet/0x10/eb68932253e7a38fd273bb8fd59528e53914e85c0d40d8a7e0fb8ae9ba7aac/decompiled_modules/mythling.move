module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling {
    struct MYTHLING has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Mythling has store, key {
        id: 0x2::object::UID,
        set_id: 0x1::string::String,
        card_id: 0x1::string::String,
        name: 0x1::string::String,
        serial: u64,
        rarity: 0x1::string::String,
        image_url: 0x1::string::String,
    }

    public fun burn(arg0: Mythling) {
        assert!(arg0.serial != 1, 0);
        let v0 = if (arg0.rarity == 0x1::string::utf8(b"C")) {
            true
        } else if (arg0.rarity == 0x1::string::utf8(b"R")) {
            true
        } else {
            arg0.rarity == 0x1::string::utf8(b"E")
        };
        assert!(v0, 1);
        let Mythling {
            id        : v1,
            set_id    : _,
            card_id   : _,
            name      : _,
            serial    : _,
            rarity    : _,
            image_url : _,
        } = arg0;
        0x2::object::delete(v1);
    }

    public fun card_id(arg0: &Mythling) : &0x1::string::String {
        &arg0.card_id
    }

    fun init(arg0: MYTHLING, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MYTHLING>(arg0, arg1);
        let v1 = 0x2::display::new<Mythling>(&v0, arg1);
        0x2::display::add<Mythling>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name} #{serial}"));
        0x2::display::add<Mythling>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{image_url}"));
        0x2::display::add<Mythling>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Atollia - The World of Mythlings. Card {card_id}, serial #{serial}."));
        0x2::display::add<Mythling>(&mut v1, 0x1::string::utf8(b"project_url"), 0x1::string::utf8(b"https://atollia.game"));
        0x2::display::update_version<Mythling>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Mythling>(&v0, arg1);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Mythling>>(v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v4);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Mythling>>(v3, v4);
        0x2::transfer::public_transfer<0x2::display::Display<Mythling>>(v1, v4);
        let v5 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v5, v4);
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: &mut 0x2::tx_context::TxContext) : Mythling {
        Mythling{
            id        : 0x2::object::new(arg6),
            set_id    : arg0,
            card_id   : arg1,
            name      : arg2,
            serial    : arg3,
            rarity    : arg4,
            image_url : arg5,
        }
    }

    public fun name(arg0: &Mythling) : &0x1::string::String {
        &arg0.name
    }

    public fun rarity(arg0: &Mythling) : &0x1::string::String {
        &arg0.rarity
    }

    public fun serial(arg0: &Mythling) : u64 {
        arg0.serial
    }

    public fun set_id(arg0: &Mythling) : &0x1::string::String {
        &arg0.set_id
    }

    // decompiled from Move bytecode v7
}

