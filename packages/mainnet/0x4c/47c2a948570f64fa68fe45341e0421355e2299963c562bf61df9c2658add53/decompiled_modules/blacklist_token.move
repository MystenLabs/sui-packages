module 0x4c47c2a948570f64fa68fe45341e0421355e2299963c562bf61df9c2658add53::blacklist_token {
    struct COOL_TOKEN_WITNESS has drop {
        dummy_field: bool,
    }

    struct TokenMetadata has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        total_supply: u64,
    }

    struct Blacklist has store, key {
        id: 0x2::object::UID,
        blacklisted_addresses: 0x2::vec_set::VecSet<address>,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        package_owner: address,
    }

    struct TokenCreated has copy, drop {
        creator: address,
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        total_supply: u64,
    }

    struct Blacklisted has copy, drop {
        address: address,
        reason: 0x1::string::String,
    }

    struct Unblacklisted has copy, drop {
        address: address,
    }

    public entry fun burn(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<COOL_TOKEN_WITNESS>, arg2: 0x2::coin::Coin<COOL_TOKEN_WITNESS>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<COOL_TOKEN_WITNESS>(arg1, arg2);
    }

    public entry fun create_rest(arg0: &mut 0x2::coin::TreasuryCap<COOL_TOKEN_WITNESS>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 1000000;
        0x2::transfer::public_transfer<0x2::coin::Coin<COOL_TOKEN_WITNESS>>(0x2::coin::mint<COOL_TOKEN_WITNESS>(arg0, v1, arg1), v0);
        let v2 = TokenMetadata{
            id           : 0x2::object::new(arg1),
            name         : 0x1::string::utf8(b"CoolToken"),
            symbol       : 0x1::string::utf8(b"COOL"),
            decimals     : 6,
            total_supply : v1,
        };
        let v3 = Blacklist{
            id                    : 0x2::object::new(arg1),
            blacklisted_addresses : 0x2::vec_set::empty<address>(),
        };
        let v4 = AdminCap{
            id            : 0x2::object::new(arg1),
            package_owner : v0,
        };
        0x2::transfer::transfer<TokenMetadata>(v2, v0);
        0x2::transfer::transfer<Blacklist>(v3, v0);
        0x2::transfer::transfer<AdminCap>(v4, v0);
        let v5 = TokenCreated{
            creator      : v0,
            name         : 0x1::string::utf8(b"CoolToken"),
            symbol       : 0x1::string::utf8(b"COOL"),
            total_supply : v1,
        };
        0x2::event::emit<TokenCreated>(v5);
    }

    public entry fun create_treasury_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = COOL_TOKEN_WITNESS{dummy_field: false};
        let (v2, v3) = 0x2::coin::create_currency<COOL_TOKEN_WITNESS>(v1, 6, b"COOL", b"CoolToken", b"A cool token with blacklisting", 0x1::option::none<0x2::url::Url>(), arg0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COOL_TOKEN_WITNESS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<COOL_TOKEN_WITNESS>>(v3, v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_blacklisted(arg0: &Blacklist, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.blacklisted_addresses, &arg1)
    }

    public entry fun remove_from_blacklist(arg0: &AdminCap, arg1: &mut Blacklist, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (0x2::vec_set::contains<address>(&arg1.blacklisted_addresses, &arg2)) {
            0x2::vec_set::remove<address>(&mut arg1.blacklisted_addresses, &arg2);
            let v0 = Unblacklisted{address: arg2};
            0x2::event::emit<Unblacklisted>(v0);
        };
    }

    public entry fun safe_transfer(arg0: &mut 0x2::coin::Coin<COOL_TOKEN_WITNESS>, arg1: u64, arg2: address, arg3: &mut Blacklist, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1 > 0, 5);
        assert!(0x2::coin::value<COOL_TOKEN_WITNESS>(arg0) >= arg1, 3);
        assert!(!0x2::vec_set::contains<address>(&arg3.blacklisted_addresses, &v0), 1);
        assert!(!0x2::vec_set::contains<address>(&arg3.blacklisted_addresses, &arg2), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<COOL_TOKEN_WITNESS>>(0x2::coin::split<COOL_TOKEN_WITNESS>(arg0, arg1, arg4), arg2);
        0x2::vec_set::insert<address>(&mut arg3.blacklisted_addresses, arg2);
        let v1 = Blacklisted{
            address : arg2,
            reason  : 0x1::string::utf8(b"Received token via safe_transfer"),
        };
        0x2::event::emit<Blacklisted>(v1);
    }

    public fun total_supply(arg0: &TokenMetadata) : u64 {
        arg0.total_supply
    }

    public entry fun transfer_and_blacklist(arg0: 0x2::coin::Coin<COOL_TOKEN_WITNESS>, arg1: address, arg2: &mut Blacklist, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_set::contains<address>(&arg2.blacklisted_addresses, &v0), 1);
        assert!(!0x2::vec_set::contains<address>(&arg2.blacklisted_addresses, &arg1), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<COOL_TOKEN_WITNESS>>(arg0, arg1);
        0x2::vec_set::insert<address>(&mut arg2.blacklisted_addresses, arg1);
        let v1 = Blacklisted{
            address : arg1,
            reason  : 0x1::string::utf8(b"Received token"),
        };
        0x2::event::emit<Blacklisted>(v1);
    }

    // decompiled from Move bytecode v6
}

