module 0xd4a294929e6cfbf30726fc3c447bee48df3dbddb686bfeacc9250aefc51e7e6b::coastal_crypto_token {
    struct COASTAL_CRYPTO_TOKEN has drop {
        dummy_field: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct TokenCreatedEvent has copy, drop {
        name: 0x1::string::String,
        symbol: 0x1::string::String,
        decimals: u8,
        max_supply: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TransferCoinEvent has copy, drop {
        from: address,
        to: address,
        amount: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        burner: address,
    }

    struct TreasuryCapTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    struct AdminCapTransferred has copy, drop {
        previous_owner: address,
        new_owner: address,
        timestamp: u64,
    }

    public entry fun burn(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<COASTAL_CRYPTO_TOKEN>, arg2: 0x2::coin::Coin<COASTAL_CRYPTO_TOKEN>, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<COASTAL_CRYPTO_TOKEN>(arg1, arg2);
        let v0 = BurnEvent{
            amount : 0x2::coin::value<COASTAL_CRYPTO_TOKEN>(&arg2),
            burner : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<BurnEvent>(v0);
    }

    public entry fun mint(arg0: &AdminCap, arg1: &mut 0x2::coin::TreasuryCap<COASTAL_CRYPTO_TOKEN>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 1);
        assert!(0x2::coin::total_supply<COASTAL_CRYPTO_TOKEN>(arg1) + arg2 <= 1000000000000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<COASTAL_CRYPTO_TOKEN>>(0x2::coin::mint<COASTAL_CRYPTO_TOKEN>(arg1, arg2, arg4), arg3);
        let v0 = MintEvent{
            amount    : arg2,
            recipient : arg3,
        };
        0x2::event::emit<MintEvent>(v0);
    }

    public fun total_supply(arg0: &0x2::coin::TreasuryCap<COASTAL_CRYPTO_TOKEN>) : u64 {
        0x2::coin::total_supply<COASTAL_CRYPTO_TOKEN>(arg0)
    }

    public entry fun transfer(arg0: 0x2::coin::Coin<COASTAL_CRYPTO_TOKEN>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (arg2 == 0x2::coin::value<COASTAL_CRYPTO_TOKEN>(&arg0)) {
            let v1 = TransferCoinEvent{
                from   : v0,
                to     : arg1,
                amount : arg2,
            };
            0x2::event::emit<TransferCoinEvent>(v1);
            0x2::transfer::public_transfer<0x2::coin::Coin<COASTAL_CRYPTO_TOKEN>>(arg0, arg1);
        } else {
            let v2 = 0x2::coin::split<COASTAL_CRYPTO_TOKEN>(&mut arg0, arg2, arg3);
            let v3 = TransferCoinEvent{
                from   : v0,
                to     : arg1,
                amount : 0x2::coin::value<COASTAL_CRYPTO_TOKEN>(&v2),
            };
            0x2::event::emit<TransferCoinEvent>(v3);
            0x2::transfer::public_transfer<0x2::coin::Coin<COASTAL_CRYPTO_TOKEN>>(v2, arg1);
            let v4 = TransferCoinEvent{
                from   : v0,
                to     : v0,
                amount : 0x2::coin::value<COASTAL_CRYPTO_TOKEN>(&arg0),
            };
            0x2::event::emit<TransferCoinEvent>(v4);
            0x2::transfer::public_transfer<0x2::coin::Coin<COASTAL_CRYPTO_TOKEN>>(arg0, v0);
        };
    }

    public fun balance_of(arg0: &0x2::balance::Balance<COASTAL_CRYPTO_TOKEN>) : u64 {
        0x2::balance::value<COASTAL_CRYPTO_TOKEN>(arg0)
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: COASTAL_CRYPTO_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COASTAL_CRYPTO_TOKEN>(arg0, 9, b"CCT", b"COASTAL CRYPTO TOKEN", b"Where the liquidity of the ocean meets the safety and security of the land", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://scarlet-visual-gopher-984.mypinata.cloud/ipfs/bafybeie5whghfxteehmbfxee3gaixjiare6gprjwwrgstzf4i3lodiqhie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COASTAL_CRYPTO_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COASTAL_CRYPTO_TOKEN>>(v1);
        let v2 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = TokenCreatedEvent{
            name       : 0x1::string::utf8(b"COASTAL CRYPTO TOKEN"),
            symbol     : 0x1::string::utf8(b"CCT"),
            decimals   : 9,
            max_supply : 1000000000000000000,
        };
        0x2::event::emit<TokenCreatedEvent>(v3);
    }

    public fun max_supply() : u64 {
        1000000000000000000
    }

    public fun name() : 0x1::string::String {
        0x1::string::utf8(b"COASTAL CRYPTO TOKEN")
    }

    public fun symbol() : 0x1::string::String {
        0x1::string::utf8(b"CCT")
    }

    public entry fun transfer_admin_cap(arg0: AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCapTransferred{
            previous_owner : 0x2::tx_context::sender(arg2),
            new_owner      : arg1,
            timestamp      : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<AdminCapTransferred>(v0);
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public entry fun transfer_treasury_cap(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<COASTAL_CRYPTO_TOKEN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = TreasuryCapTransferred{
            previous_owner : 0x2::tx_context::sender(arg3),
            new_owner      : arg2,
            timestamp      : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<TreasuryCapTransferred>(v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COASTAL_CRYPTO_TOKEN>>(arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

