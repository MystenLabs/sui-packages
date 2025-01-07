module 0x227479bfb5d7dff5834c6e597dcd65a70fcbb34e504b1471ab005ebe64b6a511::gameFaucet {
    struct GAMEFAUCET has drop {
        dummy_field: bool,
    }

    struct TreasuryCaoHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<GAMEFAUCET>,
    }

    public entry fun mint(arg0: &mut TreasuryCaoHolder, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GAMEFAUCET>>(0x2::coin::mint<GAMEFAUCET>(&mut arg0.treasury_cap, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    fun init(arg0: GAMEFAUCET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAMEFAUCET>(arg0, 4, b"potato89757_faucet", b"fanshuF", b"potato is fanshu yeah :3", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAMEFAUCET>>(v1);
        let v2 = TreasuryCaoHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::share_object<TreasuryCaoHolder>(v2);
    }

    // decompiled from Move bytecode v6
}

