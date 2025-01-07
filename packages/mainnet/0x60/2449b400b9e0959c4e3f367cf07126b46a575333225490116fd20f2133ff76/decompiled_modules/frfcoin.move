module 0x602449b400b9e0959c4e3f367cf07126b46a575333225490116fd20f2133ff76::frfcoin {
    struct FRFCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRFCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRFCOIN>(arg0, 6, b"FRFcoin", b"Free fire", x"24465246636f696e0a546563686e6f6c6f676965732067616d65732063727970746f63757272656e637920736f20667265656669726520465246636f696e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008611_3b354e884c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRFCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRFCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

