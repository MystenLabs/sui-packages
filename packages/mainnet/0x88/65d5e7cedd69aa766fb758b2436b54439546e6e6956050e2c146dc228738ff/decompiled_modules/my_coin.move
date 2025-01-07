module 0x8865d5e7cedd69aa766fb758b2436b54439546e6e6956050e2c146dc228738ff::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCaoHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MY_COIN>,
    }

    public entry fun mint(arg0: &mut TreasuryCaoHolder, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x7b8e0864967427679b4e129f79dc332a885c6087ec9e187b53451a9006ee15f2, 0);
        let v0 = &mut arg0.treasury_cap;
        assert!(0x2::coin::total_supply<MY_COIN>(v0) + arg2 <= 1000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(v0, arg2, arg3), arg1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 6, b"looikaizhi", b"LKZ", b"Who can let me become a memecoin!!", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        let v2 = TreasuryCaoHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_transfer<TreasuryCaoHolder>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

