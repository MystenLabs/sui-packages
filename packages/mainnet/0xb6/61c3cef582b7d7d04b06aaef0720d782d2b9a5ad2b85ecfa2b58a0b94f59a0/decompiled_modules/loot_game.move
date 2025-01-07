module 0xb661c3cef582b7d7d04b06aaef0720d782d2b9a5ad2b85ecfa2b58a0b94f59a0::loot_game {
    struct LOOT_GAME has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        traits: vector<0x1::string::String>,
        point: u64,
        no: u64,
    }

    struct EventNFTMinted has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        no: u64,
    }

    struct EventGameOutCome has copy, drop {
        object_id: 0x2::object::ID,
        player_val: u64,
        machine_val: u64,
        outcome: 0x1::string::String,
    }

    public fun transfer(arg0: LOOT_GAME, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<LOOT_GAME>(arg0, arg1);
    }

    public fun url(arg0: &LOOT_GAME) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun mint(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = LOOT_GAME{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"Log2"),
            description : 0x1::string::utf8(b"Player Card NFT for Loot Game"),
            url         : 0x2::url::new_unsafe_from_bytes(b""),
            traits      : 0x1::vector::empty<0x1::string::String>(),
            point       : 0,
            no          : 0,
        };
        let v2 = &mut v1;
        random_nft(v2, arg0);
        let v3 = EventNFTMinted{
            object_id : 0x2::object::id<LOOT_GAME>(&v1),
            creator   : v0,
            no        : v1.no,
        };
        0x2::event::emit<EventNFTMinted>(v3);
        0x2::transfer::public_transfer<LOOT_GAME>(v1, v0);
    }

    public entry fun battle(arg0: &mut 0x2::coin::TreasuryCap<0x52d69241b3ded4f1455dd7163814ac4472e589da7641764892f918f6f167f03::mulander_faucet::MULANDER_FAUCET>, arg1: &mut LOOT_GAME, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::string::utf8(b"Draw");
        let v1 = get_random_range(arg2, 100);
        if (v1 < arg1.no) {
            v0 = 0x1::string::utf8(b"You win");
            arg1.point = arg1.point + 1;
            0x52d69241b3ded4f1455dd7163814ac4472e589da7641764892f918f6f167f03::mulander_faucet::mint(arg0, 10000000, 0x2::tx_context::sender(arg3), arg3);
        } else if (v1 > arg1.no) {
            v0 = 0x1::string::utf8(b"You lose");
            if (arg1.point > 0) {
                arg1.point = arg1.point - 1;
            };
            0x52d69241b3ded4f1455dd7163814ac4472e589da7641764892f918f6f167f03::mulander_faucet::mint(arg0, 5000000, 0x2::tx_context::sender(arg3), arg3);
        };
        let v2 = EventGameOutCome{
            object_id   : 0x2::object::id<LOOT_GAME>(arg1),
            player_val  : arg1.no,
            machine_val : v1,
            outcome     : v0,
        };
        0x2::event::emit<EventGameOutCome>(v2);
    }

    public fun burn(arg0: LOOT_GAME, arg1: &mut 0x2::tx_context::TxContext) {
        let LOOT_GAME {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            traits      : _,
            point       : _,
            no          : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun description(arg0: &LOOT_GAME) : &0x1::string::String {
        &arg0.description
    }

    fun get_random_range(arg0: &0x2::clock::Clock, arg1: u64) : u64 {
        ((0x2::clock::timestamp_ms(arg0) % arg1) as u64)
    }

    public entry fun magic_finger(arg0: &mut LOOT_GAME, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        random_nft(arg0, arg1);
    }

    public fun name(arg0: &LOOT_GAME) : &0x1::string::String {
        &arg0.name
    }

    public fun no(arg0: &LOOT_GAME) : &u64 {
        &arg0.no
    }

    public fun point(arg0: &LOOT_GAME) : &u64 {
        &arg0.point
    }

    fun random_nft(arg0: &mut LOOT_GAME, arg1: &0x2::clock::Clock) {
        let v0 = trait3();
        let v1 = trait2();
        let v2 = trait1();
        let v3 = 0x1::vector::length<0x1::string::String>(&v1);
        let v4 = 0x1::vector::length<0x1::string::String>(&v0);
        let v5 = get_random_range(arg1, 0x1::vector::length<0x1::string::String>(&v2));
        let v6 = get_random_range(arg1, v3);
        let v7 = get_random_range(arg1, v4);
        arg0.no = v5 * v3 * v4 + v6 * v4 + v7 + 1;
        let v8 = 0x1::vector::empty<0x1::string::String>();
        let v9 = &mut v8;
        0x1::vector::push_back<0x1::string::String>(v9, *0x1::vector::borrow<0x1::string::String>(&v2, v5));
        0x1::vector::push_back<0x1::string::String>(v9, *0x1::vector::borrow<0x1::string::String>(&v1, v6));
        0x1::vector::push_back<0x1::string::String>(v9, *0x1::vector::borrow<0x1::string::String>(&v0, v7));
        arg0.traits = v8;
        let v10 = 0x1::vector::empty<0x1::string::String>();
        let v11 = &mut v10;
        0x1::vector::push_back<0x1::string::String>(v11, *0x1::vector::borrow<0x1::string::String>(&v2, v5));
        0x1::vector::push_back<0x1::string::String>(v11, *0x1::vector::borrow<0x1::string::String>(&v1, v6));
        0x1::vector::push_back<0x1::string::String>(v11, *0x1::vector::borrow<0x1::string::String>(&v0, v7));
        0x1::vector::push_back<0x1::string::String>(v11, 0x1::string::utf8(b"Made by @Mulander-J"));
        arg0.url = svg_url(&v10);
        0x1::debug::print<0x2::url::Url>(&arg0.url);
    }

    fun svg_url(arg0: &vector<0x1::string::String>) : 0x2::url::Url {
        let v0 = 0x1::string::utf8(b"data:image/svg+xml;charset=utf8,%3Csvg xmlns='http://www.w3.org/2000/svg' preserveAspectRatio='xMinYMin meet' viewBox='0 0 350 350'%3E%3Cstyle%3E.base { fill: white; font-family: serif; font-size: 14px; }%3C/style%3E%3Crect width='100%' height='100%' fill='black'/%3E");
        let v1 = 0;
        loop {
            if (v1 >= 0x1::vector::length<0x1::string::String>(arg0)) {
                break
            };
            let v2 = 0x1::string::utf8(b"%3Ctext x='10' y='");
            0x1::string::append(&mut v2, uint_to_string(((20 * (v1 + 1)) as u256)));
            0x1::string::append(&mut v2, 0x1::string::utf8(b"' class='base'%3E"));
            0x1::string::append(&mut v2, *0x1::vector::borrow<0x1::string::String>(arg0, v1));
            0x1::string::append(&mut v2, 0x1::string::utf8(b"%3C/text%3E"));
            0x1::string::append(&mut v0, v2);
            v1 = v1 + 1;
        };
        0x1::string::append(&mut v0, 0x1::string::utf8(b"%3C/svg%3E"));
        0x2::url::new_unsafe_from_bytes(*0x1::string::bytes(&v0))
    }

    fun trait1() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Aristotle"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Beethoven"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Einstein"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Leonardo"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Shakespeare"));
        v0
    }

    fun trait2() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Metal"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Wood"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Water"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Fire"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Earth"));
        v0
    }

    fun trait3() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        let v1 = &mut v0;
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Iron"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Gold"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Platinum"));
        0x1::vector::push_back<0x1::string::String>(v1, 0x1::string::utf8(b"Diamond"));
        v0
    }

    public fun traits(arg0: &LOOT_GAME) : &vector<0x1::string::String> {
        &arg0.traits
    }

    fun uint_to_string(arg0: u256) : 0x1::string::String {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 10;
        loop {
            let v2 = arg0 / v1;
            if (v1 == 10) {
                0x1::vector::push_back<u8>(&mut v0, ((48 + arg0 % 10) as u8));
            };
            if (v2 <= 0) {
                break
            };
            v1 = v1 * v1;
            0x1::vector::push_back<u8>(&mut v0, ((48 + v2 % 10) as u8));
        };
        0x1::vector::reverse<u8>(&mut v0);
        0x1::string::utf8(v0)
    }

    // decompiled from Move bytecode v6
}

