module 0x6032d22190030f587d8b43392b7baa05d16940b4eb5d89a9d7a4be575e9daaf8::finx {
    struct FINX has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINX>(arg0, 6, b"FINX", b"Finorix", x"46696e6f7269782069732061207061696420696e766573746d656e7420636f6e73756c74616e637920706c6174666f726d2e205468652063757272656e63792075736564206f6e2074686520706c6174666f726d206973202446494e5820746f6b656e2e0a2446494e582069732074686520666972737420446546692d626173656420746f6b656e206f662074686520537569206e6574776f726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000096550_977d0cb07b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINX>>(v1);
    }

    // decompiled from Move bytecode v6
}

