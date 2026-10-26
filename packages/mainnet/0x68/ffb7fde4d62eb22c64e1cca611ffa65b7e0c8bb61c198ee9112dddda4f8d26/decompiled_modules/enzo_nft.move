module 0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::enzo_nft {
    struct EnzoNft has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
    }

    public fun url(arg0: &EnzoNft) : &0x2::url::Url {
        &arg0.url
    }

    public fun description(arg0: &EnzoNft) : &0x1::string::String {
        &arg0.description
    }

    public fun mint(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin(arg1, arg6);
        let v0 = EnzoNft{
            id          : 0x2::object::new(arg6),
            name        : arg3,
            description : arg4,
            url         : 0x2::url::new_unsafe_from_bytes(arg5),
        };
        0x2::transfer::transfer<EnzoNft>(v0, arg2);
        0x2::object::id<EnzoNft>(&v0)
    }

    public fun name(arg0: &EnzoNft) : &0x1::string::String {
        &arg0.name
    }

    public fun register_display(arg0: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::Version, arg1: &0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::Company, arg2: &mut 0x2::display_registry::DisplayRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::version::check_is_valid(arg0);
        0x68ffb7fde4d62eb22c64e1cca611ffa65b7e0c8bb61c198ee9112dddda4f8d26::company::assert_admin(arg1, arg3);
        let (v0, v1) = 0x2::display_registry::new<EnzoNft>(arg2, 0x1::internal::permit<EnzoNft>(), arg3);
        let v2 = v1;
        let v3 = v0;
        0x2::display_registry::set<EnzoNft>(&mut v3, &v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"{name}"));
        0x2::display_registry::set<EnzoNft>(&mut v3, &v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"{description}"));
        0x2::display_registry::set<EnzoNft>(&mut v3, &v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{url}"));
        0x2::display_registry::share<EnzoNft>(v3);
        0x2::transfer::public_transfer<0x2::display_registry::DisplayCap<EnzoNft>>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

