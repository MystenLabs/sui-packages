module 0x88c85a9febf512857b73349c4db942805884d8b160032ad0dbd6632213ea9d7b::gameFaucet {
    struct GAMEFAUCET has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<GAMEFAUCET>,
    }

    public entry fun mint(arg0: &mut TreasuryCapHolder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GAMEFAUCET>>(0x2::coin::mint<GAMEFAUCET>(&mut arg0.treasury_cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: GAMEFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMEFAUCET>(arg0, 6, b"potato89757_faucet", b"fanshuF", b"potato is fanshu yeah :3", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMEFAUCET>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCapHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

