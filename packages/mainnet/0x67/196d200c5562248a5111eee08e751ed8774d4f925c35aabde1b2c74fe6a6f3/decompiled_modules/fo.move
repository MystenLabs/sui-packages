module 0x67196d200c5562248a5111eee08e751ed8774d4f925c35aabde1b2c74fe6a6f3::fo {
    struct FO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FO>(arg0, 6, b"FO", b"Fred Octo", x"68747470733a2f2f782e636f6d2f4f736361724f6e5375690a68747470733a2f2f782e636f6d2f46726564546865506c6174797075730a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ON_Wqlvbz_400x400_5de16ac3fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FO>>(v1);
    }

    // decompiled from Move bytecode v6
}

