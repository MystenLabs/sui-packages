module 0x28cef9267f73a1348196d265cedae279639cfddef225b12222185ba9cf6f5be9::ozo {
    struct OZO has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZO>(arg0, 6, b"OZO", b"SUI OZO", b"The one and only $OZO, the rest are just wannabes. I'm here to claim my crown!  ...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ozo_4df4ad449b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OZO>>(v1);
    }

    // decompiled from Move bytecode v6
}

