module 0xd278e0289d95afbf9f85397c72564fd898b43ce18fc036ee675c6ba658533913::turkey {
    struct TURKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURKEY>(arg0, 6, b"TURKEY", b"Turkey On Sui", b"Turkey dinner usually comes with potatoes, yams, and stuffing but tbh this year lets switch it up and eat milfs like Yung Gravy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047928_04b4985756.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURKEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

