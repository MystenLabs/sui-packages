module 0x52ef14dc8862eb429b0e04b388ef38ef9020cd031a895244b132fd6d105cd32e::my_coin {
    struct MY_COIN has drop {
        dummy_field: bool,
    }

    struct TreasuryCapHolder has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<MY_COIN>,
    }

    public entry fun mint(arg0: &mut TreasuryCapHolder, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == @0x7b8e0864967427679b4e129f79dc332a885c6087ec9e187b53451a9006ee15f2, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<MY_COIN>>(0x2::coin::mint<MY_COIN>(&mut arg0.treasury_cap, arg2, arg3), arg1);
    }

    fun init(arg0: MY_COIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY_COIN>(arg0, 4, b"potato89757", b"fanshu", b"potato is fanshu", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY_COIN>>(v1);
        let v2 = TreasuryCapHolder{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_transfer<TreasuryCapHolder>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

