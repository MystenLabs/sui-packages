module 0xdb9f34b220e76e333553dc4c4bc6f3110d5c103b60316562eeab34b1fa902349::suiversary {
    struct Suiversary has store, key {
        id: 0x2::object::UID,
        coin: 0x2::coin::Coin<0x2::sui::SUI>,
        number: u8,
        minted_timestamp: u64,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        supply: u8,
        pow_supply: u8,
    }

    struct SuiversaryMintedEvent has copy, drop, store {
        nft_id: 0x2::object::ID,
        coin_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    struct SuiversaryBurnedEvent has copy, drop {
        number: u8,
        sender: address,
    }

    struct SUIVERSARY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: Suiversary, arg1: &mut 0x2::tx_context::TxContext) {
        let Suiversary {
            id               : v0,
            coin             : v1,
            number           : v2,
            minted_timestamp : _,
        } = arg0;
        let v4 = SuiversaryBurnedEvent{
            number : v2,
            sender : 0x2::tx_context::sender(arg1),
        };
        0x2::event::emit<SuiversaryBurnedEvent>(v4);
        0x2::object::delete(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    fun init(arg0: SUIVERSARY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::package::claim<SUIVERSARY>(arg0, arg1);
        let v1 = 0x2::display::new<Suiversary>(&v0, arg1);
        0x2::display::add<Suiversary>(&mut v1, 0x1::string::utf8(b"name"), 0x1::string::utf8(b"Suiversary #{number}"));
        0x2::display::add<Suiversary>(&mut v1, 0x1::string::utf8(b"description"), 0x1::string::utf8(b"One year and counting.."));
        0x2::display::add<Suiversary>(&mut v1, 0x1::string::utf8(b"image_url"), 0x1::string::utf8(b"ipfs://bafkreifirsanoskhxukfjqttt7rylthzmwa766xdanrkzl52zz6mslksya"));
        0x2::transfer::public_transfer<0x2::display::Display<Suiversary>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::package::Publisher>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Registry{
            id         : 0x2::object::new(arg1),
            supply     : 0,
            pow_supply : 0,
        };
        0x2::transfer::share_object<Registry>(v2);
    }

    public fun mint(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.supply < 10, 0);
        arg0.supply = arg0.supply + 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 1);
        let v0 = Suiversary{
            id               : 0x2::object::new(arg3),
            coin             : arg1,
            number           : arg0.supply + arg0.pow_supply,
            minted_timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        let v1 = SuiversaryMintedEvent{
            nft_id    : 0x2::object::id<Suiversary>(&v0),
            coin_id   : 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg1),
            sender    : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<SuiversaryMintedEvent>(v1);
        0x2::transfer::transfer<Suiversary>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun mint_pow(arg0: &mut Registry, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.supply == 10, 1);
        assert!(arg0.pow_supply < 100, 2);
        arg0.pow_supply = arg0.pow_supply + 1;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) == 1000000000, 3);
        let v0 = 0x2::object::id<0x2::coin::Coin<0x2::sui::SUI>>(&arg1);
        proof(&v0);
        let v1 = Suiversary{
            id               : 0x2::object::new(arg3),
            coin             : arg1,
            number           : arg0.supply + arg0.pow_supply,
            minted_timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        let v2 = SuiversaryMintedEvent{
            nft_id    : 0x2::object::id<Suiversary>(&v1),
            coin_id   : v0,
            sender    : 0x2::tx_context::sender(arg3),
            timestamp : 0x2::clock::timestamp_ms(arg2) / 1000,
        };
        0x2::event::emit<SuiversaryMintedEvent>(v2);
        0x2::transfer::transfer<Suiversary>(v1, 0x2::tx_context::sender(arg3));
    }

    fun proof(arg0: &0x2::object::ID) {
        let v0 = 0x2::address::to_string(0x2::object::id_to_address(arg0));
        assert!(0x1::string::utf8(b"0000") == 0x1::string::sub_string(&v0, 0, 4), 0);
    }

    // decompiled from Move bytecode v6
}

