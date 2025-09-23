module 0xb8e077a39486e255e16086142d366e0e99be83b78c428f7adf41658ccd1d70d7::gawblenz {
    struct Gawblen has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        token_id: u16,
        attributes: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        max_id: u16,
        current: u16,
    }

    public fun attributes(arg0: &Gawblen) : 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String> {
        arg0.attributes
    }

    public fun burn_cap(arg0: AdminCap) {
        assert!(arg0.current > arg0.max_id, 1);
        let AdminCap {
            id      : v0,
            max_id  : _,
            current : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun create(arg0: &mut AdminCap, arg1: &mut 0xb8e077a39486e255e16086142d366e0e99be83b78c428f7adf41658ccd1d70d7::distribution::Distribution<Gawblen>, arg2: 0x1::string::String, arg3: 0x2::vec_map::VecMap<0x1::string::String, 0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.current <= arg0.max_id, 2);
        let v0 = 0x1::string::utf8(b"Gawblen #");
        0x1::string::append(&mut v0, 0x1::u16::to_string(arg0.current));
        let v1 = Gawblen{
            id          : 0x2::object::new(arg4),
            name        : v0,
            description : 0x1::string::utf8(b"No think. Just Gawblen"),
            image_url   : arg2,
            token_id    : arg0.current,
            attributes  : arg3,
        };
        0xb8e077a39486e255e16086142d366e0e99be83b78c428f7adf41658ccd1d70d7::distribution::add_nft<Gawblen>(arg1, v1);
        arg0.current = arg0.current + 1;
    }

    public fun image_url(arg0: &Gawblen) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            max_id  : 3333,
            current : 1,
        };
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun token_id(arg0: &Gawblen) : &u16 {
        &arg0.token_id
    }

    // decompiled from Move bytecode v6
}

