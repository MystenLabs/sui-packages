module 0x6fdd7cf30f7ae90aa01580efae70f1757fc912c5e4be5d5544044c2f5e25d9f5::kumo_plushies {
    struct KUMO_PLUSHIES has drop {
        dummy_field: bool,
    }

    struct KumoPlushie has store, key {
        id: 0x2::object::UID,
        number: u64,
        season: u64,
    }

    struct KumoPlushieMintAuth has store, key {
        id: 0x2::object::UID,
        mint_count: u64,
    }

    struct KumoPlushieMintedEvent has copy, drop {
        id: 0x2::object::ID,
        number: u64,
        season: u64,
    }

    fun init(arg0: KUMO_PLUSHIES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::package::claim<KUMO_PLUSHIES>(arg0, arg1);
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"project_url"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"creator"));
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = &mut v4;
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Kumo Plushie #{number}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://lk-web3-dashboard.vercel.app/api/renderplushienft?number={number}&season={season}"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"This NFT serves as digital proof of ownership for the physical Kumo Plushie #{number}, part of the first line of Kumo consumer products. Ownership of this NFT represents a claim to the associated real-world asset."));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"https://kumo.land"));
        0x1::vector::push_back<0x1::string::String>(v5, 0x1::string::utf8(b"Lucky Kat Studios"));
        let v6 = 0x2::display::new_with_fields<KumoPlushie>(&v1, v2, v4, arg1);
        0x2::display::update_version<KumoPlushie>(&mut v6);
        0x2::transfer::public_transfer<0x2::display::Display<KumoPlushie>>(v6, v0);
        let v7 = KumoPlushieMintAuth{
            id         : 0x2::object::new(arg1),
            mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoPlushieMintAuth>(v7, v0);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v1, v0);
    }

    public fun mint_auth_to_address(arg0: &0x2::package::Publisher, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_package<KumoPlushie>(arg0), 0);
        let v0 = KumoPlushieMintAuth{
            id         : 0x2::object::new(arg2),
            mint_count : 0,
        };
        0x2::transfer::public_transfer<KumoPlushieMintAuth>(v0, arg1);
    }

    public fun mint_to_address(arg0: &mut KumoPlushieMintAuth, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = KumoPlushie{
            id     : 0x2::object::new(arg3),
            number : arg0.mint_count,
            season : arg1,
        };
        arg0.mint_count = arg0.mint_count + 1;
        let v1 = KumoPlushieMintedEvent{
            id     : 0x2::object::id<KumoPlushie>(&v0),
            number : v0.number,
            season : v0.season,
        };
        0x2::event::emit<KumoPlushieMintedEvent>(v1);
        0x2::transfer::public_transfer<KumoPlushie>(v0, arg2);
    }

    public entry fun mutate_display(arg0: &0x2::package::Publisher, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::display::Display<KumoPlushie>) {
        assert!(0x2::package::from_package<KumoPlushie>(arg0), 0);
        0x2::display::edit<KumoPlushie>(arg3, arg1, arg2);
        0x2::display::update_version<KumoPlushie>(arg3);
    }

    // decompiled from Move bytecode v6
}

