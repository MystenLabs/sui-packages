module 0x7b4846a5c698669073c546df3bab1c41fa47bef20b81570eb11c8b17d4ec4a4::nft_sale {
    struct NFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x1::string::String,
    }

    struct NFT_SALE has drop {
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
        free_price: u64,
        og_price: u64,
        wl_price: u64,
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

    fun init(arg0: NFT_SALE, arg1: &mut 0x2::tx_context::TxContext) {
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
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hamsterssui.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"Created by a team of hamster enthusiasts."));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"https://hamsterssui.com/"));
        0x1::vector::push_back<0x1::string::String>(v3, 0x1::string::utf8(b"0xcfd911501e23ada3e0645ada8f9ee63adbd93589091518c1680367ce7ff98535"));
        let v4 = 0x2::package::claim<NFT_SALE>(arg0, arg1);
        let v5 = 0x2::display::new_with_fields<NFT>(&v4, v0, v2, arg1);
        0x2::display::update_version<NFT>(&mut v5);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<NFT>>(v5, 0x2::tx_context::sender(arg1));
        let v6 = Collection{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"Hamsters Sui House"),
            description  : 0x1::string::utf8(b"Magic Hamster House"),
            base_url     : 0x1::string::utf8(b"ipfs://Qmamm45Xeug12LX6HvUaZmDdRiThJFHssw4CSXgEpSxiFY/"),
            total        : 5000,
            current      : 0,
            admin        : 0x2::tx_context::sender(arg1),
            free_price   : 0,
            og_price     : 1100,
            wl_price     : 1100,
            public_price : 1100,
            decimal      : 6,
        };
        0x2::transfer::share_object<Collection>(v6);
    }

    public entry fun mint_nft(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: vector<u8>, arg3: &mut Collection, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg3.current < arg3.total, 2);
        let v0 = arg3.decimal;
        if (arg2 == b"free") {
            let v1 = get_transfer_sui(arg0, arg3.free_price * arg1 * 0x2::math::pow(10, v0), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, arg3.admin);
        } else if (arg2 == b"og") {
            let v2 = get_transfer_sui(arg0, arg3.og_price * arg1 * 0x2::math::pow(10, v0), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v2, arg3.admin);
        } else if (arg2 == b"wl") {
            let v3 = get_transfer_sui(arg0, arg3.wl_price * arg1 * 0x2::math::pow(10, v0), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v3, arg3.admin);
        } else {
            let v4 = get_transfer_sui(arg0, arg3.public_price * arg1 * 0x2::math::pow(10, v0), arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v4, arg3.admin);
        };
        let v5 = 0;
        loop {
            if (v5 == arg1) {
                break
            };
            let v6 = arg3.base_url;
            0x1::string::append(&mut v6, 0x1::string::utf8(num_to_str(2)));
            0x1::string::append(&mut v6, 0x1::string::utf8(b".jpg"));
            mint_single_nft(arg3.name, arg3.description, v6, arg4);
            arg3.current = arg3.current + 1;
            v5 = v5 + 1;
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

    public entry fun reset_price(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut Collection, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg4.admin == 0x2::tx_context::sender(arg5), 1);
        arg4.free_price = arg0;
        arg4.og_price = arg1;
        arg4.wl_price = arg2;
        arg4.public_price = arg3;
    }

    public entry fun reset_total(arg0: u64, arg1: &mut Collection, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.admin == 0x2::tx_context::sender(arg2), 1);
        arg1.total = arg0;
    }

    // decompiled from Move bytecode v6
}

