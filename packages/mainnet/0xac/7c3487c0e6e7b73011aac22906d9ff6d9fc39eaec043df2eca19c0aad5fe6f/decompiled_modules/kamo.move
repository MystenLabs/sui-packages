module 0xac7c3487c0e6e7b73011aac22906d9ff6d9fc39eaec043df2eca19c0aad5fe6f::kamo {
    struct KAMO has drop {
        dummy_field: bool,
    }

    struct KamoTreasuryCap has key {
        id: 0x2::object::UID,
        cap: 0x2::coin::TreasuryCap<KAMO>,
    }

    struct TokensMinted has copy, drop {
        amount: u64,
        recipient: address,
    }

    struct TokensBurned has copy, drop {
        amount: u64,
        burner: address,
    }

    public fun burn(arg0: &mut KamoTreasuryCap, arg1: 0x2::coin::Coin<KAMO>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::burn<KAMO>(&mut arg0.cap, arg1);
        let v0 = TokensBurned{
            amount : 0x2::coin::value<KAMO>(&arg1),
            burner : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<TokensBurned>(v0);
    }

    public(friend) fun mint(arg0: &mut KamoTreasuryCap, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<KAMO>>(0x2::coin::mint<KAMO>(&mut arg0.cap, arg1, arg3), arg2);
        let v0 = TokensMinted{
            amount    : arg1,
            recipient : arg2,
        };
        0x2::event::emit<TokensMinted>(v0);
    }

    public fun decimals() : u8 {
        9
    }

    fun init(arg0: KAMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAMO>(arg0, 9, b"KAMO", b"Kamo Token", b"Governance token for Kamo protocol", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAMO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<KAMO>>(0x2::coin::mint<KAMO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        let v3 = KamoTreasuryCap{
            id  : 0x2::object::new(arg1),
            cap : v2,
        };
        0x2::transfer::share_object<KamoTreasuryCap>(v3);
    }

    public fun initial_supply() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v6
}

