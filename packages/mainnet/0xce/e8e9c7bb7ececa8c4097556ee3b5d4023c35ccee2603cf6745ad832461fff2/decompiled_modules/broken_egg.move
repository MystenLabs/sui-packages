module 0xcee8e9c7bb7ececa8c4097556ee3b5d4023c35ccee2603cf6745ad832461fff2::broken_egg {
    struct BrokenEgg has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        img_url: 0x2::url::Url,
    }

    struct BROKEN_EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROKEN_EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamio.online/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Magic Stone that contain too much energy break Evo Eggshell. Evo Egg was broken."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamio.online/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://gamio.online/lobby"));
        let v4 = 0x2::package::claim<BROKEN_EGG>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<BrokenEgg>(&v4, v0, v2, arg1);
        0x2::display::update_version<BrokenEgg>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<BrokenEgg>>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::tx_context::TxContext) : BrokenEgg {
        BrokenEgg{
            id      : 0x2::object::new(arg0),
            name    : 0x1::string::utf8(b"Broken Evo Egg"),
            img_url : 0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihjak7rph5fzxkzswquxkmzjfimjpa74xj6jaq4wnqx45ffmbcuru"),
        }
    }

    // decompiled from Move bytecode v6
}

