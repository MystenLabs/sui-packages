module 0xd582f2f7ce1860b34a1351ca61613b5614e405e645005fdc891c310ce3336efb::salmond {
    struct SALMOND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SALMOND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SALMOND>(arg0, 6, b"Salmond", b"Spicy Almond", x"537069637920416c6d6f6e64206973204a75737420707261637469636520746f206d616b6520612070726f666974696e67204d656d65636f696e20666f7220486f6c64657273202e0a6173207468652063726561746f72206f6e6c79203125206f66206d7920486f6c64696e672077696c6c20426520646973747269627574656420596561726c792e0a486176652046756e2070726f666974696e6721", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731003850577.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SALMOND>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SALMOND>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

