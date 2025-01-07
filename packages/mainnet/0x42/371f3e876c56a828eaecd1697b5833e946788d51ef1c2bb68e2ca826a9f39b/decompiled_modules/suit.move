module 0x42371f3e876c56a828eaecd1697b5833e946788d51ef1c2bb68e2ca826a9f39b::suit {
    struct SUIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIT>(arg0, 6, b"SUIT", b"tisSUI Toilet", x"2453554954206973206120436f6d6d756e697479206261736564204d656d65636f696e2e0a4265696e67206e6f2e312069732061207072696f726974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000082307_78789bc2b7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

