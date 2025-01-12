module 0xbbfef639b774fd39fecd5cd4eb5be9c2849aa2534c295885acccfc6911d830ab::aqua {
    struct AQUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUA>(arg0, 6, b"AQUA", b"Aqua", x"4c657427732074686520776176657320626567696e0a0a4171756120436f696e206973206120706c617966756c2c20636f6d6d756e6974792d64726976656e2063727970746f63757272656e637920696e737069726564206279207468652070757269747920616e6420666c6f77206f662077617465722e20526570726573656e746564206279206120636865657266756c2064726f706c6574206d6173636f742c2069742073796d626f6c697a6573207375737461696e6162696c6974792c2061646170746162696c6974792c20616e64206120636f6d6d69746d656e7420746f2066756e20696e6e6f766174696f6e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736671553119.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AQUA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

