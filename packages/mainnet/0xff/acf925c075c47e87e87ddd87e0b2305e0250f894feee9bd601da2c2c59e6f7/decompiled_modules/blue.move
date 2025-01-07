module 0xffacf925c075c47e87e87ddd87e0b2305e0250f894feee9bd601da2c2c59e6f7::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 6, b"BLUE", b"Blue the little Bird", x"546865206d6f737420656d626c656d617469632070657420696e20746865205355492065636f73797374656d2c20736f6f6e2065766572796f6e652077696c6c2077616e7420746f20686176652069742c2074686579206b6e6f772069742077696c6c20666c7920617761792e0a492063616e20666c792e2e2e0a492068617665206469616d6f6e642068616e6473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731496274274.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

