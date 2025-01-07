module 0x72b9cdc605aa7e06c7d828bf77f0cbf5af2be6f0916f94c25fe08a2ade54c939::jai {
    struct JAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAI>(arg0, 6, b"JAI", b"JELLY AI", x"f09f95b5efb88fe2808de29982efb88f436c75653a0a37362036352038352037382036372037322033322037382037392038370a0a4a414920544f4b454e20697320636f6d696e6720746f20537569204e6574776f726b207769746820616e204558504c4f5349564520666f72636521200a0a546869732069732074686520626174746c656669656c642c20746f6765746865722077652077696c6c207365652077686f2077696c6c2077696e20746865207761722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731007242508.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

