module 0x3e0a9de340bb0320d22ddaa1568b4ece8188a950795531a8b9a719e796ca2a25::nowater {
    struct NOWATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOWATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOWATER>(arg0, 6, b"NoWater", b"De_sSert", b"No H2O here . No pussies! Only Chads", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_1d75e269e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOWATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOWATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

