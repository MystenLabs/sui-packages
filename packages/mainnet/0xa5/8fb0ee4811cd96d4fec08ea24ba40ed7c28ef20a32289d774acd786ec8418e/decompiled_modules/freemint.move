module 0xa58fb0ee4811cd96d4fec08ea24ba40ed7c28ef20a32289d774acd786ec8418e::freemint {
    struct Minted {
        owner: address,
        count: u64,
    }

    struct FreeMint has key {
        id: 0x2::object::UID,
        number: u64,
        max_number: u64,
        whitelist: vector<address>,
        mints: 0x2::table::Table<address, u64>,
        randoms: vector<u8>,
        creator: address,
    }

    public entry fun freemint(arg0: &mut FreeMint, arg1: &mut 0xa58fb0ee4811cd96d4fec08ea24ba40ed7c28ef20a32289d774acd786ec8418e::nft::Infomation, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &v0), 2);
        let v1 = 0;
        while (v1 < 5) {
            v1 = v1 + 1;
            assert!(arg0.number < 2000, 6);
            let v2 = 0x2::tx_context::sender(arg2);
            let v3 = 0;
            let v4 = true;
            if (0x2::table::contains<address, u64>(&arg0.mints, v2)) {
                v4 = false;
                let v5 = *0x2::table::borrow<address, u64>(&mut arg0.mints, v2);
                v3 = v5;
                assert!(v5 <= 5, 5);
            };
            let v6 = 0x1::vector::pop_back<u8>(&mut arg0.randoms) - 48;
            let v7 = b"pfp";
            if (v6 == 0) {
                v7 = b"og";
            };
            if (v6 == 5) {
                v7 = b"5";
            };
            0xa58fb0ee4811cd96d4fec08ea24ba40ed7c28ef20a32289d774acd786ec8418e::nft::mint(v7, arg1, arg2);
            arg0.number = arg0.number + 1;
            if (v4) {
                0x2::table::add<address, u64>(&mut arg0.mints, v2, v3 + 1);
                continue
            };
            0x2::table::remove<address, u64>(&mut arg0.mints, v2);
            0x2::table::add<address, u64>(&mut arg0.mints, v2, v3 + 1);
        };
    }

    public entry fun add_address_into_whitelist(arg0: &mut FreeMint, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        assert!(!0x1::vector::contains<address>(&arg0.whitelist, &arg1), 3);
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg1);
    }

    public entry fun add_whitelist(arg0: &mut FreeMint, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x1::vector::contains<address>(&arg0.whitelist, &v1)) {
                0x1::vector::push_back<address>(&mut arg0.whitelist, v1);
            };
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FreeMint{
            id         : 0x2::object::new(arg0),
            number     : 0,
            max_number : 2000,
            whitelist  : 0x1::vector::empty<address>(),
            mints      : 0x2::table::new<address, u64>(arg0),
            randoms    : b"11111111111111111111111111111111111111111111111111111111111111111111111111111101111111111111110111111111101111111111111111151115111111111111111111111111111101111111111111111111111111111111111511111111511111111511111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111111111511111111111111111111111111111511111111111111111111111111111111111111111111111115110111111111111111111111111111111111111111111111101111111111111111111011111111111111511111111111111111111111111111111111151111111111111151111111111111111111111111111111111111511111111111111111111111111111111111111111111111011115111111111111111111111111111151111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110111151111111111111111111111111111111511111151111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111011111111111111151111111111111111111111111111111111111111111111111111111111151111111111111115111110111111111111111111111111511111111111111511111111111111111111111111511111111111111111111111111111111111111111115110111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111101111011111111111111511111151111111111111111111111111111111111111111111115111111111111111111111111111111111111111511111111111101111111111111111111111111111111111111111111111111111111111111111111111111111111111115111151111111111111111110111115111111111115111111111111111111511111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111151111111111111111111111111511111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111151111111111111111111111111115111111111111111111111111111111101111111111111111111111111111111111111111111111111111111111111111111110111111111111111111111111111111111111111111011111111511111111111115111111111111111111151111111111111111111111111111111111111",
            creator    : 0x2::tx_context::sender(arg0),
        };
        0x1::vector::push_back<address>(&mut v0.whitelist, @0xbb47b7e40f8e1f7f4cd6f15bdeceaccb2afcc103396fc70456dbc2b63f647679);
        0x1::vector::push_back<address>(&mut v0.whitelist, @0xad2f84b705b26479f0a0a20d142db298308b39117bc7b0cbf44aeae6312ed5f);
        0x2::transfer::share_object<FreeMint>(v0);
    }

    public entry fun remove_address_whitelist(arg0: &mut FreeMint, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg2), 1);
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg1);
        assert!(v0, 4);
        0x1::vector::remove<address>(&mut arg0.whitelist, v1);
    }

    public entry fun reset_whitelist(arg0: &mut FreeMint, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.creator == 0x2::tx_context::sender(arg1), 1);
        0x1::vector::destroy_empty<address>(arg0.whitelist);
    }

    // decompiled from Move bytecode v6
}

