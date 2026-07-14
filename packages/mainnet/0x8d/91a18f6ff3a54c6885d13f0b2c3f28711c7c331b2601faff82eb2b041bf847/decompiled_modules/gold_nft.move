module 0x8d91a18f6ff3a54c6885d13f0b2c3f28711c7c331b2601faff82eb2b041bf847::gold_nft {
    struct GOLD_NFT has drop {
        dummy_field: bool,
    }

    struct GoldNFT has store, key {
        id: 0x2::object::UID,
        serial_code: 0x1::string::String,
        mint_date: 0x1::string::String,
        batch_no: u64,
        seq: u64,
        denomination_g: u8,
        weight_mg: u64,
        purity: 0x1::string::String,
        certificate_ref: 0x1::string::String,
        image_url: 0x1::string::String,
        minted_at_ms: u64,
    }

    public fun id(arg0: &GoldNFT) : 0x2::object::ID {
        0x2::object::id<GoldNFT>(arg0)
    }

    fun build_serial(arg0: u8, arg1: u64) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"IDNG-");
        0x1::string::append(&mut v0, u64_to_string((arg0 as u64)));
        0x1::string::append_utf8(&mut v0, b"G-");
        0x1::string::append(&mut v0, pad6(arg1));
        v0
    }

    public(friend) fun burn(arg0: GoldNFT) {
        let GoldNFT {
            id              : v0,
            serial_code     : _,
            mint_date       : _,
            batch_no        : _,
            seq             : _,
            denomination_g  : _,
            weight_mg       : _,
            purity          : _,
            certificate_ref : _,
            image_url       : _,
            minted_at_ms    : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun denomination_g(arg0: &GoldNFT) : u8 {
        arg0.denomination_g
    }

    fun image_url_for(arg0: u8) : 0x1::string::String {
        if (arg0 == 1) {
            0x1::string::utf8(b"https://nfts.idngold.com/1gram.png")
        } else if (arg0 == 2) {
            0x1::string::utf8(b"https://nfts.idngold.com/2gram.png")
        } else if (arg0 == 5) {
            0x1::string::utf8(b"https://nfts.idngold.com/5gram.png")
        } else {
            0x1::string::utf8(b"https://nfts.idngold.com/10gram.png")
        }
    }

    fun init(arg0: GOLD_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<GOLD_NFT>(arg0, arg1);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"serial"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"Gold NFT {serial_code}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"NFT emas fisik {denomination_g} gram, kemurnian {purity}. Seri {serial_code}."));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{image_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{serial_code}"));
        let v5 = 0x2::display::new_with_fields<GoldNFT>(&v0, v1, v3, arg1);
        0x2::display::update_version<GoldNFT>(&mut v5);
        let v6 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::display::Display<GoldNFT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, v6);
    }

    public fun is_valid_denomination(arg0: u8) : bool {
        if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 5) {
            true
        } else {
            arg0 == 10
        }
    }

    public(friend) fun mint(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : GoldNFT {
        assert!(is_valid_denomination(arg3), 10);
        GoldNFT{
            id              : 0x2::object::new(arg7),
            serial_code     : build_serial(arg3, arg2),
            mint_date       : arg0,
            batch_no        : arg1,
            seq             : arg2,
            denomination_g  : arg3,
            weight_mg       : (arg3 as u64) * 1000,
            purity          : arg4,
            certificate_ref : arg5,
            image_url       : image_url_for(arg3),
            minted_at_ms    : arg6,
        }
    }

    fun pad6(arg0: u64) : 0x1::string::String {
        let v0 = u64_to_string(arg0);
        while (0x1::string::length(&v0) < 6) {
            let v1 = 0x1::string::utf8(b"0");
            0x1::string::append(&mut v1, v0);
            v0 = v1;
        };
        v0
    }

    public fun serial_code(arg0: &GoldNFT) : 0x1::string::String {
        arg0.serial_code
    }

    public fun u64_to_string(arg0: u64) : 0x1::string::String {
        if (arg0 == 0) {
            return 0x1::string::utf8(b"0")
        };
        let v0 = b"";
        while (arg0 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10) as u8) + 48);
            arg0 = arg0 / 10;
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    public fun weight_mg(arg0: &GoldNFT) : u64 {
        arg0.weight_mg
    }

    // decompiled from Move bytecode v7
}

