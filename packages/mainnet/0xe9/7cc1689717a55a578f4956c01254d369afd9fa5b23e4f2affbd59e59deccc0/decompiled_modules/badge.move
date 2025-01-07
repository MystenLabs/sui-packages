module 0xe97cc1689717a55a578f4956c01254d369afd9fa5b23e4f2affbd59e59deccc0::badge {
    struct Badge has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        image_url: 0x1::string::String,
        description: 0x1::string::String,
    }

    struct BADGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADGE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"E4C Demon Hunter Badge"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://cdn.ambrus.studio/NFTs/Demon_Hunter_Badge.jpeg"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Congratulations! You have earned your first Demon Hunter badge, a symbol of your entry into the E4C universe. Keep exploring and uncover more opportunities to earn $E4C tokens!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://www.ambrus.studio/#/"));
        let v4 = 0x2::package::claim<BADGE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Badge>(&v4, v0, v2, arg1);
        0x2::display::update_version<Badge>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Badge>>(v5, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0xe97cc1689717a55a578f4956c01254d369afd9fa5b23e4f2affbd59e59deccc0::verification::Verifier, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = b"";
        let v1 = 0x1::string::utf8(b"badge");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v1));
        let v2 = 0x1::string::utf8(b"mint");
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x1::string::String>(&v2));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(0x2::tx_context::sender(arg2)));
        0xe97cc1689717a55a578f4956c01254d369afd9fa5b23e4f2affbd59e59deccc0::verification::verify_signature(arg0, 0x2::tx_context::sender(arg2), arg1, &mut v0);
        let v3 = Badge{
            id          : 0x2::object::new(arg2),
            name        : 0x1::string::utf8(b"E4C Demon Hunter Badge"),
            image_url   : 0x1::string::utf8(b"https://cdn.ambrus.studio/NFTs/Demon_Hunter_Badge.jpeg"),
            description : 0x1::string::utf8(b"Congratulations! You have earned your first Demon Hunter badge, a symbol of your entry into the E4C universe. Keep exploring and uncover more opportunities to earn $E4C tokens!"),
        };
        0x2::transfer::transfer<Badge>(v3, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

