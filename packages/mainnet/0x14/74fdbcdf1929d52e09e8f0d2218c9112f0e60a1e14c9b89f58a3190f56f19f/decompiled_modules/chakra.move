module 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::chakra {
    struct CHAKRA has drop {
        dummy_field: bool,
    }

    struct Chakra has store, key {
        id: 0x2::object::UID,
        number: u64,
        points: u64,
        minted_by: 0x1::option::Option<address>,
    }

    public(friend) fun id(arg0: &Chakra) : 0x2::object::ID {
        0x2::object::id<Chakra>(arg0)
    }

    public fun burn(arg0: Chakra) {
        let Chakra {
            id        : v0,
            number    : _,
            points    : _,
            minted_by : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create(arg0: &mut 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::registry::Registry, arg1: &mut 0x2::tx_context::TxContext) : Chakra {
        let v0 = 0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::registry::count(arg0) + 1;
        let v1 = Chakra{
            id        : 0x2::object::new(arg1),
            number    : v0,
            points    : v0,
            minted_by : 0x1::option::none<address>(),
        };
        0x1474fdbcdf1929d52e09e8f0d2218c9112f0e60a1e14c9b89f58a3190f56f19f::registry::add(v0, 0x2::object::id<Chakra>(&v1), arg0);
        v1
    }

    fun init(arg0: CHAKRA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<CHAKRA>(arg0, arg1);
        let v1 = 0x2::display::new<Chakra>(&v0, arg1);
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Chakra #{number}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"Chakra #{number}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"https://kriya-assets.s3.ap-southeast-1.amazonaws.com/assets/{points}.png"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"minted_by"), 0x1::string::utf8(b"{minted_by}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"kiosk_id"), 0x1::string::utf8(b"{kiosk_id}"));
        0x2::display::add<Chakra>(&mut v1, 0x1::string::utf8(b"kiosk_owner_cap_id"), 0x1::string::utf8(b"{kiosk_owner_cap_id}"));
        0x2::display::update_version<Chakra>(&mut v1);
        let (v2, v3) = 0x2::transfer_policy::new<Chakra>(&v0, arg1);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<Chakra>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Chakra>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<Chakra>>(v2);
    }

    public(friend) fun number(arg0: &Chakra) : u64 {
        arg0.number
    }

    public(friend) fun points(arg0: &Chakra) : u64 {
        arg0.points
    }

    public(friend) fun set_minted_by_address(arg0: &mut Chakra, arg1: address) {
        0x1::option::fill<address>(&mut arg0.minted_by, arg1);
    }

    public fun set_points(arg0: &mut Chakra, arg1: u64) {
        arg0.points = arg1;
    }

    public(friend) fun uid_mut(arg0: &mut Chakra) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    // decompiled from Move bytecode v6
}

