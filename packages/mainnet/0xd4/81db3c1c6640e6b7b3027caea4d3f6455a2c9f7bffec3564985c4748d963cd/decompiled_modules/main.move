module 0xd481db3c1c6640e6b7b3027caea4d3f6455a2c9f7bffec3564985c4748d963cd::main {
    struct WalletArt has key {
        id: 0x2::object::UID,
        number: u64,
        size: u64,
        data_url: 0x1::string::String,
        owner: address,
        version: u64,
        soulbound: bool,
    }

    struct WalletArtRegistry has key {
        id: 0x2::object::UID,
        count: u64,
    }

    struct MAIN has drop {
        dummy_field: bool,
    }

    public entry fun new(arg0: &mut WalletArtRegistry, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = b"Entered new() function.";
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = arg0.count;
        let v2 = b"Current registry count: ";
        0x1::debug::print<vector<u8>>(&v2);
        let v3 = 0x1::u64::to_string(v1);
        0x1::debug::print<0x1::string::String>(&v3);
        assert!(v1 < 18446744073709551615 - 1, 7);
        let v4 = 0x2::random::new_generator(arg1, arg2);
        let v5 = b"Random generator created.";
        0x1::debug::print<vector<u8>>(&v5);
        let v6 = 0x2::tx_context::sender(arg2);
        let v7 = b"Sender address (raw): ";
        0x1::debug::print<vector<u8>>(&v7);
        let v8 = 0x2::hex::encode(0x2::bcs::to_bytes<address>(&v6));
        0x1::debug::print<vector<u8>>(&v8);
        let v9 = generate_colors_from_address(v6);
        let v10 = b"Number of colors generated: ";
        0x1::debug::print<vector<u8>>(&v10);
        let v11 = 0x1::u64::to_string(0x1::vector::length<0x1::string::String>(&v9));
        0x1::debug::print<0x1::string::String>(&v11);
        let v12 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        let v13 = 1024;
        let v14 = b"Generating SVG for 32x32 grid";
        0x1::debug::print<vector<u8>>(&v14);
        let v15 = &mut v4;
        0x1::string::append(&mut v12, encode_8(generate_svg_8(&v9, v15, v13)));
        let v16 = b"SVG generated and encoded.";
        0x1::debug::print<vector<u8>>(&v16);
        let v17 = WalletArt{
            id        : 0x2::object::new(arg2),
            number    : arg0.count + 1,
            size      : v13,
            data_url  : v12,
            owner     : v6,
            version   : 1,
            soulbound : true,
        };
        let v18 = b"NFT created with number: ";
        0x1::debug::print<vector<u8>>(&v18);
        let v19 = 0x1::u64::to_string(arg0.count + 1);
        0x1::debug::print<0x1::string::String>(&v19);
        arg0.count = arg0.count + 1;
        let v20 = b"Registry count updated to: ";
        0x1::debug::print<vector<u8>>(&v20);
        let v21 = 0x1::u64::to_string(arg0.count);
        0x1::debug::print<0x1::string::String>(&v21);
        0x2::transfer::transfer<WalletArt>(v17, v6);
        let v22 = b"NFT transferred to the sender.";
        0x1::debug::print<vector<u8>>(&v22);
    }

    fun encode_8(arg0: vector<u8>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = &v0;
        let v2 = b"";
        0x1::vector::reverse<u8>(&mut arg0);
        while (0x1::vector::length<u8>(&arg0) > 0) {
            let v3 = 0x1::vector::pop_back<u8>(&mut arg0);
            let v4 = if (0x1::vector::length<u8>(&arg0) > 0) {
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v5 = if (0x1::vector::length<u8>(&arg0) > 0) {
                0x1::vector::pop_back<u8>(&mut arg0)
            } else {
                0
            };
            let v6 = if (v4 == 0) {
                64
            } else {
                (v4 & 15) << 2 | v5 >> 6
            };
            let v7 = if (v5 == 0) {
                64
            } else {
                v5 & 63
            };
            let v8 = 0x1::vector::empty<u8>();
            let v9 = &mut v8;
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, ((v3 >> 2) as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, (((v3 & 3) << 4 | v4 >> 4) as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, (v6 as u64)));
            0x1::vector::push_back<u8>(v9, *0x1::vector::borrow<u8>(v1, (v7 as u64)));
            0x1::vector::append<u8>(&mut v2, v8);
        };
        0x1::string::utf8(v2)
    }

    fun generate_colors_from_address(arg0: address) : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = 0x1::string::utf8(0x2::hex::encode(0x2::bcs::to_bytes<address>(&arg0)));
        let v2 = b"Address hex: ";
        0x1::debug::print<vector<u8>>(&v2);
        0x1::debug::print<0x1::string::String>(&v1);
        let v3 = 0;
        while (v3 + 6 <= 0x1::string::length(&v1)) {
            let v4 = 0x1::string::utf8(b"#");
            0x1::string::append(&mut v4, 0x1::string::substring(&v1, v3, v3 + 6));
            0x1::vector::push_back<0x1::string::String>(&mut v0, v4);
            v3 = v3 + 6;
        };
        if (0x1::vector::length<0x1::string::String>(&v0) < 3) {
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"#FF5733"));
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"#33FF57"));
            0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"#3357FF"));
        };
        v0
    }

    fun generate_svg_8(arg0: &vector<0x1::string::String>, arg1: &mut 0x2::random::RandomGenerator, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::u64::sqrt(arg2);
        if (v1 > 16) {
            0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 32 32'><rect width='32' height='32' fill='#FF0000'/></svg>");
            return v0
        };
        0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        let v2 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v2));
        0x1::vector::append<u8>(&mut v0, b" ");
        let v3 = 0x1::u64::to_string(v1);
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v3));
        0x1::vector::append<u8>(&mut v0, b"' style='width: 100vw; height: 100vh; image-rendering: pixelated; shape-rendering: crispEdges;' preserveAspectRatio='xMidYMid meet'>");
        0x1::vector::append<u8>(&mut v0, b"<style>rect { width: 1px; height: 1px; }</style>");
        let v4 = 0;
        while (v4 < v1) {
            0x1::vector::append<u8>(&mut v0, b"<g transform='translate(0, ");
            let v5 = 0x1::u64::to_string(v4);
            0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v5));
            0x1::vector::append<u8>(&mut v0, b")'>");
            let v6 = 0;
            while (v6 < v1) {
                0x1::vector::append<u8>(&mut v0, b"<rect x='");
                let v7 = 0x1::u64::to_string(v6);
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&v7));
                0x1::vector::append<u8>(&mut v0, b"' fill='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(select_random_element(arg1, arg0)));
                0x1::vector::append<u8>(&mut v0, b"'/>");
                v6 = v6 + 1;
            };
            0x1::vector::append<u8>(&mut v0, b"</g>");
            v4 = v4 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        v0
    }

    public fun get_nft_data_url(arg0: &WalletArt) : &0x1::string::String {
        &arg0.data_url
    }

    public fun get_nft_number(arg0: &WalletArt) : u64 {
        arg0.number
    }

    public fun get_nft_owner(arg0: &WalletArt) : address {
        arg0.owner
    }

    public fun get_nft_size(arg0: &WalletArt) : u64 {
        arg0.size
    }

    public fun get_registry_count(arg0: &WalletArtRegistry) : u64 {
        arg0.count
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MAIN>(arg0, arg1);
        let v1 = 0x2::display::new<WalletArt>(&v0, arg1);
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"rNFT #{number}"));
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A regenerative {size}-pixel NFT, compiled from color codes within your Sui wallet address."));
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<WalletArt>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{data_url}"));
        0x2::display::update_version<WalletArt>(&mut v1);
        let v2 = WalletArtRegistry{
            id    : 0x2::object::new(arg1),
            count : 0,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalletArt>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<WalletArtRegistry>(v2);
    }

    fun select_random_element(arg0: &mut 0x2::random::RandomGenerator, arg1: &vector<0x1::string::String>) : &0x1::string::String {
        let v0 = 0x1::vector::length<0x1::string::String>(arg1);
        assert!(v0 > 0, 5);
        let v1 = 0x2::random::generate_u64_in_range(arg0, 0, v0 - 1);
        if (v1 >= v0) {
            0x1::debug::print<u64>(&v1);
        };
        assert!(v1 < v0, 6);
        0x1::vector::borrow<0x1::string::String>(arg1, v1)
    }

    // decompiled from Move bytecode v6
}

