module 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain {
    struct Domain has store, key {
        id: 0x2::object::UID,
        version: u64,
        domain_name: 0x1::ascii::String,
        domain_tld: 0x1::ascii::String,
        name: 0x1::ascii::String,
        image: 0x2::url::Url,
        text_records: 0x2::table::Table<0x1::ascii::String, 0x1::ascii::String>,
        timestamp: u64,
    }

    struct DOMAIN has drop {
        dummy_field: bool,
    }

    public(friend) fun new(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : Domain {
        Domain{
            id           : 0x2::object::new(arg3),
            version      : 1,
            domain_name  : arg0,
            domain_tld   : arg1,
            name         : 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::util::make_domain(&arg0, &arg1),
            image        : 0x2::url::new_unsafe_from_bytes(b"."),
            text_records : 0x2::table::new<0x1::ascii::String, 0x1::ascii::String>(arg3),
            timestamp    : arg2,
        }
    }

    public entry fun add_addresses(arg0: &mut Domain, arg1: vector<0x1::ascii::String>, arg2: vector<0x1::ascii::String>) {
        assert!(arg0.version == 1, 3);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1) == 0x1::vector::length<0x1::ascii::String>(&arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg1)) {
            set_address_internal(arg0, *0x1::vector::borrow<0x1::ascii::String>(&arg1, v0), *0x1::vector::borrow<0x1::ascii::String>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun domain_name(arg0: &Domain) : 0x1::ascii::String {
        arg0.domain_name
    }

    public fun domain_tld(arg0: &Domain) : 0x1::ascii::String {
        arg0.domain_tld
    }

    public fun id(arg0: &Domain) : &0x2::object::UID {
        &arg0.id
    }

    public fun image(arg0: &Domain) : 0x2::url::Url {
        arg0.image
    }

    fun init(arg0: DOMAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<DOMAIN>(arg0, arg1);
        let v2 = 0x2::display::new<Domain>(&v1, arg1);
        0x2::display::add<Domain>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display::add<Domain>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{name} by Stork Domains."));
        0x2::display::add<Domain>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display::update_version<Domain>(&mut v2);
        0x2::transfer::public_transfer<0x2::display::Display<Domain>>(v2, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun name(arg0: &Domain) : 0x1::ascii::String {
        arg0.name
    }

    fun remove_address_internal(arg0: &mut Domain, arg1: 0x1::ascii::String) {
        0x2::dynamic_field::remove<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.id, arg1);
    }

    public entry fun remove_addresses(arg0: &mut Domain, arg1: vector<0x1::ascii::String>) {
        assert!(arg0.version == 1, 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg1)) {
            remove_address_internal(arg0, *0x1::vector::borrow<0x1::ascii::String>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    public entry fun remove_text_records(arg0: &mut Domain, arg1: vector<0x1::ascii::String>) {
        assert!(arg0.version == 1, 3);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1) <= 0x2::table::length<0x1::ascii::String, 0x1::ascii::String>(&arg0.text_records), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg1)) {
            0x2::table::remove<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.text_records, *0x1::vector::borrow<0x1::ascii::String>(&arg1, v0));
            v0 = v0 + 1;
        };
    }

    fun set_address_internal(arg0: &mut Domain, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String) {
        if (0x2::dynamic_field::exists_<0x1::ascii::String>(&arg0.id, arg1)) {
            0x2::dynamic_field::remove<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.id, arg1);
        };
        0x2::dynamic_field::add<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.id, arg1, arg2);
    }

    public entry fun set_image(arg0: &mut Domain, arg1: 0x1::ascii::String) {
        assert!(arg0.version == 1, 3);
        arg0.image = 0x2::url::new_unsafe(arg1);
    }

    public entry fun set_text_records(arg0: &mut Domain, arg1: vector<0x1::ascii::String>, arg2: vector<0x1::ascii::String>) {
        assert!(arg0.version == 1, 3);
        assert!(0x1::vector::length<0x1::ascii::String>(&arg1) == 0x1::vector::length<0x1::ascii::String>(&arg2), 2);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::ascii::String>(&arg1)) {
            let v1 = *0x1::vector::borrow<0x1::ascii::String>(&arg1, v0);
            if (0x2::table::contains<0x1::ascii::String, 0x1::ascii::String>(&arg0.text_records, v1)) {
                0x2::table::remove<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.text_records, v1);
            };
            0x2::table::add<0x1::ascii::String, 0x1::ascii::String>(&mut arg0.text_records, v1, *0x1::vector::borrow<0x1::ascii::String>(&arg2, v0));
            v0 = v0 + 1;
        };
    }

    public fun text_records(arg0: &Domain) : &0x2::table::Table<0x1::ascii::String, 0x1::ascii::String> {
        &arg0.text_records
    }

    public fun timestamp(arg0: &Domain) : &u64 {
        &arg0.timestamp
    }

    public fun version(arg0: &Domain) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

