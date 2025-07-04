module 0xbbbdd3064b7f202b8263cfc5e8171f8c89fe3ccd4e5ef93c6a3f5491a3699517::pepe {
    struct PEPE has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct TokenCreated has copy, drop {
        admin: address,
        total_supply: u64,
    }

    struct TokenMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokenBurned has copy, drop {
        amount: u64,
        burner: address,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: &AdminCap, arg2: 0x2::coin::Coin<PEPE>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<PEPE>(arg0, arg2);
        let v0 = TokenBurned{
            amount : 0x2::coin::value<PEPE>(&arg2),
            burner : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<TokenBurned>(v0);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPE>, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = TokenMinted{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<TokenMinted>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(arg0, arg2, arg4), arg3);
    }

    public fun get_decimals() : u8 {
        9
    }

    public fun get_name() : 0x1::string::String {
        0x1::string::utf8(b"Pepe")
    }

    public fun get_symbol() : 0x1::string::String {
        0x1::string::utf8(b"PEPE")
    }

    public fun get_total_supply() : u64 {
        4206898996535435
    }

    fun init(arg0: PEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPE>(arg0, 9, b"PEPE", b"Pepe", b"Pepe Token on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.everipedia.org/ipfs/Qmd4gRDCr8M3Rrrx1VLvZwjcJwuCem4PqojCPVMMWXjLZe")), arg1);
        let v2 = v0;
        let v3 = AdminCap{id: 0x2::object::new(arg1)};
        let v4 = 0x2::tx_context::sender(arg1);
        let v5 = TokenCreated{
            admin        : v4,
            total_supply : 4206898996535435,
        };
        0x2::event::emit<TokenCreated>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPE>>(0x2::coin::mint<PEPE>(&mut v2, 4206898996535435, arg1), v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPE>>(v2, v4);
        0x2::transfer::public_transfer<AdminCap>(v3, v4);
    }

    // decompiled from Move bytecode v6
}

