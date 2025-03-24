module 0xbceebac4b6f4261e2bea151a980daff533916ee5804a151b8ac569c2a40af46d::trdo {
    struct TRDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRDO>(arg0, 6, b"TRDO", b"Trinh Coin", b"Nice in the Wold", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/4653a868-b869-493d-847b-abeca2af69ca.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRDO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRDO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

