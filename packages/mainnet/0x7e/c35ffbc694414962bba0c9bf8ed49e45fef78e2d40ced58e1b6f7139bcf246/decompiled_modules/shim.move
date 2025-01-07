module 0x7ec35ffbc694414962bba0c9bf8ed49e45fef78e2d40ced58e1b6f7139bcf246::shim {
    struct SHIM has drop {
        dummy_field: bool,
    }

    struct Token has store, key {
        id: 0x2::object::UID,
        total_supply: u64,
        max_supply: u64,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SHIM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::total_supply<SHIM>(arg0) + arg1 <= 20000000000, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<SHIM>>(0x2::coin::mint<SHIM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SHIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIM>(arg0, 9, b"SHIMTest2", b"Shima Enaga Test2", b"The original Proof of Spam coin", 0x1::option::some<0x2::url::Url>(0x7ec35ffbc694414962bba0c9bf8ed49e45fef78e2d40ced58e1b6f7139bcf246::icon::get_icon_url()), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIM>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = Token{
            id           : 0x2::object::new(arg1),
            total_supply : 0,
            max_supply   : 20000000000,
        };
        0x2::transfer::public_transfer<Token>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

