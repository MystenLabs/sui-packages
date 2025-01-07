module 0xec94a3d4677090a10dde0162f1e627e867ed7bcc089d32ddafff1fd05e60894d::aquasium {
    struct AQUASIUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUASIUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUASIUM>(arg0, 6, b"AQUASIUM", b"$AQUASIUM", x"57656c636f6d6520746f2024415155415349554d2c20746865207669727475616c20776f726c64206f6620666973682077697468696e20746865205355492065636f73797374656d210a24415155415349554d206f6666657273206120756e6971756520657870657269656e636520776865726520636f6c6c6563746f727320616e64206669736820656e7468757369617374732063616e206361726520666f7220616e6420636f6c6c656374206469676974616c206669736820696e2061207669727475616c20617175617269756d206275696c74206f6e207468652053554920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_40e146e535.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUASIUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUASIUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

