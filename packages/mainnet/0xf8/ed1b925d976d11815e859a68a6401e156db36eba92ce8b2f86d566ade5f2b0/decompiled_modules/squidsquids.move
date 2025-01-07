module 0xf8ed1b925d976d11815e859a68a6401e156db36eba92ce8b2f86d566ade5f2b0::squidsquids {
    struct SQUIDSQUIDS has drop {
        dummy_field: bool,
    }

    struct TokenTreasuryCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<SQUIDSQUIDS>,
        metadata: 0x2::coin::CoinMetadata<SQUIDSQUIDS>,
    }

    public fun get_decimals() : u64 {
        6
    }

    public fun get_description() : 0x1::string::String {
        0x1::string::utf8(b"A Rogue Squid accidently Inked the prestine SUI code")
    }

    public fun get_metadata(arg0: &TokenTreasuryCap) : &0x2::coin::CoinMetadata<SQUIDSQUIDS> {
        &arg0.metadata
    }

    public fun get_name() : 0x1::string::String {
        0x1::string::utf8(b"SQUIDSQUIDS")
    }

    public fun get_symbol() : 0x1::string::String {
        0x1::string::utf8(b"SQSQ")
    }

    public fun get_tax_rate() : u64 {
        3
    }

    public fun get_total_supply() : u64 {
        3000000000000 * 1000000
    }

    fun init(arg0: SQUIDSQUIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDSQUIDS>(arg0, 6, b"SQSQ", b"SQUIDSQUIDS", b"A Rogue Squid accidently Inked the prestine SUI code", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/squidsuids/token/main/logo.png")), arg1);
        let v2 = v0;
        let v3 = TokenTreasuryCap{
            id       : 0x2::object::new(arg1),
            cap      : v2,
            metadata : v1,
        };
        0x2::transfer::transfer<TokenTreasuryCap>(v3, @0x52071f157f0d228670ab4b0422b88d46c293957ac5ecb5145024d978afbbb5ec);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDSQUIDS>>(0x2::coin::mint<SQUIDSQUIDS>(&mut v2, 3000000000000 * 1000000, arg1), @0x52071f157f0d228670ab4b0422b88d46c293957ac5ecb5145024d978afbbb5ec);
    }

    public entry fun transfer_with_tax(arg0: &mut 0x2::coin::Coin<SQUIDSQUIDS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<SQUIDSQUIDS>(arg0) >= arg1, 0);
        let v0 = arg1 * 3 / 100;
        let v1 = arg1 - v0;
        0xf8ed1b925d976d11815e859a68a6401e156db36eba92ce8b2f86d566ade5f2b0::events::emit_transfer_event(0x2::tx_context::sender(arg3), arg2, v1, v0, 0x2::tx_context::epoch(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDSQUIDS>>(0x2::coin::split<SQUIDSQUIDS>(arg0, v0, arg3), @0xc54442eea10f27fd9970329797130d2ef96afc135ca4a5d903e022e9a634b0fe);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDSQUIDS>>(0x2::coin::split<SQUIDSQUIDS>(arg0, v1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

