module 0x2f8e83ba2ee1881e9a4951bb576cb02566370aad83a058745be0737e4e4b0fb8::big {
    struct BIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIG>(arg0, 6, b"BIG", b"BIG COCK", b"BBC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950934430.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

