module 0xece1015e7799e25e4de12a731280b16b1cf978eefd2b8cdb12129c9e4032a38f::karikid {
    struct KARIKID has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct KariKid has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x2::url::Url,
        description: 0x1::string::String,
        number: 0x1::string::String,
        crestor: address,
        attributes: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
        attributes2: 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::Attributes,
    }

    struct MintEven has copy, drop {
        object_id: 0x2::object::ID,
        name: 0x1::string::String,
        number: 0x1::string::String,
        crestor: address,
    }

    public entry fun transfer(arg0: KariKid, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<KariKid>(arg0, arg1);
    }

    public entry fun burn(arg0: KariKid, arg1: &mut 0x2::tx_context::TxContext) {
        let KariKid {
            id          : v0,
            name        : _,
            image_url   : _,
            description : _,
            number      : _,
            crestor     : _,
            attributes  : _,
            attributes2 : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: KARIKID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"crestor"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{names}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{link}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{description}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://art.kanari.network"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{crestor}"));
        let v4 = 0x2::package::claim<KARIKID>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<KariKid>(&v4, v0, v2, arg1);
        0x2::display::update_version<KariKid>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<KariKid>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<0x1::ascii::String>, arg5: vector<0x1::ascii::String>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = KariKid{
            id          : 0x2::object::new(arg6),
            name        : 0x1::string::utf8(arg0),
            image_url   : 0x2::url::new_unsafe_from_bytes(arg3),
            description : 0x1::string::utf8(arg1),
            number      : 0x1::string::utf8(arg2),
            crestor     : 0x2::tx_context::sender(arg6),
            attributes  : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::add_from_vec(arg4, arg5),
            attributes2 : 0xbc3df36be17f27ac98e3c839b2589db8475fa07b20657b08e8891e3aaf5ee5f9::attributes::add_from_vec(arg4, arg5),
        };
        let v2 = MintEven{
            object_id : 0x2::object::id<KariKid>(&v1),
            name      : v1.name,
            number    : v1.number,
            crestor   : v0,
        };
        0x2::event::emit<MintEven>(v2);
        0x2::transfer::public_transfer<KariKid>(v1, v0);
    }

    public entry fun update_description(arg0: &mut KariKid, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    // decompiled from Move bytecode v6
}

