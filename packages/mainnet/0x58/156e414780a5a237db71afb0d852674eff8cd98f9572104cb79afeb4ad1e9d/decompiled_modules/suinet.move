module 0x58156e414780a5a237db71afb0d852674eff8cd98f9572104cb79afeb4ad1e9d::suinet {
    struct MintConfig has key {
        id: 0x2::object::UID,
        owner: address,
        minted: u64,
        base_name: 0x1::string::String,
    }

    struct SUITOMAINNET has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
    }

    struct SUINET has drop {
        dummy_field: bool,
    }

    public entry fun free_mint(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        mint(arg0, arg1, arg2);
    }

    fun init(arg0: SUINET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"link"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"description"));
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = &mut v2;
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suinet.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://nftstorage.link/ipfs/bafkreibhntznnakdl47jybmlke5g7vl7dkxggu5tngxf775afrjd4nxlpy"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"This ticket allows you to tranfer SUI from tesnet to mainnet."));
        let v4 = 0x2::package::claim<SUINET>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<SUITOMAINNET>(&v4, v0, v2, arg1);
        0x2::display::update_version<SUITOMAINNET>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SUITOMAINNET>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = MintConfig{
            id        : 0x2::object::new(arg1),
            owner     : 0x2::tx_context::sender(arg1),
            minted    : 0,
            base_name : 0x1::string::utf8(b"Testnet to Mainnet Pass #"),
        };
        0x2::transfer::share_object<MintConfig>(v6);
    }

    fun mint(arg0: &mut MintConfig, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.base_name;
        0x1::string::append(&mut v0, num_str(arg0.minted + 1));
        let v1 = SUITOMAINNET{
            id   : 0x2::object::new(arg2),
            name : v0,
        };
        0x2::transfer::transfer<SUITOMAINNET>(v1, arg1);
        arg0.minted = arg0.minted + 1;
    }

    fun num_str(arg0: u64) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        while (arg0 / 10 > 0) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
        };
        0x1::vector::push_back<u8>(&mut v0, ((arg0 + 48) as u8));
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

