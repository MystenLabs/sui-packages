module 0x7a3e55401e549cae0e6a263c868e7bf8159445f3f09d3100507d99210cd8d259::shui {
    struct SHUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHUI>(arg0, 6, b"SHUI", b"FIRST SUI NAME($SHUI)", b"The name \"Sui\" for the Sui blockchain was derived from the Chinese word  (\"shu\"), which means \"water.\" This name was chosen to reflect qualities associated with water, such as fluidity, adaptability, and resilience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000817319_04b58e81fc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

