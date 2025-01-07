module 0x17af7effd02b48401da891e682d6bed834b267a2fdb2c9e88ae8de2a76ee9650::droplet {
    struct Droplet has store, key {
        id: 0x2::object::UID,
        rarity: 0x1::string::String,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DROPLET has drop {
        dummy: bool,
    }

    public fun burn(arg0: Droplet) {
        let Droplet {
            id     : v0,
            rarity : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    fun init(arg0: DROPLET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"thumbnail_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"creator"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Droplet"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nft.7k.ag/7k-nft/droplets/{rarity}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nft.7k.ag/7k-nft/droplets/{rarity}.gif"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Turning DROPS into treasures!"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://7k.ag"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"7k Smart Trading"));
        let v4 = 0x2::package::claim<DROPLET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<Droplet>(&v4, v0, v2, arg1);
        0x2::display::update_version<Droplet>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<Droplet>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v6, 0x2::tx_context::sender(arg1));
    }

    public fun mint_to_addresses(arg0: &AdminCap, arg1: vector<address>, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        while (0x1::vector::length<address>(&arg1) > 0) {
            let v0 = Droplet{
                id     : 0x2::object::new(arg3),
                rarity : arg2,
            };
            0x2::transfer::transfer<Droplet>(v0, 0x1::vector::pop_back<address>(&mut arg1));
        };
    }

    // decompiled from Move bytecode v6
}

