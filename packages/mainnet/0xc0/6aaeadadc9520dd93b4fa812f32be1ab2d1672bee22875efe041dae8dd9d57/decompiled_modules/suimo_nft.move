module 0xc06aaeadadc9520dd93b4fa812f32be1ab2d1672bee22875efe041dae8dd9d57::suimo_nft {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct SUIMO_NFT has drop {
        dummy_field: bool,
    }

    struct Collection has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        base_url: 0x1::string::String,
        total: u64,
        current: u64,
        admin: address,
        public_price: u64,
        decimal: u8,
    }

    public fun get_transfer_sui(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == arg1) {
            return arg0
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<0x2::sui::SUI>(&mut arg0, arg1, arg2)
    }

    fun init(arg0: SUIMO_NFT, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://suimo.xyz"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Secret Pass SuiMo"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://twitter.com/SuiMo_NFT"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"SuiMo"));
        let v4 = 0x2::package::claim<SUIMO_NFT>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Collection{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"Secret Pass SuiMo"),
            description  : 0x1::string::utf8(b"Secret pass for SuiMO"),
            base_url     : 0x1::string::utf8(b"ipfs://QmT9WwEM4PkWWnrFtNGfLtBwVd5do2CKKoZbzjNVJn887F/"),
            total        : 333,
            current      : 0,
            admin        : 0x2::tx_context::sender(arg1),
            public_price : 3330,
            decimal      : 5,
        };
        0x2::transfer::share_object<Collection>(v6);
    }

    public entry fun mint_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: vector<u8>, arg3: &mut Collection, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.current < arg3.total, 2);
        let v0 = get_transfer_sui(arg0, arg3.public_price * arg1 * 0x2::math::pow(10, arg3.decimal), arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, arg3.admin);
        let v1 = arg3.name;
        let v2 = 0;
        loop {
            if (v2 == arg1) {
                break
            };
            let v3 = arg3.base_url;
            0x1::string::append(&mut v3, 0x1::string::utf8(num_to_str(1)));
            0x1::string::append(&mut v3, 0x1::string::utf8(b".gif"));
            0x1::string::append_utf8(&mut v1, b" #");
            0x1::string::append(&mut v1, 0x1::string::utf8(num_to_str(arg3.current + 1)));
            mint_single_nft(v1, arg3.description, v3, arg4);
            arg3.current = arg3.current + 1;
            v2 = v2 + 1;
        };
    }

    public fun mint_single_nft(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT{
            id          : 0x2::object::new(arg3),
            name        : arg0,
            description : arg1,
            img_url     : arg2,
        };
        0x2::transfer::public_transfer<NFT>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun num_to_str(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        loop {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 % 10 + 48) as u8));
            arg0 = arg0 / 10;
            if (arg0 == 0) {
                break
            };
        };
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public entry fun reset_admin(arg0: address, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.admin = arg0;
    }

    public entry fun reset_basic_info(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: &mut Collection, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.admin == 0x2::tx_context::sender(arg4), 1);
        arg3.name = 0x1::string::utf8(arg0);
        arg3.description = 0x1::string::utf8(arg1);
        arg3.base_url = 0x1::string::utf8(arg2);
    }

    public entry fun reset_decimal(arg0: u8, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.decimal = arg0;
    }

    public entry fun reset_price(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.public_price = arg0;
    }

    public entry fun reset_total(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.total = arg0;
    }

    // decompiled from Move bytecode v6
}

