module 0x26e98adb99bdf4e4a9d86353193695bbd1763f0f69e321a4c9607150cb49a7c7::boxxx {
    struct BOXXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOXXX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOXXX>(arg0, 6, b"BOXXx", b"BOXX", b"g", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fork_ed5a2a9e06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOXXX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOXXX>>(v1);
    }

    // decompiled from Move bytecode v6
}

