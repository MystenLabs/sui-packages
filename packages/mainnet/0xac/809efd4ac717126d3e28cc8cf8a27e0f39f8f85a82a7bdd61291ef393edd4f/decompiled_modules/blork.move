module 0xac809efd4ac717126d3e28cc8cf8a27e0f39f8f85a82a7bdd61291ef393edd4f::blork {
    struct BLORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLORK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLORK>(arg0, 6, b"Blork", b"GoldCornedBlork", b"Golden corned shit head ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1747769996329.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLORK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLORK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

