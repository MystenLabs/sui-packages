module 0xbf86968ca2348f5aebabec6b0ca486c2dfb3a9dbd3d8436a5f2f52b2f6b49be6::main {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct FeeConfig has copy, drop, store {
        fee_32x32: u64,
        regeneration_fee: u64,
        fee_recipient: address,
        current_gas_price: u64,
    }

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
        fee_config: FeeConfig,
    }

    struct MAIN has drop {
        dummy_field: bool,
    }

    public entry fun new(arg0: &mut WalletArtRegistry, arg1: &0x2::random::Random, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = b"Entered new() function.";
        0x1::debug::print<vector<u8>>(&v0);
        let v1 = b"Grid size: 32x32";
        0x1::debug::print<vector<u8>>(&v1);
        let v2 = 5000000000 + arg0.fee_config.current_gas_price;
        let v3 = b"Required total: ";
        0x1::debug::print<vector<u8>>(&v3);
        let v4 = 0x1::string::into_bytes(0x1::u64::to_string(v2));
        0x1::debug::print<vector<u8>>(&v4);
        let v5 = 0x2::coin::value<0x2::sui::SUI>(arg2);
        let v6 = b"Payment value: ";
        0x1::debug::print<vector<u8>>(&v6);
        let v7 = 0x1::string::into_bytes(0x1::u64::to_string(v5));
        0x1::debug::print<vector<u8>>(&v7);
        assert!(v5 >= v2, 2);
        let v8 = b"Payment check passed.";
        0x1::debug::print<vector<u8>>(&v8);
        assert!(arg0.count < 18446744073709551615, 7);
        let v9 = b"Current registry count: ";
        0x1::debug::print<vector<u8>>(&v9);
        let v10 = 0x1::string::into_bytes(0x1::u64::to_string(arg0.count));
        0x1::debug::print<vector<u8>>(&v10);
        if (v2 > 0) {
            let v11 = b"Payment split successfully.";
            0x1::debug::print<vector<u8>>(&v11);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v2, arg3), arg0.fee_config.fee_recipient);
            let v12 = b"Payment transferred to fee recipient.";
            0x1::debug::print<vector<u8>>(&v12);
        };
        let v13 = 0x2::random::new_generator(arg1, arg3);
        let v14 = b"Random generator created.";
        0x1::debug::print<vector<u8>>(&v14);
        let v15 = 0x2::tx_context::sender(arg3);
        let v16 = b"Sender address (raw): ";
        0x1::debug::print<vector<u8>>(&v16);
        let v17 = 0x2::hex::encode(0x2::bcs::to_bytes<address>(&v15));
        0x1::debug::print<vector<u8>>(&v17);
        let v18 = generate_colors_from_address(v15);
        let v19 = b"Number of colors generated: ";
        0x1::debug::print<vector<u8>>(&v19);
        let v20 = 0x1::string::into_bytes(0x1::u64::to_string(0x1::vector::length<0x1::string::String>(&v18)));
        0x1::debug::print<vector<u8>>(&v20);
        let v21 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        if (1024 <= 512) {
            let v22 = b"Generating SVG for grid sizes <= 512 (SVG 8)";
            0x1::debug::print<vector<u8>>(&v22);
            let v23 = &mut v13;
            0x1::string::append(&mut v21, encode_8(generate_svg_8(&v18, v23, 1024)));
            let v24 = b"SVG 8 generated and encoded.";
            0x1::debug::print<vector<u8>>(&v24);
        } else {
            let v25 = b"Generating SVG for grid sizes > 512 (SVG 16)";
            0x1::debug::print<vector<u8>>(&v25);
            let v26 = &mut v13;
            0x1::string::append(&mut v21, encode_16(generate_svg_16(&v18, v26, 1024)));
            let v27 = b"SVG 16 generated and encoded.";
            0x1::debug::print<vector<u8>>(&v27);
        };
        let v28 = WalletArt{
            id        : 0x2::object::new(arg3),
            number    : arg0.count + 1,
            size      : 1024,
            data_url  : v21,
            owner     : v15,
            version   : 1,
            soulbound : true,
        };
        let v29 = b"NFT created with number: ";
        0x1::debug::print<vector<u8>>(&v29);
        let v30 = 0x1::string::into_bytes(0x1::u64::to_string(arg0.count + 1));
        0x1::debug::print<vector<u8>>(&v30);
        arg0.count = arg0.count + 1;
        let v31 = b"Registry count updated to: ";
        0x1::debug::print<vector<u8>>(&v31);
        let v32 = 0x1::string::into_bytes(0x1::u64::to_string(arg0.count));
        0x1::debug::print<vector<u8>>(&v32);
        0x2::transfer::transfer<WalletArt>(v28, v15);
        let v33 = b"NFT transferred to the sender.";
        0x1::debug::print<vector<u8>>(&v33);
    }

    fun encode_16(arg0: vector<u16>) : 0x1::string::String {
        let v0 = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";
        let v1 = &v0;
        let v2 = b"";
        let v3 = 0;
        while (v3 < 0x1::vector::length<u16>(&arg0)) {
            let v4 = *0x1::vector::borrow<u16>(&arg0, v3);
            if (v4 < 128) {
                0x1::vector::push_back<u8>(&mut v2, (v4 as u8));
            } else if (v4 < 2048) {
                0x1::vector::push_back<u8>(&mut v2, ((v4 >> 6 | 192) as u8));
                0x1::vector::push_back<u8>(&mut v2, ((v4 & 63 | 128) as u8));
            } else {
                0x1::vector::push_back<u8>(&mut v2, ((v4 >> 12 | 224) as u8));
                0x1::vector::push_back<u8>(&mut v2, ((v4 >> 6 & 63 | 128) as u8));
                0x1::vector::push_back<u8>(&mut v2, ((v4 & 63 | 128) as u8));
            };
            v3 = v3 + 1;
        };
        let v5 = b"";
        let v6 = 0;
        let v7 = 0x1::vector::length<u8>(&v2);
        while (v6 < v7) {
            let v8 = *0x1::vector::borrow<u8>(&v2, v6);
            let v9 = if (v6 + 1 < v7) {
                *0x1::vector::borrow<u8>(&v2, v6 + 1)
            } else {
                0
            };
            let v10 = if (v6 + 2 < v7) {
                *0x1::vector::borrow<u8>(&v2, v6 + 2)
            } else {
                0
            };
            let v11 = if (v6 + 1 >= v7) {
                64
            } else {
                (v9 & 15) << 2 | v10 >> 6
            };
            let v12 = if (v6 + 2 >= v7) {
                64
            } else {
                v10 & 63
            };
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(v1, ((v8 >> 2) as u64)));
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(v1, (((v8 & 3) << 4 | v9 >> 4) as u64)));
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(v1, (v11 as u64)));
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(v1, (v12 as u64)));
            v6 = v6 + 3;
        };
        0x1::string::utf8(v5)
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

    public fun estimate_total_cost(arg0: &WalletArtRegistry) : (u64, u64, u64) {
        let v0 = arg0.fee_config.fee_32x32;
        let v1 = 5000 * arg0.fee_config.current_gas_price;
        (v1, v0, v1 + v0)
    }

    public fun generate_colors_from_address(arg0: address) : vector<0x1::string::String> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = 0;
        while (v2 + 2 < 0x1::vector::length<u8>(&v0)) {
            let v3 = 0x1::string::utf8(b"#");
            let v4 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&v0, v2));
            let v5 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v5, *0x1::vector::borrow<u8>(&v0, v2 + 1));
            let v6 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v0, v2 + 2));
            0x1::string::append(&mut v3, 0x1::string::utf8(0x2::hex::encode(v4)));
            0x1::string::append(&mut v3, 0x1::string::utf8(0x2::hex::encode(v5)));
            0x1::string::append(&mut v3, 0x1::string::utf8(0x2::hex::encode(v6)));
            0x1::vector::push_back<0x1::string::String>(&mut v1, v3);
            v2 = v2 + 3;
        };
        v1
    }

    fun generate_svg_16(arg0: &vector<0x1::string::String>, arg1: &mut 0x2::random::RandomGenerator, arg2: u64) : vector<u16> {
        let v0 = 0x1::vector::empty<u16>();
        let v1 = 0x1::u64::sqrt(arg2);
        let v2 = 0x1::u64::to_string(v1);
        let v3 = 0x1::string::as_bytes(&v2);
        let v4 = b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ";
        let v5 = &mut v0;
        push_bytes_as_u16(&v4, v5);
        let v6 = &mut v0;
        push_bytes_as_u16(v3, v6);
        let v7 = b" ";
        let v8 = &mut v0;
        push_bytes_as_u16(&v7, v8);
        let v9 = &mut v0;
        push_bytes_as_u16(v3, v9);
        let v10 = b"' style='width: 100vw; height: 100vh; image-rendering: pixelated; shape-rendering: crispEdges;' preserveAspectRatio='xMidYMid meet'>";
        let v11 = &mut v0;
        push_bytes_as_u16(&v10, v11);
        let v12 = b"<style>rect { width: 1px; height: 1px; }</style>";
        let v13 = &mut v0;
        push_bytes_as_u16(&v12, v13);
        let v14 = 0;
        while (v14 < v1) {
            let v15 = b"<g transform='translate(0, ";
            let v16 = &mut v0;
            push_bytes_as_u16(&v15, v16);
            let v17 = 0x1::u64::to_string(v14);
            let v18 = &mut v0;
            push_bytes_as_u16(0x1::string::as_bytes(&v17), v18);
            let v19 = b")'>";
            let v20 = &mut v0;
            push_bytes_as_u16(&v19, v20);
            let v21 = 0;
            while (v21 < v1) {
                let v22 = b"<rect x='";
                let v23 = &mut v0;
                push_bytes_as_u16(&v22, v23);
                let v24 = 0x1::u64::to_string(v21);
                let v25 = &mut v0;
                push_bytes_as_u16(0x1::string::as_bytes(&v24), v25);
                let v26 = b"' fill='";
                let v27 = &mut v0;
                push_bytes_as_u16(&v26, v27);
                let v28 = &mut v0;
                push_bytes_as_u16(0x1::string::as_bytes(select_random_element(arg1, arg0)), v28);
                let v29 = b"'/>";
                let v30 = &mut v0;
                push_bytes_as_u16(&v29, v30);
                v21 = v21 + 1;
            };
            let v31 = b"</g>";
            let v32 = &mut v0;
            push_bytes_as_u16(&v31, v32);
            v14 = v14 + 1;
        };
        let v33 = b"</svg>";
        let v34 = &mut v0;
        push_bytes_as_u16(&v33, v34);
        v0
    }

    fun generate_svg_8(arg0: &vector<0x1::string::String>, arg1: &mut 0x2::random::RandomGenerator, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::u64::sqrt(arg2);
        0x1::vector::append<u8>(&mut v0, b"<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 ");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(v1)));
        0x1::vector::append<u8>(&mut v0, b" ");
        0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(v1)));
        0x1::vector::append<u8>(&mut v0, b"' style='width: 100vw; height: 100vh; image-rendering: pixelated; shape-rendering: crispEdges;' preserveAspectRatio='xMidYMid meet'>");
        0x1::vector::append<u8>(&mut v0, b"<style>rect { width: 1px; height: 1px; }</style>");
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::append<u8>(&mut v0, b"<g transform='translate(0, ");
            0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(v2)));
            0x1::vector::append<u8>(&mut v0, b")'>");
            let v3 = 0;
            while (v3 < v1) {
                0x1::vector::append<u8>(&mut v0, b"<rect x='");
                0x1::vector::append<u8>(&mut v0, 0x1::string::into_bytes(0x1::u64::to_string(v3)));
                0x1::vector::append<u8>(&mut v0, b"' fill='");
                0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(select_random_element(arg1, arg0)));
                0x1::vector::append<u8>(&mut v0, b"'/>");
                v3 = v3 + 1;
            };
            0x1::vector::append<u8>(&mut v0, b"</g>");
            v2 = v2 + 1;
        };
        0x1::vector::append<u8>(&mut v0, b"</svg>");
        v0
    }

    public fun get_base_computational_units_32x32() : u64 {
        5000
    }

    public fun get_current_gas_price(arg0: &WalletArtRegistry) : u64 {
        arg0.fee_config.current_gas_price
    }

    public fun get_fee_32x32(arg0: &FeeConfig) : u64 {
        arg0.fee_32x32
    }

    public fun get_fee_config(arg0: &WalletArtRegistry) : FeeConfig {
        arg0.fee_config
    }

    public fun get_fee_config_from_registry(arg0: &WalletArtRegistry) : &FeeConfig {
        &arg0.fee_config
    }

    public fun get_fee_values(arg0: &FeeConfig) : (u64, address, u64) {
        (arg0.fee_32x32, arg0.fee_recipient, arg0.current_gas_price)
    }

    public fun get_gas_price(arg0: &FeeConfig) : u64 {
        arg0.current_gas_price
    }

    public fun get_grid_32x32() : u64 {
        1024
    }

    public fun get_grid_size() : u64 {
        1024
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

    public fun get_price_info(arg0: &WalletArtRegistry) : (u64, u64, u64) {
        let (_, _, v2) = estimate_total_cost(arg0);
        (1024, v2, arg0.fee_config.current_gas_price)
    }

    public fun get_registry_count(arg0: &WalletArtRegistry) : u64 {
        arg0.count
    }

    fun init(arg0: MAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<MAIN>(arg0, arg1);
        let v1 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = 0x2::display::new<WalletArt>(&v0, arg1);
        0x2::display::add<WalletArt>(&mut v2, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"rNFT #{number}"));
        0x2::display::add<WalletArt>(&mut v2, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"A regenerative 32x32-pixel NFT, compiled from color codes within your Sui wallet address."));
        0x2::display::add<WalletArt>(&mut v2, 0x1::string::utf8(b"number"), 0x1::string::utf8(b"{number}"));
        0x2::display::add<WalletArt>(&mut v2, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"{data_url}"));
        0x2::display::update_version<WalletArt>(&mut v2);
        let v3 = FeeConfig{
            fee_32x32         : 5000000000,
            regeneration_fee  : 2000000000,
            fee_recipient     : 0x2::tx_context::sender(arg1),
            current_gas_price : 1,
        };
        let v4 = WalletArtRegistry{
            id         : 0x2::object::new(arg1),
            count      : 0,
            fee_config : v3,
        };
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<WalletArt>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<WalletArtRegistry>(v4);
    }

    fun push_bytes_as_u16(arg0: &vector<u8>, arg1: &mut vector<u16>) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            0x1::vector::push_back<u16>(arg1, (*0x1::vector::borrow<u8>(arg0, v0) as u16));
            v0 = v0 + 1;
        };
    }

    public entry fun regenerate_art(arg0: &mut WalletArt, arg1: &0x2::random::Random, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg3: &mut WalletArtRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 3);
        let v0 = arg3.fee_config.regeneration_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(arg2) >= v0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg2, v0, arg4), arg3.fee_config.fee_recipient);
        let v1 = 0x2::random::new_generator(arg1, arg4);
        let v2 = generate_colors_from_address(arg0.owner);
        let v3 = 0x1::string::utf8(b"data:image/svg+xml;base64,");
        if (arg0.size <= 512) {
            let v4 = &mut v1;
            0x1::string::append(&mut v3, encode_8(generate_svg_8(&v2, v4, arg0.size)));
        } else {
            let v5 = &mut v1;
            0x1::string::append(&mut v3, encode_16(generate_svg_16(&v2, v5, arg0.size)));
        };
        arg0.data_url = v3;
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

    public entry fun set_fees(arg0: &AdminCap, arg1: &mut WalletArtRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg1.fee_config.fee_recipient, 4);
        let v0 = FeeConfig{
            fee_32x32         : arg2,
            regeneration_fee  : 2000000000,
            fee_recipient     : arg1.fee_config.fee_recipient,
            current_gas_price : arg1.fee_config.current_gas_price,
        };
        arg1.fee_config = v0;
    }

    public fun set_registry_count(arg0: &AdminCap, arg1: &mut WalletArtRegistry, arg2: u64) {
        arg1.count = arg2;
    }

    public entry fun update_fees(arg0: &AdminCap, arg1: &mut WalletArtRegistry, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = FeeConfig{
            fee_32x32         : arg2,
            regeneration_fee  : 2000000000,
            fee_recipient     : arg3,
            current_gas_price : arg1.fee_config.current_gas_price,
        };
        arg1.fee_config = v0;
    }

    public entry fun update_gas_price(arg0: &AdminCap, arg1: &mut WalletArtRegistry, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_config.current_gas_price = arg2;
    }

    // decompiled from Move bytecode v6
}

