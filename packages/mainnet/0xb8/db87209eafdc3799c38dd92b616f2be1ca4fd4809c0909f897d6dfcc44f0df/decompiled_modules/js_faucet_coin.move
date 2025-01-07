module 0xb8db87209eafdc3799c38dd92b616f2be1ca4fd4809c0909f897d6dfcc44f0df::js_faucet_coin {
    struct AirdropEvent has copy, drop {
        symbol: vector<u8>,
        airdrop_amount: u64,
        recipient: address,
        total_supply: u64,
    }

    struct BurnEvent has copy, drop {
        symbol: vector<u8>,
        burn_amount: u64,
        total_supply: u64,
    }

    struct JS_FAUCET_COIN has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<JS_FAUCET_COIN>, arg1: 0x2::coin::Coin<JS_FAUCET_COIN>) {
        let v0 = BurnEvent{
            symbol       : b"JSFC",
            burn_amount  : 0x2::coin::value<JS_FAUCET_COIN>(&arg1),
            total_supply : get_total_supply(arg0),
        };
        0x2::event::emit<BurnEvent>(v0);
        0x2::coin::burn<JS_FAUCET_COIN>(arg0, arg1);
    }

    public fun airdrop(arg0: &mut 0x2::coin::TreasuryCap<JS_FAUCET_COIN>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = AirdropEvent{
            symbol         : b"JSFC",
            airdrop_amount : arg1,
            recipient      : v0,
            total_supply   : get_total_supply(arg0),
        };
        0x2::event::emit<AirdropEvent>(v1);
        0x2::coin::mint_and_transfer<JS_FAUCET_COIN>(arg0, arg1, v0, arg2);
    }

    fun get_total_supply(arg0: &0x2::coin::TreasuryCap<JS_FAUCET_COIN>) : u64 {
        0x2::balance::supply_value<JS_FAUCET_COIN>(0x2::coin::supply_immut<JS_FAUCET_COIN>(arg0))
    }

    fun init(arg0: JS_FAUCET_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JS_FAUCET_COIN>(arg0, 2, b"JSFC", b"JS Faucet Coin", b"faucet coin for JS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/964008?v=4&size=64")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JS_FAUCET_COIN>>(v1);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<JS_FAUCET_COIN>>(v0);
    }

    // decompiled from Move bytecode v6
}

