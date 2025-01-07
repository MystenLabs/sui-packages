module 0x5be541fc44f0b3b0e8fbe8f4552352518b54017dac80a33c9f191f963ad40d59::voucher {
    struct Voucher has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        experience_slug: 0x1::string::String,
        guests: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VOUCHER has drop {
        dummy_field: bool,
    }

    public fun burn_voucher(arg0: Voucher, arg1: &mut 0x2::tx_context::TxContext) {
        let Voucher {
            id              : v0,
            name            : _,
            description     : _,
            image_url       : _,
            experience_slug : _,
            guests          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &Voucher) : 0x1::string::String {
        arg0.description
    }

    public fun experience_slug(arg0: &Voucher) : 0x1::string::String {
        arg0.experience_slug
    }

    public fun guests(arg0: &Voucher) : u64 {
        arg0.guests
    }

    public fun image_url(arg0: &Voucher) : 0x1::string::String {
        arg0.image_url
    }

    fun init(arg0: VOUCHER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<VOUCHER>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"guests"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{guests}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://quantumtemple.xyz/"));
        let v6 = 0x2::display::new_with_fields<Voucher>(&v0, v2, v4, arg1);
        0x2::display::update_version<Voucher>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<Voucher>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_sender(arg0: &AdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = Voucher{
            id              : 0x2::object::new(arg7),
            name            : arg1,
            description     : arg2,
            image_url       : arg3,
            experience_slug : arg4,
            guests          : arg5,
        };
        0x2::transfer::transfer<Voucher>(v0, arg6);
    }

    public fun name(arg0: &Voucher) : 0x1::string::String {
        arg0.name
    }

    // decompiled from Move bytecode v6
}

