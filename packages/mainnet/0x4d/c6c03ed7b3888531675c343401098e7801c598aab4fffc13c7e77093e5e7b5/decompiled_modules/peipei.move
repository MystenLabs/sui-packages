module 0x4dc6c03ed7b3888531675c343401098e7801c598aab4fffc13c7e77093e5e7b5::peipei {
    struct PEIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEIPEI>(arg0, 6, b"PEIPEI", b"PeiPei On Sui", x"5374657020696e746f20746865207265616c6d206f662050454950454920546f6b656e2c2077686572652074686520776f726c64206f66206d656d6573206d656574732074686520656e6368616e74696e6720657373656e6365206f66204368696e6573652063756c747572652e2047657420726561647920746f206578706c6f72652061206469676974616c20756e697665727365207468617420636f6d62696e65732068756d6f722c20636f6d6d756e6974792c20616e6420696e6e6f766174696f6e20696e20756e707265636564656e74656420776179732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pei_0075c92508.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEIPEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEIPEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

