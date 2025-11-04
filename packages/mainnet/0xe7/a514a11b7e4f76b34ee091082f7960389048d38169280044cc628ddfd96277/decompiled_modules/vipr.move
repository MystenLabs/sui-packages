module 0xe7a514a11b7e4f76b34ee091082f7960389048d38169280044cc628ddfd96277::vipr {
    struct VIPR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIPR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIPR>(arg0, 6, b"VIPR", b"Viper Coin", x"4120436f696e20666f72207468652050656f706c652e2046617374205061796d656e74732c204665657320546861742050617920596f75204261636b2e204c61756e636865642061732061206d656d6520636f696e20647572696e6720646576656c6f706d656e742c20566970657220436f696e2065766f6c76657320696e746f20612066756c6c204465466920726577617264732065636f73797374656d20706f7765726564206279205669706572205661756c742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1762272781677.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VIPR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIPR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

