module 0x9c31419823ffc622c1aae9e66065c057e5ccdaa04aaeacde8dbf440af75f0bcf::squidsquids {
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
        let (v0, v1) = 0x2::coin::create_currency<SQUIDSQUIDS>(arg0, 6, b"SQSQ", b"SQUIDSQUIDS", b"A Rogue Squid accidently Inked the prestine SUI code", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imghippo.com/files/zcWw7285rM.png")), arg1);
        let v2 = v0;
        let v3 = TokenTreasuryCap{
            id       : 0x2::object::new(arg1),
            cap      : v2,
            metadata : v1,
        };
        0x2::transfer::transfer<TokenTreasuryCap>(v3, @0xd3182da9d0fd0466f8aac23aaf22636ab388542952a9274dd30e12778e3f6764);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDSQUIDS>>(0x2::coin::mint<SQUIDSQUIDS>(&mut v2, 3000000000000 * 1000000, arg1), @0xd3182da9d0fd0466f8aac23aaf22636ab388542952a9274dd30e12778e3f6764);
    }

    public entry fun transfer_with_tax(arg0: &mut 0x2::coin::Coin<SQUIDSQUIDS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 1);
        assert!(0x2::coin::value<SQUIDSQUIDS>(arg0) >= arg1, 0);
        let v0 = arg1 * 3 / 100;
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDSQUIDS>>(0x2::coin::split<SQUIDSQUIDS>(arg0, v0, arg3), @0xd3182da9d0fd0466f8aac23aaf22636ab388542952a9274dd30e12778e3f6764);
        0x2::transfer::public_transfer<0x2::coin::Coin<SQUIDSQUIDS>>(0x2::coin::split<SQUIDSQUIDS>(arg0, arg1 - v0, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

